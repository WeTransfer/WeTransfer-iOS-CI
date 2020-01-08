import XCTest
@testable import WeTransferPRLinter
@testable import Danger
@testable import DangerFixtures

final class WeTransferLinterTests: XCTestCase {

    override func tearDown() {
        resetDangerResults()
        super.tearDown()
    }

    /// It should not create any warnings or errors if nothing is wrong.
    func testAllGood() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.lint(using: danger)

        XCTAssertEqual(danger.warnings.count, 0)
        XCTAssertEqual(danger.fails.count, 0)
    }

    /// It should warn for an empty PR description.
    func testEmptyPRDescription() {
        let danger = DangerDSL(testSettings: [
            .prDescription: ""
        ])
        WeTransferPRLinter.validatePRDescription(using: danger)
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.first?.message, "Please provide a summary in the Pull Request description")
    }

    /// It should not warn if a PR description is set.
    func testNonEmptyPRDescription() {
        let danger = DangerDSL(testSettings: [
            .prDescription: "This is a great PR with a lot of fixes"
        ])
        WeTransferPRLinter.validatePRDescription(using: danger)
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should warn for work in progress based on the label.
    func testWorkInProgressLabel() {
        let danger = DangerDSL(testSettings: [
            .prLabel: "WIP"
        ])
        WeTransferPRLinter.validateWorkInProgress(using: danger)
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.first?.message, "PR is classed as Work in Progress")
    }

    /// It should warn for work in progress based on the PR title.
    func testWorkInProgressTitle() {
        let danger = DangerDSL(testSettings: [
            .prTitle: "A work in progress title [WIP]"
        ])
        WeTransferPRLinter.validateWorkInProgress(using: danger)
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.first?.message, "PR is classed as Work in Progress")
    }

    static var allTests = [
        ("testAllGood", testAllGood),
        ("testEmptyPRDescription", testEmptyPRDescription),
        ("testNonEmptyPRDescription", testNonEmptyPRDescription),
        ("testWorkInProgressLabel", testWorkInProgressLabel),
        ("testWorkInProgressTitle", testWorkInProgressTitle)
    ]
}
