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
        super.tearDown()
    }

    func testXCResultSummaryReporting() throws {
        let xcResultFilename = "Trainer_example_result.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let file = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try file.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath = "/Users/josh/Projects/fastlane/"

        WeTransferPRLinter.lint(using: danger, swiftLintExecutor: MockedSwiftLintExecutor.self, reportsPath: buildFolder.path, fileManager: stubbedFileManager, environmentVariables: [:])

        XCTAssertEqual(danger.messages.map(\.message), [
            "Totally executed 7 tests, with 2 failures",
            "TestUITests: Executed 1 tests, with 0 failures in 16.058 seconds",
            "TestThisDude: Executed 6 tests, with 2 failures in 0.534 seconds"
        ])

        XCTAssertEqual(danger.warnings.count, 2)
        XCTAssertEqual(danger.warnings.map(\.message), [
            "DEBUG_INFORMATION_FORMAT should be set to dwarf-with-dsym for all configurations. This could also be a timing issue, make sure the Fabric run script build phase is the last build phase and no other scripts have moved the dSYM from the location Xcode generated it. Unable to process Some Test App.app.dSYM at path /Users/josh/Library/Developer/Xcode/DerivedData/Test-appjhtkjaewuhlggerdwreapskfh/Build/Products/Debug-iphonesimulator/Some Test App.app.dSYM",
            "Could not get code coverage report Trainer_example_result.xcresult"
        ])
        let warning = try XCTUnwrap(danger.warnings.first)
        XCTAssertNil(warning.file)
        XCTAssertNil(warning.line)

        XCTAssertEqual(danger.fails.count, 2)
        let failure = try XCTUnwrap(danger.fails.first)
        XCTAssertEqual(failure.message, "**TestTests.testFailureJosh1():**<br/>XCTAssertTrue failed")
        XCTAssertEqual(failure.file, "test-ios/TestTests/TestTests.swift")
        XCTAssertEqual(failure.line, 36)
    }

    func testNotReportingRetriedSucceedingTest() throws {
        let xcResultFilename = "flaky_test_example.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let file = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try file.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath = "/Users/avanderlee/Developer/GIT-Projects/WeTransfer/Mule/Submodules/WeTransfer-iOS-SDK/"

        WeTransferPRLinter.lint(using: danger, swiftLintExecutor: MockedSwiftLintExecutor.self, reportsPath: buildFolder.path, fileManager: stubbedFileManager, environmentVariables: [:])

        XCTAssertEqual(danger.messages.map(\.message), [
            "OkapiFirebaseTests: Executed 13 tests, with 0 failures in 0.059 seconds"
        ])

        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.map(\.message), [
            "Failed to generate coverage for target \'OkapiFirebaseTests\' at paths (\n    \"/Users/avanderlee/Developer/GIT-Projects/WeTransfer/Mule/Submodules/WeTransfer-iOS-SDK/build/derived_data/Build/Products/Debug-iphonesimulator/OkapiFirebaseTests.xctest/OkapiFirebaseTests\"\n): No object file for requested architecture"
        ])

        XCTAssertEqual(danger.fails.count, 0)
        XCTAssertEqual(danger.fails.map(\.message), [])
    }

    func testXCResultCoverageReporting() throws {
        let xcResultFilename = "coverage_example.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let xcResultFileTwo = xcResultFile.copied(newFileName: "coverage_example_two.xcresult")
        let fileOne = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try fileOne.copy(to: buildFolder)

        let fileTwo = try Folder(path: xcResultFileTwo.deletingLastPathComponent().path).subfolder(named: "coverage_example_two.xcresult")
        try fileTwo.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath = "/Users/josh/Projects/fastlane/"

        WeTransferPRLinter.lint(using: danger, swiftLintExecutor: MockedSwiftLintExecutor.self, reportsPath: buildFolder.path, fileManager: stubbedFileManager, environmentVariables: [:])

        XCTAssertEqual(danger.messages.map(\.message), [
            "PRLinterAppTests: Executed 1 tests, with 0 failures in 0.004 seconds",
            "PRLinterAppTests: Executed 1 tests, with 0 failures in 0.004 seconds"
        ], "Both reports should be handled")

        XCTAssertEqual(danger.markdowns.count, 1, "Coverage reports should be combined")
        let coverageReport = try XCTUnwrap(danger.markdowns.first)
        XCTAssertEqual(coverageReport.message, """
        ## Code Coverage Report
        | Name | Coverage ||
        | --- | --- | --- |
        PRLinterApp.framework | 71.43% | ⚠️
        PRLinterApp.framework | 71.43% | ⚠️\n
        """)
    }
}

private extension URL {
    /// Creates a copy of the file at the current URL to prevent the original file from being affected.
    /// Files can get deleted after a test is cleaned up, making future tests fail.
    func copied(newFileName: String? = nil) -> URL {
        guard isFileURL else { fatalError("Can't copy a non-file URL") }

        let destinationDirectory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        try! FileManager.default.createDirectory(at: destinationDirectory, withIntermediateDirectories: false, attributes: nil)
        let newFileURL = destinationDirectory.appendingPathComponent(newFileName ?? lastPathComponent)
        try! FileManager.default.copyItem(at: self, to: newFileURL)
        assert(FileManager.default.fileExists(atPath: newFileURL.path), "Source file should exist")
        return newFileURL
    }
}

private final class StubbedFileManager: FileManager {
    var stubbedCurrentDirectoryPath: String!

    override var currentDirectoryPath: String {
        stubbedCurrentDirectoryPath
    }
}
