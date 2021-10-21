import Files
import Foundation
import XCResultKit
import Danger

public typealias XCResultSummaryContaining = Folder

/// A filter that can be used to hide specific results based on certain conditions.
public typealias ResultsFilter = (XCResultItem) -> Bool

public protocol XCResultSummaryReporting {
    static func reportXCResultSummary(for file: XCResultSummaryContaining, using danger: DangerDSL, resultsFilter: ResultsFilter?)
}

public enum XCResultSummaryReporter: XCResultSummaryReporting {
    public static func reportXCResultSummary(for file: XCResultSummaryContaining, using danger: DangerDSL, resultsFilter: ResultsFilter? = nil) {
        print("Generating XCResult Summary report for \(file.name)")

        let resultFile = XCResultFile(url: file.url)

        guard let invocationRecord = resultFile.getInvocationRecord() else {
            danger.warn("Could not get invocation record for \(file.name)")
            return
        }

        var results = invocationRecord.createResults()

        if let resultsFilter = resultsFilter {
            results = results.filter(resultsFilter)
        }
        
        results.forEach { result in
            if let file = result.file, let line = result.line {
                switch result.category {
                case .message:
                    danger.message(message: result.message, file: file, line: line)
                case .error:
                    danger.fail(message: result.message, file: file, line: line)
                case .warning:
                    danger.warn(message: result.message, file: file, line: line)
                }
            } else {
                switch result.category {
                case .message:
                    danger.message(result.message)
                case .error:
                    danger.fail(result.message)
                case .warning:
                    danger.warn(result.message)
                }
            }
        }
    }

}
