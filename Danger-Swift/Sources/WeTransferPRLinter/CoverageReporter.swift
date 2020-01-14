//
//  CoverageReporter.swift
//  WeTransferPRLinter
//
//  Created by Antoine van der Lee on 09/01/2020.
//

import Foundation
import DangerSwiftCoverage
import Files

public typealias XCResultBundle = Folder

public protocol CoverageReporting {
    static func reportCoverage(for xcResultBundle: XCResultBundle, excludedTargets: [String])
}

public enum CoverageReporter: CoverageReporting {
    public static func reportCoverage(for xcResultBundle: XCResultBundle, excludedTargets: [String]) {
        print("Generating coverage report for \(xcResultBundle.name) excluding targets: \(excludedTargets)")
        Coverage.xcodeBuildCoverage(.xcresultBundle(xcResultBundle.path), minimumCoverage: 0, excludedTargets: excludedTargets, hideProjectCoverage: true)
    }
}

extension XCResultBundle {
    /// Extracts the project name from the results bundle file name.
    var projectName: String {
        name.removeExtension().replacingOccurrences(of: "-Package", with: "")
    }
}

private extension String {
    func removeExtension() -> String {
        guard let substring = split(separator: ".").first else { return self }
        return String(substring)
    }
}
