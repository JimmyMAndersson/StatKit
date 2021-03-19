#if !os(watchOS)

import XCTest
import StatKit

final class BetaFunctionTests: XCTestCase {
  func testPositiveBetaFunction() {
    XCTAssertEqual(betaFunction(alpha: 1, beta: 1), 1, accuracy: 0.00001)
    XCTAssertEqual(betaFunction(alpha: 2, beta: 1), 0.5, accuracy: 0.00001)
    XCTAssertEqual(betaFunction(alpha: 3, beta: 1), 0.33333, accuracy: 0.00001)
    XCTAssertEqual(betaFunction(alpha: 1, beta: 5), 0.2, accuracy: 0.00001)
    XCTAssertEqual(betaFunction(alpha: 1, beta: 10), 0.1, accuracy: 0.00001)
  }
}

#endif
