import Foundation
import XCResultKit

/// Summaries about the actions executed. Example:
/// `Totally executed 798 tests, with 3 failures`

extension ResultMetrics: XCResultItemsConvertible {
    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        guard let testsFailedCount = testsFailedCount, let testsCount = testsCount else {
            return []
        }

        return [
            XCResultItem(message: "Totally executed \(testsCount) tests, with \(testsFailedCount) failures", category: .message)
        ]
    }
}
