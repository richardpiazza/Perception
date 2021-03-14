import XCTest

import PerceptionTests
import PerceptionGameplayTests

var tests = [XCTestCaseEntry]()
tests += PerceptionGameplayTests.allTests()
tests += PerceptionTests.allTests()
XCTMain(tests)
