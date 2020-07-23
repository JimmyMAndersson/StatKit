#if !os(watchOS)

import XCTest

import StatKitTests

var tests = [XCTestCaseEntry]()
tests += StatKitTests.__allTests()

XCTMain(tests)

#endif
