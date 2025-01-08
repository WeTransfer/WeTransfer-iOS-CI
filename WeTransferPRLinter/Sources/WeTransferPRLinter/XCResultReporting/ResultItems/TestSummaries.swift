import Foundation
import XCResultKit

/// Creates test summary messages like:
/// `StormTests: Executed 66 tests, with 0 failures in 9.181 seconds`
extension ActionRecord: XCResultItemsConvertible {
    func testPlanRunSummaries(resultFile: XCResultFile) -> ActionTestPlanRunSummaries? {
        guard
            let testsReferenceID = actionResult.testsRef?.id,
            let testPlanRunSummaries = resultFile.getTestPlanRunSummaries(id: testsReferenceID)
        else {
            return nil
        }
        return testPlanRunSummaries
    }

    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        guard let testPlanRunSummaries = testPlanRunSummaries(resultFile: context.resultFile) else {
            return []
        }

        let issueResultItems = actionResult.issues.createResults(context: context, testPlanRunSummaries: testPlanRunSummaries)

        let testPlanResultItems = testPlanRunSummaries.summaries.flatMap { testPlanRunSummary in
            testPlanRunSummary.testableSummaries.flatMap { actionTestableSummary in
                actionTestableSummary.createResults(context: context)
            }
        }

        var slowestTestsItems: [XCResultItem] = []
        if #available(macOS 12.0, *) {
            slowestTestsItems = testPlanRunSummaries.createResultForSlowestTests()
        }
        return issueResultItems + testPlanResultItems + slowestTestsItems
    }
}

extension ActionTestPlanRunSummaries {
    /// - Returns: A set of identifiers for tests that failed, even after retrying.
    var failedTestIdentifiers: Set<String> {
        Set<String>(summaries.flatMap { $0.testableSummaries.flatMap(\.failedTestIdentifiers) })
    }

    /// - Returns: A set of identifiers for the tests that were retried.
    var retriedTestIdentifiers: Set<String> {
        Set<String>(summaries.flatMap { $0.testableSummaries.flatMap(\.retriedTestIdentifiers) })
    }

    /// - Returns: Metadata for all tests that were skipped.
    var skippedTests: [ActionTestMetadata] {
        summaries.flatMap { $0.testableSummaries.flatMap(\.skippedTests) }
    }

    var allTests: [ActionTestMetadata] {
        summaries.flatMap { $0.testableSummaries.flatMap(\.allTests) }
    }

    @available(macOS 12.0, *)
    func createResultForSlowestTests() -> [XCResultItem] {
        let allTests = allTests
        guard !allTests.isEmpty else { return [] }

        var durationThreshold: Double = 2
        var slowTestsLimit = 3

        if let envDurationThreshold = ProcessInfo.processInfo.environment["SLOW_TESTS_DURATION_THRESHOLD"] {
            durationThreshold = Double(envDurationThreshold) ?? durationThreshold
        }

        if let envSlowTestsLimit = ProcessInfo.processInfo.environment["SLOW_TESTS_LIMIT"] {
            slowTestsLimit = Int(envSlowTestsLimit) ?? slowTestsLimit
        }

        let slowestTests = allTests
            .sorted(using: KeyPathComparator(\.duration, order: .reverse))
            .filter { test in
                guard let duration = test.duration else { return false }
                /// Tests under our `durationThreshold` second are acceptable.
                return duration > durationThreshold
            }
            .prefix(slowTestsLimit)

        return slowestTests.compactMap { testMetadata in
            guard let duration = testMetadata.duration else { return nil }
            let durationString = String(format: "%.3fs", duration)
            return XCResultItem(message: "Slowest test: \(testMetadata.identifier ?? "<unknown>") (\(durationString))", category: .message)
        }
    }
}

extension ActionTestableSummary: XCResultItemsConvertible {
    var failedTestIdentifiers: Set<String> {
        tests.failedTestIdentifiers
    }

    var retriedTestIdentifiers: Set<String> {
        tests.retriedTestIdentifiers
    }

    var skippedTests: [ActionTestMetadata] {
        tests.skippedTests
    }

    var allTests: [ActionTestMetadata] {
        tests.allTests
    }

    var totalNumberOfTests: Int {
        tests.totalNumberOfTests
    }

    var totalDuration: String {
        let totalDuration: Double = tests.reduce(0) { totalDuration, testSummaryGroup in
            var totalDuration = totalDuration
            totalDuration += testSummaryGroup.duration
            return totalDuration
        }
        return String(format: "%.3f", totalDuration)
    }

    var totalNumberOfFailingTests: Int {
        failedTestIdentifiers.count
    }

    func createResults(context: ResultGenerationContext) -> [XCResultItem] {
        guard let targetName else { return [] }
        let message = "\(targetName): Executed \(totalNumberOfTests) tests (\(totalNumberOfFailingTests) failed,"
            + " \(retriedTestIdentifiers.count) retried, \(skippedTests.count) skipped) in \(totalDuration) seconds"
        return [XCResultItem(message: message, category: .message)]
    }
}

extension [ActionTestSummaryGroup] {
    var totalNumberOfTests: Int {
        reduce(0) { totalCount, testSummaryGroup in
            var totalCount = totalCount
            totalCount += testSummaryGroup.totalNumberOfTests
            return totalCount
        }
    }

    var failedTestIdentifiers: Set<String> {
        reduce([]) { identifiers, testSummaryGroup in
            identifiers.union(testSummaryGroup.failedTestIdentifiers)
        }
    }

    var retriedTestIdentifiers: Set<String> {
        reduce([]) { identifiers, testSummaryGroup in
            identifiers.union(testSummaryGroup.retriedTestIdentifiers)
        }
    }

    var skippedTests: [ActionTestMetadata] {
        reduce([]) { skippedTests, testSummaryGroup in
            skippedTests + testSummaryGroup.skippedTests
        }
    }

    var allTests: [ActionTestMetadata] {
        reduce([]) { skippedTests, testSummaryGroup in
            skippedTests + testSummaryGroup.allTests
        }
    }
}

extension ActionTestSummaryGroup {
    var totalNumberOfTests: Int {
        subtests.count + subtestGroups.totalNumberOfTests
    }

    var failedTestIdentifiers: Set<String> {
        subtests.failedTestIdentifiers.union(subtestGroups.failedTestIdentifiers)
    }

    var retriedTestIdentifiers: Set<String> {
        subtests.retriedTestIdentifiers.union(subtestGroups.retriedTestIdentifiers)
    }

    var skippedTests: [ActionTestMetadata] {
        subtests.skipped + subtestGroups.skippedTests
    }

    var allTests: [ActionTestMetadata] {
        subtests + subtestGroups.allTests
    }
}

extension [ActionTestMetadata] {
    private var successIdentifiers: Set<String> {
        Set<String>(filter { $0.testStatus == "Success" }.compactMap(\.identifier))
    }

    private var failedIdentifiers: Set<String> {
        Set<String>(filter { $0.testStatus == "Failure" }.compactMap(\.identifier))
    }

    var skipped: [ActionTestMetadata] {
        filter { $0.testStatus == "Skipped" }
    }

    var failedTestIdentifiers: Set<String> {
        /// Substract success identifiers to filter out retried tests.
        failedIdentifiers.subtracting(successIdentifiers)
    }

    var retriedTestIdentifiers: Set<String> {
        /// Tests that succeeded eventually intersect with failed tests.
        successIdentifiers.intersection(failedIdentifiers)
    }
}
