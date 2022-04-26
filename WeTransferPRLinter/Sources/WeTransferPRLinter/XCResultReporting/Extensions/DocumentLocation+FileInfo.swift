import Foundation
import XCResultKit

struct FileMetadata {
    let filename: String
    let line: Int
}

extension DocumentLocation {
    /// Returns `FileMetadata` for URLs like: `▿ file:///Users/josh/Projects/fastlane/test-ios/TestTests/TestTests.swift#CharacterRangeLen=0&EndingLineNumber=36&StartingLineNumber=36`
    /// by extracting the query parameters from it.
    /// - Parameter fileManager: The file manager to use for fetching the current execution directory.
    /// - Returns: The `FileMetadata` if it could be found.
    func fileMetadata(fileManager: FileManager = .default) -> FileMetadata? {
        guard let url = URL(string: url) else { return nil }

        // Replace # with ? so we can make use of the query parameters.
        let components = URLComponents(string: self.url.replacingOccurrences(of: "#", with: "?"))
        guard
            let lineString = components?.queryItems?.first(where: { $0.name == "StartingLineNumber" })?.value,
            let line = Int(lineString)
        else {
            return nil
        }

        let currentPath = fileManager.currentDirectoryPath.last == "/"
            ? fileManager.currentDirectoryPath
            : fileManager.currentDirectoryPath + "/"
        let path = url.path.deletingPrefix(currentPath)

        return FileMetadata(filename: path, line: line)
    }
}

private extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return String(self) }
        return String(dropFirst(prefix.count))
    }
}
