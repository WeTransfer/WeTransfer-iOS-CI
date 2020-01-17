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

extension XcodeSummaryContaining {
    enum Error: Swift.Error {
        case updateSummaryContentFailed
    }
    /*
     Adds the file name in front of the summary message.
     E.g.:
     Executed 964 tests, with 0 failures (0 unexpected) in 135.257 (135.775) seconds

     Becomes:
     Rabbit: Executed 964 tests, with 0 failures (0 unexpected) in 135.257 (135.775) seconds
     */
    func addFileNameToSummaryMessage() throws {
        guard
            var json = try JSONSerialization.jsonObject(with: try read(), options: []) as? [String: Any],
            let summaryMessages = json["tests_summary_messages"] as? [String] else {
                throw Error.updateSummaryContentFailed
        }

        let name = String(self.name.split(separator: "_").first ?? "")
        let updatedSummaryMessages = summaryMessages.map { summaryMessage in
            return summaryMessage.replacingOccurrences(of: "Executed", with: "\(name): Executed")
        }

        json["tests_summary_messages"] = updatedSummaryMessages

        let updatedJSON = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        try write(updatedJSON)
    }
}
