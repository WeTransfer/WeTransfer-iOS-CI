import Foundation
import XCResultKit

/// Summaries of errors, warnings, and test failures. Examples:
///
/// **ContentCreatorTests.testUnsupportedErrorItemProviderWithoutSupportedFileRepresentation():**
/// failed - Creating invalid content should give an error.
///
/// CoreExtensions/Sources/CoreExtensions/OptionalExtensions.swift#L15 - Initialization of variable 'property' was never used; consider replacing with assignment to '_' or removing it
extension ResultIssueSummaries: XCResultItemsConvertible {
    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        var results: [XCResultItem] = []
        results.append(contentsOf: testFailureSummaries.createResults(context: context))
        results.append(contentsOf: errorSummaries.createResults(category: .error, context: context))
        results.append(contentsOf: warningSummaries.createResults(category: .warning, context: context))
        return results
    }
}

extension TestFailureIssueSummary: XCResultItemsConvertible {
    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        let message = "**\(testCaseName):**<br/>\(message)"
        let fileMetadata = documentLocationInCreatingWorkspace?.fileMetadata(fileManager: context.fileManager)
        return [XCResultItem(message: message, file: fileMetadata?.filename, line: fileMetadata?.line, category: .error)]
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
