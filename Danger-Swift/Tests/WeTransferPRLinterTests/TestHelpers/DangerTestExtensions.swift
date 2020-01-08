//
//  DangerTestExtensions.swift
//  WeTransferPRLinterTests
//
//  Created by Antoine van der Lee on 08/01/2020.
//

import Foundation
@testable import Danger
@testable import DangerFixtures

extension DangerDSL {
    enum TestOverride: String {
        case prDescription = "PR_DESCRIPTION_CONTENT"
    }

    typealias DangerTestSettings = [TestOverride: String]

    init(testSettings: DangerTestSettings) {
        var JSONString = TestDSLGitHubJSON

        testSettings.forEach { (testSetting) in
            JSONString = JSONString.replacingOccurrences(of: testSetting.key.rawValue, with: testSetting.value)
        }

        self = parseDangerDSL(with: JSONString)
    }
}
