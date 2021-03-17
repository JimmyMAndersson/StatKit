#if !os(watchOS)

import XCTest
import StatKit

final class BinomialCoefficientTests: XCTestCase {
  func testNonNegativeInput() {
    XCTAssertEqual(choose(n: 5, k: 0), 1)
    XCTAssertEqual(choose(n: 5, k: 1), 5)
    XCTAssertEqual(choose(n: 5, k: 2), 10)
    XCTAssertEqual(choose(n: 5, k: 3), 10)
    XCTAssertEqual(choose(n: 5, k: 4), 5)
    XCTAssertEqual(choose(n: 5, k: 5), 1)
    XCTAssertEqual(choose(n: 0, k: 5), 0)
    XCTAssertEqual(choose(n: 1, k: 10), 0)
    XCTAssertEqual(choose(n: 10, k: 1), 10)
  }
  
  func testNegativeInput() {
    XCTAssertEqual(choose(n: -5, k: -1), 0)
    XCTAssertEqual(choose(n: -5, k: -2), 0)
    XCTAssertEqual(choose(n: -5, k: -3), 0)
    XCTAssertEqual(choose(n: -5, k: -4), 0)
    XCTAssertEqual(choose(n: -5, k: -5), 1)
    XCTAssertEqual(choose(n: -3, k: -6), -10)
    XCTAssertEqual(choose(n: -1, k: 0), 1)
    XCTAssertEqual(choose(n: -128, k: -130), 8256)
  }
}

#endif
