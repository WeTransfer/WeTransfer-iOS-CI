import Foundation
import XCResultKit
import Danger

struct XCResultCoverageReporter {
    let resultFile: XCResultFile
    let danger: DangerDSL

    func report(minimumCoverage: Double) {
        guard let coverage = resultFile.getCodeCoverage() else {
            danger.warn("Could not get code coverage report \(resultFile.url.lastPathComponent)")
            return
        }

        var markdown = "## Code Coverage Report\n"
        markdown += """
        | Name | Coverage ||
        | --- | --- | --- |\n
        """

        markdown += coverage.targets.compactMap { target in
            guard !target.name.contains(".xctest") else { return nil }
            return "\(target.name) | \(target.coverageDescription)% | \(target.lineCoverage > minimumCoverage ? "✅" : "⚠️")\n"
        }.joined()

        danger.markdown(markdown)
    }
}

extension CodeCoverageTarget {
    /// Converts e.g. `0.7142857142857143` into `71.43`.
    var coverageDescription: String {
        String(format:"%.2f", lineCoverage * 100)
    }
}
