import Danger
import Foundation

public enum WeTransferPRLinter {
    public static func lint(using danger: DangerDSL = Danger()) {
        validatePRDescription(using: danger)
        validateWorkInProgress(using: danger)
        validateFiles(using: danger)
        showBitriseBuildURL(using: danger)
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
            danger.message("Bitrise URL not found")
            return
        }
        danger.message("View more details on <a href=\"\(bitriseURL)\" target=\"_blank\">Bitrise</a>")
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
    static func validateFinalClasses(using danger: DangerDSL, file: File, lines: [String]) {
        guard !file.contains("danger:disable final_class") else { return }
        var isMultilineComment = false

        for (index, line) in lines.enumerated() {
            if line.contains("/**") {
                isMultilineComment = true
            }
            if line.contains("*/") {
                isMultilineComment = false
            }
            guard !isMultilineComment, line.shouldBeFinalClass else { return }

            danger.warn(message: "Consider using final for this class or use a struct (final_class)", file: file, line: index + 1)
        }
    }

    /// Warns if unowned is used. It's safer to use weak.
    static func validateUnownedSelf(using danger: DangerDSL, file: File, lines: [String]) {
        for (index, line) in lines.enumerated() {
            guard line.contains("unowned self") else { continue }
            danger.warn(message: "It is safer to use weak instead of unowned", file: file, line: index + 1)
        }
    }

    /// Warns if a method override contains no addtional code.
    static func validateEmptyMethodOverrides(using danger: DangerDSL, file: File, lines: [String]) {
        for (index, line) in lines.enumerated() {
            guard line.contains("override"), line.contains("func"), lines[index + 1].contains("super"), lines[index + 2].contains("}"), !lines[index + 2].contains("{") else { continue }
            danger.warn(message: "Override methods which only call super can be removed", file: file, line: index + 3)
        }
    }

    /// Warns if a big files is not containing any // MARK comments.
    static func validateMarkUsage(using danger: DangerDSL, file: File, lines: [String], minimumLinesCount: Int = 200) {
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
