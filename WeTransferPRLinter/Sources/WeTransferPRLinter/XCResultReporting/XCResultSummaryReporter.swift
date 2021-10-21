import Files
import Foundation
import XCResultKit
import Danger

public typealias XCResultSummaryContaining = Folder

public protocol XCResultSummaryReporting {
    static func reportXCResultSummary(for file: XCResultSummaryContaining, using danger: DangerDSL, resultsFilter: ResultsFilter?)
}

public enum XCResultSummaryReporter: XCResultSummaryReporting {
    public static func reportXCResultSummary(for file: XCResultSummaryContaining, using danger: DangerDSL, resultsFilter: ResultsFilter? = nil) {
        print("Generating XCResult Summary report for \(file.name)")

        let resultFile = XCResultFile(url: file.url)
        let results = XCResultItemsFactory(resultFile: resultFile, resultsFilter: resultsFilter).make()
        
        results.forEach { result in
            danger.report(result)
        }
    }

}
