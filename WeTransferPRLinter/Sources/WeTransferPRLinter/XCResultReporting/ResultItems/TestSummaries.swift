import Foundation
import XCResultKit

/// Creates test summary messages like:
/// `StormTests: Executed 66 tests, with 0 failures in 9.181 seconds`
extension ActionRecord: XCResultItemsConvertible {
    func testPlanRunSummaries(resultFile: XCResultFile) -> ActionTestPlanRunSummaries? {
        guard let testsReferenceID = actionResult.testsRef?.id, let testPlanRunSummaries = resultFile.getTestPlanRunSummaries(id: testsReferenceID) else {
            return nil
        }
        return testPlanRunSummaries
    }

    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        guard let testPlanRunSummaries = testPlanRunSummaries(resultFile: context.resultFile) else {
            return []
        }

        let issueResultItems = actionResult.issues.createResults(context: context, testPlanRunSummaries: testPlanRunSummaries)

        let testPlanResultItems = testPlanRunSummaries.summaries.flatMap { testPlanRunSummary in
            testPlanRunSummary.testableSummaries.flatMap { actionTestableSummary in
                actionTestableSummary.createResults(context: context)
            }
        }

        return issueResultItems + testPlanResultItems
    }
}

extension ActionTestPlanRunSummaries {
    var failedTestIdentifiers: Set<String> {
        Set<String>(summaries.flatMap { $0.testableSummaries.flatMap { $0.failedTestIdentifiers }})
    }
}

extension ActionTestableSummary: XCResultItemsConvertible {
    var failedTestIdentifiers: Set<String> {
        tests.failedTestIdentifiers
    }

    var totalNumberOfTests: Int {
        tests.totalNumberOfTests
    }

    var totalDuration: String {
        let totalDuration: Double = tests.reduce(0) { totalDuration, testSummaryGroup in
            var totalDuration = totalDuration
            totalDuration += testSummaryGroup.duration
            return totalDuration
        }
        return String(format: "%.3f", totalDuration)
    }

    var totalNumberOfFailingTests: Int {
        failedTestIdentifiers.count
    }

    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        guard let targetName = targetName else { return [] }
        let message = "\(targetName): Executed \(totalNumberOfTests) tests, with \(totalNumberOfFailingTests) failures in \(totalDuration) seconds"
        return [XCResultItem(message: message, category: .message)]
    }
}

extension Array where Element == ActionTestSummaryGroup {
    var totalNumberOfTests: Int {
        reduce(0) { totalCount, testSummaryGroup in
            var totalCount = totalCount
            totalCount += testSummaryGroup.totalNumberOfTests
            return totalCount
        }
    }

    var failedTestIdentifiers: Set<String> {
        reduce([]) { identifiers, testSummaryGroup in
            identifiers.union(testSummaryGroup.failedTestIdentifiers)
        }
    }
}

extension ActionTestSummaryGroup {
    var totalNumberOfTests: Int {
        subtests.count + subtestGroups.totalNumberOfTests
    }

    var failedTestIdentifiers: Set<String> {
        subtests.failedTestIdentifiers.union(subtestGroups.failedTestIdentifiers)
    }
}

extension Array where Element == ActionTestMetadata {
    var failedTestIdentifiers: Set<String> {
        let successIdentifiers = Set<String>(filter { $0.testStatus == "Success" }.map { $0.identifier })
        let failedIdentifiers = Set<String>(filter { $0.testStatus == "Failure" }.map { $0.identifier })

        /// Substract success identifiers to filter out retried tests.
        return failedIdentifiers.subtracting(successIdentifiers)
    }
}
