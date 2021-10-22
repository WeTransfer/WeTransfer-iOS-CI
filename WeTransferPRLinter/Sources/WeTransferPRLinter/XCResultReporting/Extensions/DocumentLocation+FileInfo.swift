import XCResultKit
import Foundation

struct FileMetadata {
    let filename: String
    let line: Int
}

extension DocumentLocation {
    func fileMetadata(fileManager: FileManager = .default) -> FileMetadata? {
        guard let url = URL(string: url) else { return nil }

        // Replace # with ? so we can make use of the query parameters.
        let components = URLComponents(string: self.url.replacingOccurrences(of: "#", with: "?"))
        guard let lineString = components?.queryItems?.first(where: { $0.name == "StartingLineNumber" })?.value, let line = Int(lineString) else {
            return nil
        }

        let currentPath = fileManager.currentDirectoryPath.last == "/" ? fileManager.currentDirectoryPath : fileManager.currentDirectoryPath + "/"
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
