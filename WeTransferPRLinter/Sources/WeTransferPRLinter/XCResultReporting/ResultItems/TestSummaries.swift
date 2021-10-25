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

        return testPlanRunSummaries.summaries.flatMap { testPlanRunSummary in
            testPlanRunSummary.testableSummaries.flatMap { actionTestableSummary in
                actionTestableSummary.createResults(context: context)
            }
        }
    }
}

extension ActionTestableSummary: XCResultItemsConvertible {
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
        tests.reduce(0) { totalCount, testSummaryGroup in
            var totalCount = totalCount
            totalCount += testSummaryGroup.totalNumberOfFailingTests
            return totalCount
        }
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

    var totalNumberOfFailingTests: Int {
        reduce(0) { totalCount, testSummaryGroup in
            var totalCount = totalCount
            totalCount += testSummaryGroup.totalNumberOfFailingTests
            return totalCount
        }
    }
}

extension ActionTestSummaryGroup {
    var totalNumberOfTests: Int {
        subtests.count + subtestGroups.totalNumberOfTests
    }

    var totalNumberOfFailingTests: Int {
        subtests.filter { $0.testStatus == "Failure" }.count + subtestGroups.totalNumberOfFailingTests
    }
}
