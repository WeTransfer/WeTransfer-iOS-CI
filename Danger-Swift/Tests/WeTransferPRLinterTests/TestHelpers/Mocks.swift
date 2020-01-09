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

    static var reportedXCResultBundlesNames: [String] = []

    static func reportCoverage(for xcresultBundle: XCResultBundle) {
        reportedXCResultBundlesNames.append(xcresultBundle.name)
    }
}
