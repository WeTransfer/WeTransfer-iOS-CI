import XCTest
@testable import WeTransferPRLinter
@testable import Danger
@testable import DangerFixtures
import Files

final class WeTransferLinterTests: XCTestCase {

    private var buildFolder: Folder!

    override func setUp() {
        super.setUp()
        buildFolder = try! Folder.current.createSubfolderIfNeeded(withName: ".filesTest")
        try! buildFolder.empty()
    }

    override func tearDown() {
        try? buildFolder.delete()
        resetDangerResults()
        MockedSwiftLintExecutor.lintedFiles = [:]
        MockedCoverageReporter.reportedXCResultBundlesNames = []
        super.tearDown()
    }

    /// It should not create any warnings or errors if nothing is wrong.
    func testAllGood() {
        let danger = githubWithFilesDSL()
        WeTransferPRLinter.lint(using: danger, swiftLintExecutor: MockedSwiftLintExecutor.self, reportsPath: buildFolder.name)

        XCTAssertEqual(danger.warnings.count, 0)
        XCTAssertEqual(danger.fails.count, 0)
    }

    /// It should report code coverage for each xcresult file.
    func testCodeCoverageReport() throws {
        let danger = githubWithFilesDSL()
        let coverageReporter = MockedCoverageReporter.self
        let rabbitXCResultFileName = try buildFolder.createSubfolder(named: "Rabbit.test_result.xcresult").name
        let okapiXCResultFileName = try buildFolder.createSubfolder(named: "Okapi.test_result.xcresult").name
        WeTransferPRLinter.lint(using: danger, coverageReporter: coverageReporter, reportsPath: buildFolder.name)

        XCTAssertEqual(coverageReporter.reportedXCResultBundlesNames.count, 2)
        XCTAssertTrue(coverageReporter.reportedXCResultBundlesNames.contains(rabbitXCResultFileName))
        XCTAssertTrue(coverageReporter.reportedXCResultBundlesNames.contains(okapiXCResultFileName))
    }

    /// It should report an error if code coverage creation failed.
    func testCodeCoverageFailed() throws {
        let danger = githubWithFilesDSL()
        WeTransferPRLinter.lint(using: danger)
        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertTrue(danger.warnings.first?.message.contains("Code coverage generation failed with error") == true)
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

    /// It should show the Bitrise URL if it's set.
    func testBitriseURL() {
        let danger = DangerDSL(testSettings: [:])
        let bitriseURL = "www.fakeurl.com"
        WeTransferPRLinter.showBitriseBuildURL(using: danger, environmentVariables: ["BITRISE_BUILD_URL": bitriseURL])
        XCTAssertEqual(danger.messages.count, 1)
        XCTAssertEqual(danger.messages.first?.message, "View more details on <a href=\"\(bitriseURL)\" target=\"_blank\">Bitrise</a>")
    }

    /// It should correctly split files into test and non-test files.
    func testSwiftLintFileSplitting() {
        let danger = githubWithFilesDSL(created: ["ViewModel.swift", "ViewModelTests.swift", "Changelog.md", "RubyTests.rb"], fileMap: [:])
        let mockedSwiftLintExecutor = MockedSwiftLintExecutor.self
        WeTransferPRLinter.swiftLint(using: danger, executor: mockedSwiftLintExecutor)

        let nonTestFiles = mockedSwiftLintExecutor.lintedFiles.first(where: { !$0.key.contains("tests") })?.value
        let testFiles = mockedSwiftLintExecutor.lintedFiles.first(where: { $0.key.contains("tests") })?.value
        XCTAssertEqual(nonTestFiles, ["ViewModel.swift"])
        XCTAssertEqual(testFiles, ["ViewModelTests.swift"])
    }

    /// It should not trigger SwiftLint if there's no files to lint.
    func testSwiftLintSkippingForNoSwiftFiles() {
        let danger = githubWithFilesDSL(created: ["Changelog.md", "RubyTests.rb"], fileMap: [:])
        let mockedSwiftLintExecutor = MockedSwiftLintExecutor.self
        WeTransferPRLinter.swiftLint(using: danger, executor: mockedSwiftLintExecutor)

        XCTAssertEqual(mockedSwiftLintExecutor.lintedFiles, [:])
    }

    static var allTests = [
        ("testAllGood", testAllGood),
        ("testCodeCoverageReport", testCodeCoverageReport),
        ("testEmptyPRDescription", testEmptyPRDescription),
        ("testNonEmptyPRDescription", testNonEmptyPRDescription),
        ("testWorkInProgressLabel", testWorkInProgressLabel),
        ("testWorkInProgressTitle", testWorkInProgressTitle),
        ("testFinalClass", testFinalClass),
        ("testFinalClassDisabled", testFinalClassDisabled),
        ("testNotFinalForOpenClass", testNotFinalForOpenClass),
        ("testNotFinalForComments", testNotFinalForComments),
        ("testUnownedSelfUsage", testUnownedSelfUsage),
        ("testEmptyMethodOverrides", testEmptyMethodOverrides),
        ("testClosureMethodOverrides", testClosureMethodOverrides),
        ("testMarkUsage", testMarkUsage),
        ("testMarkUsageSmallFiles", testMarkUsageSmallFiles),
        ("testMarkAlreadyUsed", testMarkAlreadyUsed),
        ("testMarkUsageInTests", testMarkUsageInTests),
        ("testBitriseURL", testBitriseURL),
        ("testSwiftLintFileSplitting", testSwiftLintFileSplitting),
        ("testSwiftLintSkippingForNoSwiftFiles", testSwiftLintSkippingForNoSwiftFiles)
    ]
}
