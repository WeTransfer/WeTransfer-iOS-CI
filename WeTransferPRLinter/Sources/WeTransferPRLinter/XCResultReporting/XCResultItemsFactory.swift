import Foundation
import XCResultKit

/// A filter that can be used to hide specific results based on certain conditions.
public typealias ResultsFilter = (XCResultItem) -> Bool

struct ResultGenerationContext {
    let resultFile: XCResultFile
    let fileManager: FileManager
}

struct XCResultItemsFactory {
    let resultFile: XCResultFile
    let resultsFilter: ResultsFilter?
    var fileManager: FileManager = .default

    func make() -> [XCResultItem] {
        guard let invocationRecord = resultFile.getInvocationRecord() else {
            return [XCResultItem(message: "Could not get invocation record for \(resultFile.url.lastPathComponent)", category: .warning)]
        }

        let context = ResultGenerationContext(resultFile: resultFile, fileManager: fileManager)
        var results = invocationRecord.createResults(context: context)
        if let resultsFilter = resultsFilter {
            results = results.filter(resultsFilter)
        }
        return results
    }
}
