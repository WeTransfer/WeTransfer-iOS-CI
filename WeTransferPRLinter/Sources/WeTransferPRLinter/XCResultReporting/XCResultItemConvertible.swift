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
        let resultFactories: [XCResultItemsConvertible] = [
            /// Metrics like total tests.
            metrics,

            /// Warnings, errors, test failures.
            issues,

            /// Test summaries.
            actions
        ]
        return resultFactories.flatMap { $0.createResults(context: context) }
    }
}
