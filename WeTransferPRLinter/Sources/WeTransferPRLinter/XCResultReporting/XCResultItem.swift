import Foundation

public struct XCResultItem: Equatable, Hashable {
    public enum Category {
        case warning, error, message
    }

    public let message: String
    public var file: String?
    public var line: Int?
    public let category: Category
}
