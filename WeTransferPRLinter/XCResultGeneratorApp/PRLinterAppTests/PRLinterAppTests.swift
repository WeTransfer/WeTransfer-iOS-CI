@testable import PRLinterApp
import XCTest

class PRLinterViewModelTests: XCTestCase {
    func testSuccessExample() {
        let viewModel = PRLinterViewModel()
        XCTAssertEqual(viewModel.printDescription(), "Antoine and age: 30")
    }

    func testFailingExample() {
        let viewModel = PRLinterViewModel()
        XCTAssertEqual(viewModel.printDescription(), "Antoine and age: 22")
    }

    func testSkippedExample() throws {
        try XCTSkipIf(true, "This test should be skipped")
    }

    func testFlaky() {
        XCTAssertTrue(Bool.random())
    }
}
