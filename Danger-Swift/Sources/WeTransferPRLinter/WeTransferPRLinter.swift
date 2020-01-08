import Danger
import Foundation

public enum WeTransferPRLinter {
    public static func lint() {
        let danger = Danger()
        validatePRDescription(using: danger)
    }

    /// Mainly to encourage writing up some reasoning about the PR, rather than just leaving a title.
    static func validatePRDescription(using danger: DangerDSL) {
        guard let description = danger.github.pullRequest.body, !description.isEmpty else {
            danger.warn("Please provide a summary in the Pull Request description")
            return
        }
    }
}
