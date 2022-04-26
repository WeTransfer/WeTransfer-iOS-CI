import Foundation
import XCResultKit

/// Summaries of errors, warnings, and test failures. Examples:
///
/// **ContentCreatorTests.testUnsupportedErrorItemProviderWithoutSupportedFileRepresentation():**
/// failed - Creating invalid content should give an error.
///
/// CoreExtensions/Sources/CoreExtensions/OptionalExtensions.swift#L15 - Initialization of variable 'property' was never used; consider replacing with assignment to '_' or removing it
extension ResultIssueSummaries {
    func createResults(context: ResultGenerationContext, testPlanRunSummaries: ActionTestPlanRunSummaries) -> [XCResultItem] {
        var results: [XCResultItem] = []
        results.append(contentsOf: testFailureSummaries.createResults(
            context: context,
            testPlanRunSummaries: testPlanRunSummaries
        ))
        results.append(contentsOf: errorSummaries.createResults(category: .error, context: context))
        results.append(contentsOf: warningSummaries.createResults(category: .warning, context: context))
        return results
    }
}

extension Array where Element == TestFailureIssueSummary {
    /// Test Failure Summaries contain all failed tests, even if they succeeded after retry.
    /// We can use this method to filter out retried tests and don't report them as failure,
    /// but instead show them as a warning.
    func createResults(context: ResultGenerationContext, testPlanRunSummaries: ActionTestPlanRunSummaries) -> [XCResultItem] {
        let failedTestIdentifiers = testPlanRunSummaries.failedTestIdentifiers
        let retriedTestIdentifiers = testPlanRunSummaries.retriedTestIdentifiers

        let failedAndRetryResults = compactMap { testFailureIssueSummary -> [XCResultItem]? in
            let identifier = testFailureIssueSummary.testCaseName.replacingOccurrences(of: ".", with: "/")
            if retriedTestIdentifiers.contains(identifier) {
                return testFailureIssueSummary.createTestRetriedResult(context: context, testPlanRunSummaries: testPlanRunSummaries)
            } else if failedTestIdentifiers.contains(identifier) {
                return testFailureIssueSummary.createTestFailureResult(context: context, testPlanRunSummaries: testPlanRunSummaries)
            }

            return nil
        }.flatMap { $0 }
        let skippedResults: [XCResultItem] = testPlanRunSummaries.skippedTests.compactMap { actionTestMetadata -> [XCResultItem]? in
            guard let summaryRef = actionTestMetadata.summaryRef else {
                return nil
            }
            guard let actionTestSummary = context.resultFile.getActionTestSummary(id: summaryRef.id) else {
                return nil
            }
            return actionTestSummary.createResults(context: context)
        }.flatMap { $0 }

        return failedAndRetryResults + skippedResults
    }
}

extension ActionTestSummary: XCResultItemsConvertible {
    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        guard let title = activitySummaries.first?.title else {
            return []
        }
        let message = "**\(identifier):**<br/>\(title)"
        return [XCResultItem(message: message, category: .warning)]
    }
}

extension TestFailureIssueSummary {
    func createTestFailureResult(context: ResultGenerationContext, testPlanRunSummaries: ActionTestPlanRunSummaries) -> [XCResultItem] {
        let message = "**\(testCaseName):**<br/>\(message)"
        let fileMetadata = documentLocationInCreatingWorkspace?.fileMetadata(fileManager: context.fileManager)
        return [XCResultItem(message: message, file: fileMetadata?.filename, line: fileMetadata?.line, category: .error)]
    }

    func createTestRetriedResult(context: ResultGenerationContext, testPlanRunSummaries: ActionTestPlanRunSummaries) -> [XCResultItem] {
        let message = "**\(testCaseName) succeeded after retry:**<br/>\(message)"
        let fileMetadata = documentLocationInCreatingWorkspace?.fileMetadata(fileManager: context.fileManager)
        return [XCResultItem(message: message, file: fileMetadata?.filename, line: fileMetadata?.line, category: .warning)]
    }
}

extension IssueSummary {
    func createResults(category: XCResultItem.Category, context: ResultGenerationContext) -> [XCResultItem] {
        let fileMetadata = documentLocationInCreatingWorkspace?.fileMetadata(fileManager: context.fileManager)
        return [XCResultItem(message: message, file: fileMetadata?.filename, line: fileMetadata?.line, category: category)]
    }
}

extension Array where Element == IssueSummary {
    func createResults(category: XCResultItem.Category, context: ResultGenerationContext) -> [XCResultItem] {
        flatMap { $0.createResults(category: category, context: context) }
    }
}
