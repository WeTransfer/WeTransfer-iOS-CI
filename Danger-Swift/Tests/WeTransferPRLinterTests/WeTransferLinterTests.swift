import XCTest
@testable import WeTransferLinter

final class WeTransferLinterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WeTransferLinter().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
