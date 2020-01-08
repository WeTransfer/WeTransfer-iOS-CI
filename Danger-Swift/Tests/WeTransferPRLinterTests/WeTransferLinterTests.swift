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
        let danger = githubWithFilesDSL()
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

    /// It should warn for not using final with classes.
    func testFinalClass() {
        let danger = githubWithFilesDSL(created: ["file.swift"], fileMap: ["file.swift" : "class MyCustomType {"])
        WeTransferPRLinter.validateFiles(using: danger)
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.first?.message, "Consider using final for this class or use a struct (final_class)")
    }

    /// It should not warn for not using final with classes if the rule is disabled.
    func testFinalClassDisabled() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateFinalClasses(using: danger, file: "File.swift", lines: [
            "danger:disable final_class",
            "class MyCustomType {"
        ])
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should not warn for not using final with open classes.
    func testNotFinalForOpenClass() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateFinalClasses(using: danger, file: "File.swift", lines: [
            "open class MyCustomType {"
        ])
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should not warn for not using final inside comments.
    func testNotFinalForComments() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateFinalClasses(using: danger, file: "File.swift", lines: [
            "fatalError(\"Subclasses must implement `execute` without overriding super.\")",
            "/**",
            "This class",
            "*/",
            "/// class",
            "// class"
        ])
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should warn for using unowned self.
    func testUnownedSelfUsage() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateUnownedSelf(using: danger, file: "File.swift", lines: [
            "[weak self]",
            "[unowned self] _ in"
        ])
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.first?.message, "It is safer to use weak instead of unowned")
    }

    /// It should warn for empty method overrides.
    func testEmptyMethodOverrides() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateEmptyMethodOverrides(using: danger, file: "File.swift", lines: [
            "override func viewDidLoad() {",
            "super.viewDidLoad()",
            "}"
        ])
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.first?.message, "Override methods which only call super can be removed")
    }

    /// It should not warn for method overrides including closures.
    func testClosureMethodOverrides() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateEmptyMethodOverrides(using: danger, file: "File.swift", lines: [
            "override func viewDidLoad() {",
            "super.viewDidLoad()",
            "guard let download = self.download else { return }",
            "}"
        ])
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should warn for using // Mark: in big files without any mark.
    func testMarkUsage() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateMarkUsage(using: danger, file: "File.swift", lines: [
            "func myMethod() {",
            "print(\"something\")",
            "}"
        ], minimumLinesCount: 2)
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.first?.message, "Consider to place some `MARK:` lines for File.swift, which is over 2 lines big.")
    }

    /// It should not warn for using // Mark: in small files without any mark.
    func testMarkUsageSmallFiles() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateMarkUsage(using: danger, file: "File.swift", lines: [
            "func myMethod() {",
            "print(\"something\")",
            "}"
        ], minimumLinesCount: 5)
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should not warn for using // Mark: in big files if a mark is used.
    func testMarkAlreadyUsed() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateMarkUsage(using: danger, file: "File.swift", lines: [
            "MARK: Methods",
            "func myMethod() {",
            "print(\"something\")",
            "}"
        ], minimumLinesCount: 2)
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should not warn for using // Mark: in test files.
    func testMarkUsageInTests() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateMarkUsage(using: danger, file: "FileTests.swift", lines: [
            "func myMethod() {",
            "print(\"something\")",
            "}"
        ], minimumLinesCount: 2)
        XCTAssertEqual(danger.warnings.count, 0)
    }

    static var allTests = [
        ("testAllGood", testAllGood),
        ("testEmptyPRDescription", testEmptyPRDescription),
        ("testNonEmptyPRDescription", testNonEmptyPRDescription),
        ("testWorkInProgressLabel", testWorkInProgressLabel),
        ("testWorkInProgressTitle", testWorkInProgressTitle)
    ]
}
