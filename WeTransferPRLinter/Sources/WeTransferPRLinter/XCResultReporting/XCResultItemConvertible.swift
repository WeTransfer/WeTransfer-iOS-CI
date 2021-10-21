import XCResultKit
import Foundation

/// Defines a type that can be converted into `XCResultItem` instances.
protocol XCResultItemsConvertible {
    func createResults() -> [XCResultItem]
}

extension Array: XCResultItemsConvertible where Element: XCResultItemsConvertible {
    func createResults() -> [XCResultItem] {
        flatMap { $0.createResults() }
    }
}

extension ResultMetrics: XCResultItemsConvertible {
    func createResults() -> [XCResultItem] {
        guard let testsFailedCount = testsFailedCount, let testsCount = testsCount else {
            return []
        }

        return [
            XCResultItem(message: "Executed \(testsCount) tests, with \(testsFailedCount) failures", category: .message)
        ]
    }
}

extension ResultIssueSummaries: XCResultItemsConvertible {
    func createResults() -> [XCResultItem] {
        var results: [XCResultItem] = []
        results.append(contentsOf: testFailureSummaries.createResults())
        results.append(contentsOf: errorSummaries.createResults(category: .error))
        results.append(contentsOf: warningSummaries.createResults(category: .warning))
        return results
    }
}

extension TestFailureIssueSummary: XCResultItemsConvertible {
    func createResults() -> [XCResultItem] {
        let message = "**\(testCaseName): **<br />\(message)"
        let fileMetadata = documentLocationInCreatingWorkspace?.fileMetadata
        return [XCResultItem(message: message, file: fileMetadata?.filename, line: fileMetadata?.line, category: .error)]
    }
}

extension ActionsInvocationRecord: XCResultItemsConvertible {
    func createResults() -> [XCResultItem] {
        let resultFactories: [XCResultItemsConvertible] = [metrics, issues]
        return resultFactories.flatMap { $0.createResults() }
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
