import Danger
import Files
import Foundation
import XCResultKit

public typealias XCResultSummaryContaining = Folder

public protocol XCResultSummaryReporting {
    static func reportXCResultSummary(
        for files: [XCResultSummaryContaining],
        using danger: DangerDSL,
        shouldReportWarnings: Bool,
        fileManager: FileManager,
        resultsFilter: ResultsFilter?
    )
}

/// Fetches `XCResultItem` instances and reports them into the given `DangerDSL`.
public enum XCResultSummaryReporter: XCResultSummaryReporting {
    public static func reportXCResultSummary(
        for files: [XCResultSummaryContaining],
        using danger: DangerDSL,
        shouldReportWarnings: Bool = false,
        fileManager: FileManager = .default,
        resultsFilter: ResultsFilter? = nil
    ) {
        let resultFiles = files.map { file in
            XCResultFile(url: file.url)
        }

        let results = resultFiles.flatMap { resultFile -> [XCResultItem] in
            print("Generating XCResult Summary report for \(resultFile.url.lastPathComponent)")
            return XCResultItemsFactory(resultFile: resultFile, resultsFilter: resultsFilter, fileManager: fileManager).make()
        }

        let resultsToReport = {
            if !shouldReportWarnings {
                let (filteredResults, warningsCount) = results.reduce(into: ([], 0)) { result, item in
                    item.category == .warning ? result.1 += 1 : result.0.append(item)
                }
                danger.report(.init(message: "Project has \(warningsCount) warnings", category: .warning))
                return filteredResults
            } else {
                return results
            }
        }()
        resultsToReport.forEach(danger.report)

        XCResultCoverageReporter(resultFiles: resultFiles, danger: danger).report(minimumCoverage: 0.8)
    }
}
