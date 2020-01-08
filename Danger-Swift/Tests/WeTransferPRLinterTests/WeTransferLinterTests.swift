import XCTest
@testable import WeTransferPRLinter
@testable import Danger
@testable import DangerFixtures

final class WeTransferLinterTests: XCTestCase {
    func testWarnsWhenThereAreCreatedAtPrefixes() {
        // Arrange a custom Danger DSL to run against
        let danger = githubWithFilesDSL(modified: ["file.swift"], fileMap: ["file.swift": "//  Created by Orta"])
        // Act against running our check
        WeTransferPRLinter.lint(using: danger)
        // Assert the number of warnings has increased
        XCTAssertEqual(danger.warnings.count, 1)
    }

    func testDoesNotWarnWhenNoCreatedAt() {
        let danger = githubWithFilesDSL(modified: ["file.swift"], fileMap: ["file.swift": "{}"])
        WeTransferPRLinter.lint(using: danger)
        XCTAssertEqual(danger.warnings.count, 0)
    }

    static var allTests = [
        ("testWarnsWhenThereAreCreatedAtPrefixes", testWarnsWhenThereAreCreatedAtPrefixes),
        ("testDoesNotWarnWhenNoCreatedAt", testDoesNotWarnWhenNoCreatedAt)
    ]
}
