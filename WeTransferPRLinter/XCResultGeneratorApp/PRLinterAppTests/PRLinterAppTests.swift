//
//  PRLinterAppTests.swift
//  PRLinterAppTests
//
//  Created by Antoine van der Lee on 22/10/2021.
//

import XCTest
@testable import PRLinterApp

// Run this in the terminal:
// xcodebuild -scheme PRLinterApp -destination 'platform=iOS Simulator,name=iPhone 13' -resultBundlePath 'build/reports/PRLinterApp.xcresult' -enableCodeCoverage YES -parallel-testing-enabled NO -retry-tests-on-failure -test-iterations 3 test
//
/// 1. xcodebuild -scheme PRLinterApp -destination 'platform=iOS Simulator,name=iPhone 13' build-for-testing
/// 2. xcodebuild -scheme PRLinterApp -destination 'platform=iOS Simulator,name=iPhone 13' -resultBundlePath 'build/reports/PRLinterApp.xcresult' -enableCodeCoverage YES -parallel-testing-enabled NO -retry-tests-on-failure -test-iterations 3 test-without-building

// Only use `test` to make sure the XCResult file output is small in size.

class PRLinterViewModelTests: XCTestCase {

    func testSuccessExample() {
        let viewModel = PRLinterViewModel()
        XCTAssertEqual(viewModel.printDescription(), "Antoine and age: 30")
    }

    func testFailingExample() {
        let viewModel = PRLinterViewModel()
        XCTAssertEqual(viewModel.printDescription(), "Antoine and age: 22")
    }

    func testSkippedExample() throws {
        XCTExpectFailure(<#T##failureReason: String?##String?#>, options: <#T##XCTExpectedFailure.Options#>)
        try XCTSkipIf(true, "This test should be skipped")
    }

    func testFlaky() {
        XCTAssertTrue(Bool.random())
    }
}
