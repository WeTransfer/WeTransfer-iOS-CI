import Foundation
import XCResultKit

/// Defines a type that can be converted into `XCResultItem` instances.
protocol XCResultItemsConvertible {
    func createResults(context: ResultGenerationContext) -> [XCResultItem]
}

extension Array: XCResultItemsConvertible where Element: XCResultItemsConvertible {
    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        flatMap { $0.createResults(context: context) }
    }
}

/// Combine all available summaries and return them as a collection of results.
extension ActionsInvocationRecord: XCResultItemsConvertible {
    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        /// Test summaries, warnings, errors, and failures.
        let actionsResults = actions.createResults(context: context)
        let warnings = issues.warningSummaries.createResults(category: .warning, context: context)
        let errors = issues.errorSummaries.createResults(category: .error, context: context)
        return actionsResults + warnings + errors
    }
}
