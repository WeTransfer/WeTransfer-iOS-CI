import Danger
import Files
import Foundation
import XCResultKit

public typealias XCResultSummaryContaining = Folder

public protocol XCResultSummaryReporting {
    static func reportXCResultSummary(
        for files: [XCResultSummaryContaining],
        using danger: DangerDSL,
        fileManager: FileManager,
        resultsFilter: ResultsFilter?
    )
}

/// Fetches `XCResultItem` instances and reports them into the given `DangerDSL`.
public enum XCResultSummaryReporter: XCResultSummaryReporting {
    public static func reportXCResultSummary(
        for files: [XCResultSummaryContaining],
        using danger: DangerDSL,
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

        results.forEach { result in
            danger.report(result)
        }

        XCResultCoverageReporter(resultFiles: resultFiles, danger: danger).report(minimumCoverage: 0.8)
    }
}
