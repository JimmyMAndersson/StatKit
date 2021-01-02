#if !os(watchOS)

import XCTest
@testable import StatKit

final class FactorialTests: XCTestCase {
  func testNonNegativeFactorial() {
    XCTAssertEqual(factorial(0), 1)
    XCTAssertEqual(factorial(1), 1)
    XCTAssertEqual(factorial(2), 2)
    XCTAssertEqual(factorial(5), 120)
  }
}

#endif
