@testable import Danger
@testable import DangerFixtures
import Foundation

/// Adds an option for overriding settings for testing.
extension DangerDSL {
    /// Available overrides. To add a new one, open the `TestDSLGitHubJSON` and add a key for replacement.
    enum TestOverride: String {
        case prDescription = "PR_DESCRIPTION_CONTENT"
        case prTitle = "PR_TITLE"
        case prLabel = "PR_LABEL"
    }

    typealias DangerTestSettings = [TestOverride: String]

    init(testSettings: DangerTestSettings) {
        var JSONString = TestDSLGitHubJSON

        testSettings.forEach { testSetting in
            JSONString = JSONString.replacingOccurrences(of: testSetting.key.rawValue, with: testSetting.value)
        }

        self = parseDangerDSL(with: JSONString)
    }
}
