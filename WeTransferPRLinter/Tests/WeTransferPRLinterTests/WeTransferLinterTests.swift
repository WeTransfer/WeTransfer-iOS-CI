@testable import Danger
@testable import DangerFixtures
import Files
@testable import WeTransferPRLinter
import XCTest

// danger:disable unowned_self

final class WeTransferLinterTests: XCTestCase {
    private var buildFolder: Folder!

    override func setUp() {
        super.setUp()
        buildFolder = try! Folder.current.createSubfolderIfNeeded(withName: ".filesTest")
        try! buildFolder.empty()
    }

    override func tearDown() {
        XCTAssertNoThrow(try buildFolder.delete())
        resetDangerResults()
        MockedSwiftLintExecutor.lintedFiles = [:]
        super.tearDown()
    }

    /// It should not create any warnings or errors if nothing is wrong.
    func testAllGood() {
        let danger = githubWithFilesDSL()
        WeTransferPRLinter.lint(using: danger, swiftLintExecutor: MockedSwiftLintExecutor.self, reportsPath: buildFolder.name)

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

    /// It should warn for using Mark in big files without any mark.
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

    /// It should not warn for using Mark in small files without any mark.
    func testMarkUsageSmallFiles() {
        let danger = DangerDSL(testSettings: [:])
        WeTransferPRLinter.validateMarkUsage(using: danger, file: "File.swift", lines: [
            "func myMethod() {",
            "print(\"something\")",
            "}"
        ], minimumLinesCount: 5)
        XCTAssertEqual(danger.warnings.count, 0)
    }

    /// It should not warn for using Mark in big files if a mark is used.
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

    /// It should not warn for using Mark in test files.
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

    /// It should show the Simulator Build Download URL if it's set.
    func testSimulatorBuildDownloadURL() {
        let danger = DangerDSL(testSettings: [:])
        let url = "https://example.com"
        let targetName = "TargetName"
        WeTransferPRLinter.showSimulatorBuildDownloadURL(using: danger, environmentVariables: [
            "BITRISE_PERMANENT_DOWNLOAD_URL_MAP": "\(targetName).app.zip=>\(url)",
            "XCODE_TARGET": targetName
        ])
        XCTAssertEqual(danger.messages.count, 1)
        XCTAssertEqual(danger.messages.first?.message, "Download <a href=\"\(url)\" target=\"_blank\">Simulator Build</a>")
    }

    func testSwiftLintSkippingIfEnvVariableSet() {
        let danger = githubWithFilesDSL(created: ["File.swift"], fileMap: [:])
        let mockedSwiftLintExecutor = MockedSwiftLintExecutor.self
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.fileExists = true
        let customPath = "/Users/avanderlee/Projects/"
        WeTransferPRLinter.swiftLint(
            using: danger,
            executor: mockedSwiftLintExecutor,
            configsFolderPath: customPath,
            fileManager: stubbedFileManager,
            environmentVariables: ["DISABLE_DANGER_SWIFTLINT": "true"]
        )

        XCTAssertTrue(mockedSwiftLintExecutor.lintedFiles.isEmpty)
    }

    /// It should not trigger SwiftLint if there's no files to lint.
    func testSwiftLintSkippingForNoSwiftFiles() {
        let danger = githubWithFilesDSL(created: ["Changelog.md", "RubyTests.rb"], fileMap: [:])
        let mockedSwiftLintExecutor = MockedSwiftLintExecutor.self
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath = "/Users/tcook/GIT-Projects/WeTransfer"
        WeTransferPRLinter.swiftLint(using: danger, executor: mockedSwiftLintExecutor, fileManager: stubbedFileManager)

        XCTAssertEqual(mockedSwiftLintExecutor.lintedFiles, [:])
    }

    func testSwiftLintBackupConfigsFolder() {
        let danger = githubWithFilesDSL(created: ["File.swift"], fileMap: [:])
        let mockedSwiftLintExecutor = MockedSwiftLintExecutor.self
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath = "/Users/tcook/GIT-Projects/WeTransfer"
        WeTransferPRLinter.swiftLint(using: danger, executor: mockedSwiftLintExecutor, fileManager: stubbedFileManager)

        XCTAssertEqual(
            mockedSwiftLintExecutor.lintedFiles.keys.first,
            "/Users/tcook/GIT-Projects/WeTransfer/Submodules/WeTransfer-iOS-CI/BuildTools/.swiftlint.yml"
        )
    }

    func testSwiftLintFromGivenConfigsFolder() {
        let danger = githubWithFilesDSL(created: ["File.swift"], fileMap: [:])
        let mockedSwiftLintExecutor = MockedSwiftLintExecutor.self
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.fileExists = true
        let customPath = "/Users/avanderlee/Projects/"
        WeTransferPRLinter.swiftLint(
            using: danger,
            executor: mockedSwiftLintExecutor,
            configsFolderPath: customPath,
            fileManager: stubbedFileManager
        )

        XCTAssertEqual(mockedSwiftLintExecutor.lintedFiles.keys.first, "\(customPath)/.swiftlint.yml")
    }

    func testXCResultFileMissing() {
        let danger = githubWithFilesDSL(created: [], fileMap: [:])
        WeTransferPRLinter.reportXCResultsSummary(
            using: danger,
            summaryReporter: XCResultSummaryReporter.self,
            reportsPath: "file://faky/url",
            fileManager: .default
        )

        XCTAssertEqual(danger.warnings.count, 0)
        XCTAssertEqual(danger.messages.count, 1)
        XCTAssertEqual(danger.messages.map(\.message), [
            "No tests found for the current changes in file://faky/url"
        ])
    }
}

private extension URL {
    /// Creates a copy of the file at the current URL to prevent the original file from being affected.
    /// Files can get deleted after a test is cleaned up, making future tests fail.
    func copied() -> URL {
        guard isFileURL else { fatalError("Can't copy a non-file URL") }

        let destinationDirectory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        try! FileManager.default.createDirectory(at: destinationDirectory, withIntermediateDirectories: false, attributes: nil)
        let newFileURL = destinationDirectory.appendingPathComponent(lastPathComponent)
        try! FileManager.default.copyItem(at: self, to: newFileURL)
        assert(FileManager.default.fileExists(atPath: newFileURL.path), "Source file should exist")
        return newFileURL
    }
}
