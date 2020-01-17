//
//  Mocks.swift
//  WeTransferPRLinterTests
//
//  Created by Antoine van der Lee on 09/01/2020.
//

import Foundation
@testable import WeTransferPRLinter
@testable import Danger

struct MockedSwiftLintExecutor: SwiftLintExecuting {

    static var lintedFiles: [String: [File]] = [:]

    static func lint(files: [File], configFile: String) {
        lintedFiles[configFile] = files
    }
}

struct MockedCoverageReporter: CoverageReporting {

    static var reportedXCResultBundlesNames: [String: [String]] = [:]

    static func reportCoverage(for xcResultBundle: XCResultBundle, excludedTargets: [String]) {
        reportedXCResultBundlesNames[xcResultBundle.name] = excludedTargets
    }
}

struct MockedXcodeSummaryReporter: XcodeSummaryReporting {
    static var reportedSummaryFiles: [XcodeSummaryContaining] = []

    static func reportXcodeSummary(for file: XcodeSummaryContaining) {
        reportedSummaryFiles.append(file)
    }
}
