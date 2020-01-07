import Danger
import Foundation

public func lint(using danger: DangerDSL) -> Void {
    let swiftFilesWithCopyright = danger.git.modifiedFiles.filter {
        $0.fileType == .swift
            && danger.utils.readFile($0).contains("//  Created by")
    }

    if swiftFilesWithCopyright.count > 0 {
        let files = swiftFilesWithCopyright.joined(separator: ", ")
        warn("Please don't include copyright headers, found them in: \(files)")
    }
}
