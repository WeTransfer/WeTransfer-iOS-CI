//
//  XcodeSummaryReporter.swift
//  WeTransferPRLinter
//
//  Created by Antoine van der Lee on 13/01/2020.
//

import Foundation
import DangerXCodeSummary
import Files

public typealias XcodeSummaryContaining = File

public protocol XcodeSummaryReporting {
    static func reportXcodeSummary(for file: XcodeSummaryContaining)
}

public enum XcodeSummaryReporter: XcodeSummaryReporting {
    public static func reportXcodeSummary(for file: XcodeSummaryContaining) {
        print("Generating Xcode Summary report for \(file.name)")
        let summary = XCodeSummary(filePath: file.path)
        summary.report()
    }
}
