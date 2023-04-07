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

        WeTransferPRLinter.lint(
            using: danger,
            swiftLintExecutor: MockedSwiftLintExecutor.self,
            reportsPath: buildFolder.path,
            fileManager: stubbedFileManager,
            environmentVariables: [:]
        )

        XCTAssertEqual(danger.messages.map(\.message).prefix(2), [
            "TestUITests: Executed 1 tests (0 failed, 0 retried, 0 skipped) in 16.058 seconds",
            "TestThisDude: Executed 6 tests (2 failed, 0 retried, 0 skipped) in 0.534 seconds"
        ])

        XCTAssertEqual(danger.warnings.count, 1)
        XCTAssertEqual(danger.warnings.map(\.message), [
            // swiftlint:disable:next line_length
            "DEBUG_INFORMATION_FORMAT should be set to dwarf-with-dsym for all configurations. This could also be a timing issue, make sure the Fabric run script build phase is the last build phase and no other scripts have moved the dSYM from the location Xcode generated it. Unable to process Some Test App.app.dSYM at path /Users/josh/Library/Developer/Xcode/DerivedData/Test-appjhtkjaewuhlggerdwreapskfh/Build/Products/Debug-iphonesimulator/Some Test App.app.dSYM"
        ])
        let warning = try XCTUnwrap(danger.warnings.first)
        XCTAssertNil(warning.file)
        XCTAssertNil(warning.line)

        XCTAssertEqual(danger.fails.count, 2)
        let failure = try XCTUnwrap(danger.fails.first)
        XCTAssertEqual(failure.message, "**TestTests.testFailureJosh1():**<br/>XCTAssertTrue failed")

        // This is expected to fail since GitHub currently doesn't support file and line reporting.
        // This test should succeed again once we re-enable line reporting.
        XCTExpectFailure {
            XCTAssertEqual(failure.file, "test-ios/TestTests/TestTests.swift")
            XCTAssertEqual(failure.line, 36)
        }
    }

    func testSlowestTestsReporting() throws {
        let xcResultFilename = "Trainer_example_result.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let file = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try file.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath = "/Users/josh/Projects/fastlane/"

        WeTransferPRLinter.lint(
            using: danger,
            swiftLintExecutor: MockedSwiftLintExecutor.self,
            reportsPath: buildFolder.path,
            fileManager: stubbedFileManager,
            environmentVariables: [:]
        )

        XCTAssertEqual(danger.messages.map(\.message).suffix(3), [
            "Slowest test: TestUITests/testExample() (16.052s)",
            "Slowest test: TestTests/testPerformanceExample() (0.266s)",
            "Slowest test: TestThisDude/testPerformanceExample() (0.253s)"
        ])
    }

    func testNotReportingRetriedSucceedingTest() throws {
        let xcResultFilename = "coverage_fail_flaky_skip_example.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let file = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try file.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath =
            "/Users/avanderlee/Developer/GIT-Projects/WeTransfer/Mule/Submodules/WeTransfer-iOS-CI/WeTransferPRLinter/XCResultGeneratorApp/"

        WeTransferPRLinter.lint(
            using: danger,
            swiftLintExecutor: MockedSwiftLintExecutor.self,
            reportsPath: buildFolder.path,
            fileManager: stubbedFileManager,
            environmentVariables: [:]
        )

        XCTAssertEqual(danger.messages.map(\.message).prefix(1), [
            "PRLinterAppTests: Executed 10 tests (1 failed, 1 retried, 1 skipped) in 0.097 seconds"
        ], "It should only report the actual failed test, instead of also the retried succeeded one")

        XCTAssertEqual(danger.warnings.count, 2)
        XCTAssertEqual(danger.warnings.map(\.message), [
            "**PRLinterViewModelTests.testFlaky() succeeded after retry:**<br/>XCTAssertTrue failed",
            "**PRLinterViewModelTests/testSkippedExample():**<br/>PRLinterAppTests.swift:32 Test skipped - This test should be skipped"
        ], "It should report a retried test including the retry count")

        XCTAssertEqual(danger.fails.count, 1)
        XCTAssertEqual(danger.fails.map(\.message), [
            // swiftlint:disable:next line_length
            "**PRLinterViewModelTests.testFailingExample():**<br/>XCTAssertEqual failed: (\"Antoine and age: 30\") is not equal to (\"Antoine and age: 22\")"
        ])
    }

    func testFilteringWarnings() throws {
        let xcResultFilename = "transfer_warnings_example.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let file = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try file.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath =
            "/Users/avanderlee/Developer/GIT-Projects/WeTransfer/Mule/Submodules/WeTransfer-iOS-CI/WeTransferPRLinter/XCResultGeneratorApp/"

        WeTransferPRLinter.lint(
            using: danger,
            swiftLintExecutor: MockedSwiftLintExecutor.self,
            reportsPath: buildFolder.path,
            fileManager: stubbedFileManager,
            environmentVariables: [:]
        )

        XCTAssertEqual(danger.messages.map(\.message).prefix(1), [
            "TransferTests: Executed 519 tests (0 failed, 0 retried, 0 skipped) in 39.226 seconds"
        ], "It should only report the actual failed test, instead of also the retried succeeded one")

        XCTAssertEqual(danger.warnings.count, 0)
        XCTAssertEqual(danger.fails.count, 0)
    }

    func testXCResultCoverageReporting() throws {
        let xcResultFilename = "coverage_fail_flaky_skip_example.xcresult"
        let xcResultFile = Bundle.module.url(forResource: "Resources/\(xcResultFilename)", withExtension: nil)!
        let xcResultFileTwo = xcResultFile.copied(newFileName: "coverage_fail_flaky_skip_example_two.xcresult")
        let fileOne = try Folder(path: xcResultFile.deletingLastPathComponent().path).subfolder(named: xcResultFilename)
        try fileOne.copy(to: buildFolder)

        let fileTwo = try Folder(path: xcResultFileTwo.deletingLastPathComponent().path)
            .subfolder(named: "coverage_fail_flaky_skip_example_two.xcresult")
        try fileTwo.copy(to: buildFolder)

        let danger = githubWithFilesDSL()
        let stubbedFileManager = StubbedFileManager()
        stubbedFileManager.stubbedCurrentDirectoryPath =
            "/Users/avanderlee/Developer/GIT-Projects/WeTransfer/Mule/Submodules/WeTransfer-iOS-CI/WeTransferPRLinter/XCResultGeneratorApp"

        WeTransferPRLinter.lint(
            using: danger,
            swiftLintExecutor: MockedSwiftLintExecutor.self,
            reportsPath: buildFolder.path,
            fileManager: stubbedFileManager,
            environmentVariables: [:]
        )

        XCTAssertEqual(danger.messages.map(\.message).filter { $0.contains("Executed") }, [
            "PRLinterAppTests: Executed 10 tests (1 failed, 1 retried, 1 skipped) in 0.097 seconds",
            "PRLinterAppTests: Executed 10 tests (1 failed, 1 retried, 1 skipped) in 0.097 seconds"
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

final class StubbedFileManager: FileManager {
    var stubbedCurrentDirectoryPath: String!
    var fileExists = false

    override var currentDirectoryPath: String {
        stubbedCurrentDirectoryPath
    }

    override func fileExists(atPath path: String, isDirectory: UnsafeMutablePointer<ObjCBool>?) -> Bool {
        fileExists
    }
}
