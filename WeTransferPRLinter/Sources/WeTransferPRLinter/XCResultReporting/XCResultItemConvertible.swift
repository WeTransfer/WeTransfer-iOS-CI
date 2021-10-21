import XCResultKit
import Foundation

/// Defines a type that can be converted into `XCResultItem` instances.
protocol XCResultItemsConvertible {
    func createResults(resultFile: XCResultFile) -> [XCResultItem]
}

extension Array: XCResultItemsConvertible where Element: XCResultItemsConvertible {
    func createResults(resultFile: XCResultFile) -> [XCResultItem] {
        flatMap { $0.createResults(resultFile: resultFile) }
    }
}

extension ResultMetrics: XCResultItemsConvertible {
    func createResults(resultFile: XCResultFile) -> [XCResultItem] {
        guard let testsFailedCount = testsFailedCount, let testsCount = testsCount else {
            return []
        }

        return [
            XCResultItem(message: "Totally executed \(testsCount) tests, with \(testsFailedCount) failures", category: .message)
        ]
    }
}

extension ResultIssueSummaries: XCResultItemsConvertible {
    func createResults(resultFile: XCResultFile) -> [XCResultItem] {
        var results: [XCResultItem] = []
        results.append(contentsOf: testFailureSummaries.createResults(resultFile: resultFile))
        results.append(contentsOf: errorSummaries.createResults(category: .error))
        results.append(contentsOf: warningSummaries.createResults(category: .warning))
        return results
    }
}

extension TestFailureIssueSummary: XCResultItemsConvertible {
    func createResults(resultFile: XCResultFile) -> [XCResultItem] {
        let message = "**\(testCaseName): **<br />\(message)"
        let fileMetadata = documentLocationInCreatingWorkspace?.fileMetadata
        return [XCResultItem(message: message, file: fileMetadata?.filename, line: fileMetadata?.line, category: .error)]
    }
}

extension ActionsInvocationRecord: XCResultItemsConvertible {
    func createResults(resultFile: XCResultFile) -> [XCResultItem] {
        let resultFactories: [XCResultItemsConvertible] = [metrics, issues, actions]
        return resultFactories.flatMap { $0.createResults(resultFile: resultFile) }
    }
}

extension IssueSummary {
    func createResults(category: XCResultItem.Category) -> [XCResultItem] {
        let fileMetadata = documentLocationInCreatingWorkspace?.fileMetadata
        return [XCResultItem(message: message, file: fileMetadata?.filename, line: fileMetadata?.line, category: category)]
    }
}

extension Array where Element == IssueSummary {
    func createResults(category: XCResultItem.Category) -> [XCResultItem] {
        flatMap { $0.createResults(category: category) }
    }
}

extension ActionRecord: XCResultItemsConvertible {
    func createResults(resultFile: XCResultFile) -> [XCResultItem] {
        guard let testsReferenceID = actionResult.testsRef?.id, let testPlanRunSummaries = resultFile.getTestPlanRunSummaries(id: testsReferenceID) else {
            return []
        }

        return testPlanRunSummaries.summaries.flatMap { testPlanRunSummary in
            testPlanRunSummary.testableSummaries.flatMap { actionTestableSummary in
                actionTestableSummary.createResults(resultFile: resultFile)
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
        return String(format:"%.3f", totalDuration)
    }

    var totalNumberOfFailingTests: Int {
        tests.reduce(0) { totalCount, testSummaryGroup in
            var totalCount = totalCount
            totalCount += testSummaryGroup.totalNumberOfFailingTests
            return totalCount
        }
    }

    func createResults(resultFile: XCResultFile) -> [XCResultItem] {
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
