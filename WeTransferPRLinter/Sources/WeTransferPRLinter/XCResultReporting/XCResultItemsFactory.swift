import Foundation
import XCResultKit

/// A filter that can be used to hide specific results based on certain conditions.
public typealias ResultsFilter = (XCResultItem) -> Bool

struct XCResultItemsFactory {
    let resultFile: XCResultFile
    let resultsFilter: ResultsFilter?

    func make() -> [XCResultItem] {
        guard let invocationRecord = resultFile.getInvocationRecord() else {
            return [XCResultItem(message: "Could not get invocation record for \(resultFile.url.lastPathComponent)", category: .warning)]
        }

        var results = invocationRecord.createResults(resultFile: resultFile)
        if let resultsFilter = resultsFilter {
            results = results.filter(resultsFilter)
        }
        return results
    }
}
