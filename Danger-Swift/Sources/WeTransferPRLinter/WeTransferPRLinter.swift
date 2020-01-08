import Danger
import Foundation

public enum WeTransferPRLinter {
    public static func lint() {
        let danger = Danger()
        lint(using: danger)
    }

    static func lint(using danger: DangerDSL) {
        let swiftFilesWithCopyright = danger.git.modifiedFiles.filter {
            $0.fileType == .swift
                && danger.utils.readFile($0).contains("//  Created by")
        }

        if swiftFilesWithCopyright.count > 0 {
            let files = swiftFilesWithCopyright.joined(separator: ", ")
            danger.warn("Please don't include copyright headers, found them in: \(files)")
        }
    }
}
