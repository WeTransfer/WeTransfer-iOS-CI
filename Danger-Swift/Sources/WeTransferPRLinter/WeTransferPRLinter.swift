import Danger
import DangerXCodeSummary
import Files
import Foundation

public enum WeTransferPRLinter {
    public static func lint(using danger: DangerDSL = Danger(),
                            swiftLintExecutor: SwiftLintExecuting.Type = SwiftLintExecutor.self,
                            summaryReporter: XcodeSummaryReporting.Type = XcodeSummaryReporter.self,
                            coverageReporter: CoverageReporting.Type = CoverageReporter.self,
                            reportsPath: String = "build/reports",
                            swiftLintConfigsFolderPath: String? = nil)
    {
        reportXcodeSummary(using: danger, summaryReporter: summaryReporter, reportsPath: reportsPath)
        reportCodeCoverage(using: danger, coverageReporter: coverageReporter, reportsPath: reportsPath)
        validatePRDescription(using: danger)
        validateWorkInProgress(using: danger)
        validateFiles(using: danger)
        showBitriseBuildURL(using: danger)
        swiftLint(using: danger, executor: swiftLintExecutor, configsFolderPath: swiftLintConfigsFolderPath)
    }

    static func reportXcodeSummary(using danger: DangerDSL, summaryReporter: XcodeSummaryReporting.Type, reportsPath: String) {
        defer { print("\n") }

        do {
            let reportsFolder = try Folder(path: reportsPath)
            let summaryFiles = reportsFolder.files.filter { $0.extension == "json" }

            guard !summaryFiles.isEmpty else {
                return print("There were no files to create an Xcode Summary report for.")
            }

            print("Found Summary Reports:\n- \(summaryFiles.map(\.name).joined(separator: "\n- "))")

            summaryFiles.forEach { jsonFile in
                try? jsonFile.addFileNameToSummaryMessage()
                summaryReporter.reportXcodeSummary(for: jsonFile)
            }
        } catch {
            danger.warn("Xcode Summary failed with error: \(error).")
        }
    }

    static func reportCodeCoverage(using danger: DangerDSL, coverageReporter: CoverageReporting.Type, reportsPath: String) {
        defer { print("\n") }

        do {
            let reports = try Folder(path: reportsPath).subfolders
            let xcResultBundles = reports.filter { $0.extension == "xcresult" }

            guard !xcResultBundles.isEmpty else {
                return print("There were no files to create a code coverage report for.")
            }

            print("Found the following reports:\n- \(xcResultBundles.map(\.description).joined(separator: "\n- "))")
            let testTargetsToExclude = xcResultBundles.map { "\($0.projectName)Tests" }
            xcResultBundles.forEach { xcResultBundle in
                coverageReporter.reportCoverage(for: xcResultBundle, excludedTargets: testTargetsToExclude)
            }
        } catch {
            danger.warn("Code coverage generation failed with error: \(error).")
        }
    }

    /// Mainly to encourage writing up some reasoning about the PR, rather than just leaving a title.
    static func validatePRDescription(using danger: DangerDSL) {
        guard let description = danger.github.pullRequest.body, !description.isEmpty else {
            danger.warn("Please provide a summary in the Pull Request description")
            return
        }
    }

    /// Warn for PRs that are still work in progress.
    static func validateWorkInProgress(using danger: DangerDSL) {
        let hasWIPLabel = danger.github.issue.labels.contains(where: { $0.name.contains("WIP") })
        let hasWIPTitle = danger.github.pullRequest.title.contains("WIP")

        guard hasWIPLabel || hasWIPTitle else {
            return
        }
        danger.warn("PR is classed as Work in Progress")
    }

    /// Show the Bitrise build URL for easier access.
    static func showBitriseBuildURL(using danger: DangerDSL, environmentVariables: [String: String] = ProcessInfo.processInfo.environment) {
        guard let bitriseURL = environmentVariables["BITRISE_BUILD_URL"] else {
            print("Bitrise URL not found")
            return
        }
        danger.message("View more details on <a href=\"\(bitriseURL)\" target=\"_blank\">Bitrise</a>")
    }

    /// Triggers SwiftLint and makes use of specific configuration for tests and non-tests.
    static func swiftLint(using danger: DangerDSL, executor: SwiftLintExecuting.Type = SwiftLintExecutor.self, configsFolderPath: String? = nil) {
        defer { print("\n") }

        let configsFolderPath = configsFolderPath ?? "\(danger.utils.exec("pwd"))/Submodules/WeTransfer-iOS-CI/SwiftLint"
        print("Starting SwiftLint...")

        let files = danger.git.createdFiles + danger.git.modifiedFiles
        let nonTestFiles = files.filter { !$0.lowercased().contains("test") && $0.fileType == .swift }
        let testFiles = files.filter { $0.lowercased().contains("test") && $0.fileType == .swift }

        if !nonTestFiles.isEmpty {
            print("Linting non-test files:\n- \(nonTestFiles.joined(separator: "\n- "))")
            executor.lint(files: nonTestFiles, configFile: "\(configsFolderPath)/.swiftlint-source.yml")
        }

        if !testFiles.isEmpty {
            print("Linting test files:\n- \(testFiles.joined(separator: "\n- "))")
            executor.lint(files: testFiles, configFile: "\(configsFolderPath)/.swiftlint-tests.yml")
        }
    }
}

extension WeTransferPRLinter {
    /// Validates the added and modified files.
    static func validateFiles(using danger: DangerDSL) {
        let allFiles = Set(danger.git.createdFiles).union(danger.git.modifiedFiles)
        let swiftFiles = allFiles.filter { $0.fileType == FileType.swift }

        swiftFiles.forEach { file in
            let lines = danger.utils.readFile(file).components(separatedBy: .newlines)
            validateFinalClasses(using: danger, file: file, lines: lines)
            validateUnownedSelf(using: danger, file: file, lines: lines)
            validateEmptyMethodOverrides(using: danger, file: file, lines: lines)
            validateMarkUsage(using: danger, file: file, lines: lines)
        }
    }

    /// Warns and asks to use "final" in front of a non-final class.
    static func validateFinalClasses(using danger: DangerDSL, file: Danger.File, lines: [String]) {
        var isMultilineComment = false

        for (index, line) in lines.enumerated() {
            guard !line.contains("danger:disable final_class") else { return }
            if line.contains("/**") {
                isMultilineComment = true
            }
            if line.contains("*/") {
                isMultilineComment = false
            }
            guard !isMultilineComment, line.shouldBeFinalClass else { continue }

            danger.warn(message: "Consider using final for this class or use a struct (final_class)", file: file, line: index + 1)
        }
    }

    /// Warns if unowned is used. It's safer to use weak.
    static func validateUnownedSelf(using danger: DangerDSL, file: Danger.File, lines: [String]) {
        for (index, line) in lines.enumerated() {
            guard !line.contains("danger:disable unowned_self") else { return }
            guard line.contains("unowned self") else { continue }
            danger.warn(message: "It is safer to use weak instead of unowned", file: file, line: index + 1)
        }
    }

    /// Warns if a method override contains no addtional code.
    static func validateEmptyMethodOverrides(using danger: DangerDSL, file: Danger.File, lines: [String]) {
        for (index, line) in lines.enumerated() {
            guard
                line.contains("override"), !line.contains("\"override"), // To make sure it's not true for linting this repo.
                line.contains("func"),
                lines[index + 1].contains("super"),
                lines[index + 2].contains("}"),
                !lines[index + 2].contains("{")
            else { continue }
            danger.warn(message: "Override methods which only call super can be removed", file: file, line: index + 3)
        }
    }

    /// Warns if a big files is containing any MARK comments.
    static func validateMarkUsage(using danger: DangerDSL, file: Danger.File, lines: [String], minimumLinesCount: Int = 200) {
        guard !file.lowercased().contains("test"), lines.count >= minimumLinesCount else { return }
        let containsMark = lines.contains(where: { line in line.contains("MARK:") })
        guard !containsMark else { return }

        danger.warn("Consider to place some `MARK:` lines for \(file), which is over \(minimumLinesCount) lines big.")
    }
}

extension String {
    /// Whether the current String contains a class definition.
    var isClassDefinition: Bool {
        for nonClassElement in ["func", "//", "protocol", "\""] {
            guard !contains(nonClassElement) else { return false }
        }
        return contains("class")
    }

    /// Whether the class defined in the current line should be marked as final, if the current line contains a class.
    var shouldBeFinalClass: Bool {
        guard isClassDefinition else { return false }
        return !contains("final") && !contains("open")
    }
}
