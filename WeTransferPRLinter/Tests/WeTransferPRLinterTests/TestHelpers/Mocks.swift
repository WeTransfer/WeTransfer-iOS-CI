@testable import Danger
import Foundation
@testable import WeTransferPRLinter

struct MockedSwiftLintExecutor: SwiftLintExecuting {
    static var lintedFiles: [String: [File]] = [:]

    static func lint(files: [File], configFile: String) {
        lintedFiles[configFile] = files
    }
}
