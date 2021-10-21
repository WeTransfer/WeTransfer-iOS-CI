import XCResultKit
import Foundation

struct FileMetadata {
    let filename: String
    let line: Int
}

extension DocumentLocation{
    var fileMetadata: FileMetadata? {
        guard let url = URL(string: url) else { return nil }

        // Replace # with ? so we can make use of the query parameters.
        let components = URLComponents(string: self.url.replacingOccurrences(of: "#", with: "?"))
        guard let lineString = components?.queryItems?.first(where: { $0.name == "StartingLineNumber" })?.value, let line = Int(lineString) else {
            return nil
        }
        return FileMetadata(filename: url.path, line: line)
    }
}
