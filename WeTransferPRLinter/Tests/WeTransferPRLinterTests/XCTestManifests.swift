import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(WeTransferLinterTests.allTests)
        ]
    }
#endif
