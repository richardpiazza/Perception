import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CardTests.allTests),
        testCase(FillInTheBlankGameTests.allTests),
        testCase(TraditionalGameTests.allTests),
        testCase(TriadTests.allTests),
    ]
}
#endif
