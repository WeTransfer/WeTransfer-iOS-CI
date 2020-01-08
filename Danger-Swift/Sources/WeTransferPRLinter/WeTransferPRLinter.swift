import Danger
import Foundation

public enum WeTransferPRLinter {
    public static func lint(using danger: DangerDSL = Danger()) {
        validatePRDescription(using: danger)
        validateWorkInProgress(using: danger)
        validateFiles(using: danger)
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

        guard !hasWIPLabel, !hasWIPTitle else {
            danger.warn("PR is classed as Work in Progress")
            return
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
