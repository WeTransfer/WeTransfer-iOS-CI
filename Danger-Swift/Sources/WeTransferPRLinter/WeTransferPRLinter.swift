import Danger
import Foundation

public enum WeTransferPRLinter {
    public static func lint(using danger: DangerDSL = Danger()) {
        validatePRDescription(using: danger)
        validateWorkInProgress(using: danger)
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
