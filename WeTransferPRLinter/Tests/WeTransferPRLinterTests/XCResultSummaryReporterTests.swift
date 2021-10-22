@testable import Danger
@testable import DangerFixtures
import Files
@testable import WeTransferPRLinter
import XCTest

// danger:disable unowned_self

final class XCResultSummartReporterTests: XCTestCase {
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
        MockedCoverageReporter.reportedXCResultBundlesNames = [:]
        MockedXcodeSummaryReporter.reportedSummaryFiles = []
        super.tearDown()
    }

    /// It should report XCResult files correctly when a package with multiple tests is executed.
    func testXCResultSummaryReportingForFullPackageTesting() throws {
        let xcResultFilename = "WeTransfer-iOS-SDK-Package.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let file = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try file.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let summaryReporter = MockedXcodeSummaryReporter.self

        WeTransferPRLinter.lint(using: danger, swiftLintExecutor: MockedSwiftLintExecutor.self, summaryReporter: summaryReporter, coverageReporter: MockedCoverageReporter.self, reportsPath: buildFolder.path)
        XCTAssertEqual(danger.messages.map { $0.message }, [
            "Totally executed 793 tests, with 11 failures",
            "ContentKitTests: Executed 148 tests, with 1 failures in 3.323 seconds",
            "CoreExtensionsTests: Executed 60 tests, with 0 failures in 0.152 seconds",
            "CoreUIKitTests: Executed 99 tests, with 0 failures in 3.413 seconds",
            "DeeplinkingTests: Executed 10 tests, with 0 failures in 0.018 seconds",
            "NetworkingTests: Executed 90 tests, with 0 failures in 5.234 seconds",
            "OkapiFirebaseTests: Executed 11 tests, with 0 failures in 0.017 seconds",
            "OkapiTests: Executed 20 tests, with 0 failures in 0.222 seconds",
            "ReceivingTests: Executed 39 tests, with 0 failures in 0.237 seconds",
            "SSOAuthenticationTests: Executed 14 tests, with 0 failures in 1.055 seconds",
            "SpaceshipAPITests: Executed 102 tests, with 0 failures in 21.979 seconds",
            "WeTransferAPITests: Executed 114 tests, with 6 failures in 70.232 seconds",
            "StormTests: Executed 65 tests, with 4 failures in 47.340 seconds",
            "MigrationKitTests: Executed 21 tests, with 0 failures in 2.109 seconds"
        ])
        XCTAssertEqual(danger.fails.count, 0)
    }

    /// It should report XCResult files correctly when a single package test is executed.
    func testXCResultSummaryReportingForSinglePackageTesting() throws {
        let xcResultFilename = "CoreExtensions.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let file = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try file.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let summaryReporter = MockedXcodeSummaryReporter.self
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath = "/Users/avanderlee/Documents/GIT-Projects/WeTransfer/WeTransfer-iOS-SDK/"

        WeTransferPRLinter.lint(using: danger, swiftLintExecutor: MockedSwiftLintExecutor.self, summaryReporter: summaryReporter, coverageReporter: MockedCoverageReporter.self, reportsPath: buildFolder.path, fileManager: stubbedFileManager)
        XCTAssertEqual(danger.messages.map { $0.message }, [
            "Totally executed 60 tests, with 1 failures",
            "CoreExtensionsTests: Executed 60 tests, with 1 failures in 0.688 seconds"
        ])
        let testFailure = try XCTUnwrap(danger.fails.first)
        XCTAssertEqual(testFailure.message, "**OptionalExtensionsTests.testStringNilIfEmpty():**<br/>XCTAssertNotNil failed")
        XCTAssertEqual(testFailure.file, "CoreExtensions/Tests/CoreExtensionsTests/OptionalExtensionsTests.swift")
        XCTAssertEqual(testFailure.line, 15)

        let warning = try XCTUnwrap(danger.warnings.first)
        XCTAssertEqual(warning.message, "Initialization of variable 'property' was never used; consider replacing with assignment to '_' or removing it")
        XCTAssertEqual(warning.file, "CoreExtensions/Sources/CoreExtensions/OptionalExtensions.swift")
        XCTAssertEqual(warning.line, 15)
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

private final class StubbedFileManager: FileManager {
    var stubbedCurrentDirectoryPath: String!

    override var currentDirectoryPath: String {
        return stubbedCurrentDirectoryPath
    }
}
