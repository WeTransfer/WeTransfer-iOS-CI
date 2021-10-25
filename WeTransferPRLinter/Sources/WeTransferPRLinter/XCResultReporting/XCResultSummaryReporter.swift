import Files
import Foundation
import XCResultKit
import Danger

public typealias XCResultSummaryContaining = Folder

public protocol XCResultSummaryReporting {
    static func reportXCResultSummary(for file: XCResultSummaryContaining, using danger: DangerDSL, fileManager: FileManager, resultsFilter: ResultsFilter?)
}

/// Fetches `XCResultItem` instances and reports them into the given `DangerDSL`.
public enum XCResultSummaryReporter: XCResultSummaryReporting {
    public static func reportXCResultSummary(for file: XCResultSummaryContaining, using danger: DangerDSL, fileManager: FileManager = .default, resultsFilter: ResultsFilter? = nil) {
        print("Generating XCResult Summary report for \(file.name)")

        let resultFile = XCResultFile(url: file.url)
        let results = XCResultItemsFactory(resultFile: resultFile, resultsFilter: resultsFilter, fileManager: fileManager).make()

        results.forEach { result in
            danger.report(result)
        }

        XCResultCoverageReporter(resultFile: resultFile, danger: danger).report(minimumCoverage: 0.8)
    }

}
