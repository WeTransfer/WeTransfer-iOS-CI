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

        guard let invocationRecord = resultFile.getInvocationRecord() else {
            return
        }

        let testSummaries = invocationRecord.actions.map { $0.testPlanRunSummaries(resultFile: resultFile) }
        let testTargetNames = testSummaries.compactMap { $0?.summaries.flatMap { $0.testableSummaries.compactMap { $0.targetName }}}.flatMap { $0 }
        let coverageTargets = testTargetNames.map { targetName -> String in
            targetName.replacingOccurrences(of: "Tests", with: "")
        }

        var markdown = "## Code Coverage Report\n"
        markdown += """
        | Name | Coverage ||
        | --- | --- | --- |\n
        """

        markdown += coverage.targets.compactMap { target in
            guard coverageTargets.contains(target.coverageTargetName) else { return nil }
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

    /// Changes e.g. `PRLinterApp.framework` to `PRLinterApp`.
    var coverageTargetName: String {
        URL(fileURLWithPath: name).deletingPathExtension().lastPathComponent
    }
}
