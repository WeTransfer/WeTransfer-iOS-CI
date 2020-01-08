import XCTest
@testable import WeTransferPRLinter
@testable import Danger
@testable import DangerFixtures

final class WeTransferLinterTests: XCTestCase {

    override func tearDown() {
        resetDangerResults()
        super.tearDown()
    }

    /// It should warn for an empty PR description.
    func testEmptyPRDescription() throws {
        let danger = DangerDSL(testSettings: [
            .prDescription: ""
        ])
        WeTransferPRLinter.validatePRDescription(using: danger)
        XCTAssertEqual(danger.warnings.count, 1)
        let message = try XCTUnwrap(danger.warnings.first?.message)
        XCTAssertEqual(message, "Please provide a summary in the Pull Request description")
    }

    /// It should not warn if a PR description is set.
    func testNonEmptyPRDescription() throws {
        let danger = DangerDSL(testSettings: [
            .prDescription: "This is a great PR with a lot of fixes"
        ])
        WeTransferPRLinter.validatePRDescription(using: danger)
        XCTAssertEqual(danger.warnings.count, 0)
    }

    static var allTests = [
        ("testEmptyPRDescription", testEmptyPRDescription),
        ("testNonEmptyPRDescription", testNonEmptyPRDescription)
    ]
}
