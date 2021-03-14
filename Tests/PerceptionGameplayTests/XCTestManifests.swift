import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FillInTheBlankGameTests.allTests),
        testCase(SuperTriadGameTests.allTests),
        testCase(TraditionalGameTests.allTests),
    ]
}
#endif
