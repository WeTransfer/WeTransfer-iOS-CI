import Files
import Foundation

extension LocationError {
    var isMissingError: Bool {
        switch reason {
        case .missing:
            return true
        default:
            return false
        }
    }
}
