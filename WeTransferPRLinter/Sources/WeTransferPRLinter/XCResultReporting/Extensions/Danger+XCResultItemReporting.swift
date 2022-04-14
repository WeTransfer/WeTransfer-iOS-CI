import Danger
import Foundation

extension DangerDSL {
    /// Reports the given result item based on the available metadata like file and line number.
    /// - Parameter resultItem: The result item to report to Danger.
    func report(_ resultItem: XCResultItem) {
        if let _ = resultItem.file, let _ = resultItem.line {
            switch resultItem.category {
            case .message:
                message(resultItem.message)
            case .error:
                fail(resultItem.message)
            case .warning:
                warn(resultItem.message)
            }
        } else {
            switch resultItem.category {
            case .message:
                message(resultItem.message)
            case .error:
                fail(resultItem.message)
            case .warning:
                warn(resultItem.message)
            }
        }
    }
}
