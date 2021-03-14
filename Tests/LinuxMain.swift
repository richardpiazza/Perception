import XCTest

import PerceptionTests

var tests = [XCTestCaseEntry]()
tests += PerceptionGameplayTests.allTests()
tests += PerceptionTests.allTests()
XCTMain(tests)
