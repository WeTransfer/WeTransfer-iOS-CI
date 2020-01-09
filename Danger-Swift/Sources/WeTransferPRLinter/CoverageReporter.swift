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
    static func reportCoverage(for xcresultBundle: XCResultBundle)
}

public enum CoverageReporter: CoverageReporting {
    public static func reportCoverage(for file: XCResultBundle) {
        print("Generating coverage report for \(file.name)")
        Coverage.xcodeBuildCoverage(.xcresultBundle(file.path), minimumCoverage: 0, hideProjectCoverage: true)
    }
}
