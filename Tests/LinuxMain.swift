import XCTest

import RunLoopWaiterTests

var tests = [XCTestCaseEntry]()
tests += RunLoopWaiterTests.allTests()
XCTMain(tests)
