import Danger
import Foundation

/// Defines a type that's capable of executing SwiftLint.
public protocol SwiftLintExecuting {
    static func lint(files: [Danger.File], configFile: String)
}

/// A simple facade for testing purposes that directly calls SwiftLint.
public enum SwiftLintExecutor: SwiftLintExecuting {
    public static func lint(files: [Danger.File], configFile: String) {
        SwiftLint.lint(
            .files(files),
            inline: false,
            configFile: configFile,
            quiet: true
        )
    }
}
