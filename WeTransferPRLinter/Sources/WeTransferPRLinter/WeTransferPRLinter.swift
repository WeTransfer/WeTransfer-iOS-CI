import Danger
import Files
import Foundation

// danger:disable unowned_self

public enum WeTransferPRLinter {
    public static func lint(
        using danger: DangerDSL = Danger(),
        swiftLintExecutor: SwiftLintExecuting.Type = SwiftLintExecutor.self,
        xcResultSummaryReporter: XCResultSummaryReporter.Type = XCResultSummaryReporter.self,
        reportsPath: String = "build/reports",
        swiftLintConfigsFolderPath: String? = nil,
        fileManager: FileManager = .default,
        environmentVariables: [String: String] = ProcessInfo.processInfo.environment
    ) {
        let skippedTests = environmentVariables["SKIP_TESTS"] == "true"

        measure(taskName: "XCResults Summary", skipIf: skippedTests, danger: danger) {
            reportXCResultsSummary(
                using: danger,
                summaryReporter: xcResultSummaryReporter,
                reportsPath: reportsPath,
                fileManager: fileManager
            )
        }

        measure(taskName: "PR Description Validation", danger: danger) {
            validatePRDescription(using: danger)
        }

        measure(taskName: "Validating Work in Progress", danger: danger) {
            validateWorkInProgress(using: danger)
        }

        measure(taskName: "Validating Files", danger: danger) {
            validateFiles(using: danger)
        }

        measure(taskName: "Bitrise URL showing", danger: danger) {
            showBitriseBuildURL(using: danger, environmentVariables: environmentVariables)
        }

        measure(taskName: "Simulator Download URL showing", danger: danger) {
            showSimulatorBuildDownloadURL(using: danger, environmentVariables: environmentVariables)
        }

        measure(taskName: "SwiftLint", skipIf: skippedTests, danger: danger) {
            swiftLint(using: danger, executor: swiftLintExecutor, configsFolderPath: swiftLintConfigsFolderPath, fileManager: fileManager, environmentVariables: environmentVariables)
        }
    }

    private static func measure(
        taskName: String,
        skipIf shouldSkip: Bool = false,
        danger: DangerDSL,
        task: () -> Void
    ) {
        guard !shouldSkip else {
            danger.message("Skipped running \(taskName) as `shouldSkip` returned true.")
            return
        }

        let startDate = Date()
        task()
        let differenceInSeconds = Int(Date().timeIntervalSince(startDate))
        print("Finished executing \(taskName) in \(differenceInSeconds) seconds")
    }

    static func reportXCResultsSummary(
        using danger: DangerDSL,
        summaryReporter: XCResultSummaryReporting.Type,
        reportsPath: String,
        fileManager: FileManager
    ) {
        defer { print("\n") }

        do {
            let reportsFolder = try Folder(path: reportsPath)
            let xcResultFiles = reportsFolder.subfolders.filter { $0.extension == "xcresult" }

            guard !xcResultFiles.isEmpty else {
                return print("There were no files to create an XCResult Summary report for.")
            }

            print("Found XCResult Summary Reports:\n- \(xcResultFiles.map(\.name).joined(separator: "\n- "))")

            let pathsToFilter: [String] = [
                "Submodules/",
                "SourcePackages/",
                ".build/",
                ".spm-build/"
            ]

            summaryReporter.reportXCResultSummary(for: xcResultFiles, using: danger, fileManager: fileManager) { result in
                guard let file = result.file else {
                    return true
                }

                /// Filter specific paths to make sure we don't display results from
                /// vendor packages, SPM packages, etc.
                for pathToFilter in pathsToFilter {
                    guard file.contains(pathToFilter) else {
                        continue
                    }
                    print("Filtered out \(file) for filtered path \(pathToFilter)")
                    return false
                }

                return true
            }
            print("Finished reporting XCResult summaries.")
        } catch let error as LocationError where error.isMissingError {
            danger.message("No tests found for the current changes in \(reportsPath)")
        } catch {
            danger.warn("XCResult Summary failed with error: \(error).")
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

    /// Show the simulator build download URL.
    static func showSimulatorBuildDownloadURL(
        using danger: DangerDSL,
        environmentVariables: [String: String] = ProcessInfo.processInfo.environment
    ) {
        // Example value in BITRISE_PERMANENT_DOWNLOAD_URL_MAP:
        // "Transfer.app.zip=>https://..."
        guard let map = environmentVariables["BITRISE_PERMANENT_DOWNLOAD_URL_MAP"]?.components(separatedBy: ","),
              let targetName = environmentVariables["XCODE_TARGET"],
              let simulatorBuildDownloadURL = map.first(where: { $0.hasPrefix("\(targetName).app.zip") }),
              let url = simulatorBuildDownloadURL.components(separatedBy: "=>").last
        else {
            print("Simulator build download URL not found")
            return
        }
        danger.message("Download <a href=\"\(url)\" target=\"_blank\">Simulator Build</a>")
    }

    /// Triggers SwiftLint.
    static func swiftLint(
        using danger: DangerDSL,
        executor: SwiftLintExecuting.Type = SwiftLintExecutor.self,
        configsFolderPath: String? = nil,
        fileManager: FileManager,
        environmentVariables: [String: String] = [:]
    ) {
        defer { print("\n") }

        guard environmentVariables["DISABLE_DANGER_SWIFTLINT"] != "true" else {
            return print("Skip SwiftLint linting since `disable_danger_swiftlint` environment variable was set.")
        }

        let configsFolderPath: String = {
            if let configsFolderPath, fileManager.fileExists(atPath: configsFolderPath, isDirectory: nil) {
                return configsFolderPath
            } else {
                return "\(fileManager.currentDirectoryPath)/Submodules/WeTransfer-iOS-CI/BuildTools"
            }
        }()
        print("Starting SwiftLint with configs folder path: \(configsFolderPath)...")
        let srcRoot = ProcessInfo.processInfo.environment["SRCROOT"]
        print("SRC Root for SwiftLint exclusions is \(srcRoot ?? "-")")

        let files = danger.git.createdFiles + danger.git.modifiedFiles
        let swiftFiles = files.filter { $0.fileType == .swift }

        if !swiftFiles.isEmpty {
            print("Linting files:\n- \(swiftFiles.joined(separator: "\n- "))")
            executor.lint(files: swiftFiles, configFile: "\(configsFolderPath)/.swiftlint.yml")
        } else {
            print("No files found to lint")
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
            validateMarkUsage(using: danger, file: file, lines: lines)
        }
    }

    /// Warns if a big files is containing any MARK comments.
    static func validateMarkUsage(using danger: DangerDSL, file: Danger.File, lines: [String], minimumLinesCount: Int = 300) {
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
