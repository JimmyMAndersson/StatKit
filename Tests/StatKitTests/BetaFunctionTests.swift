#if !os(watchOS)

import XCTest
import StatKit

final class BetaFunctionTests: XCTestCase {
  func testBetaFunction() {
    XCTAssertEqual(betaFunction(alpha: 1, beta: 1), 1, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 2, beta: 1), 0.5, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 3, beta: 1), 0.33333, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 1, beta: 5), 0.2, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 1, beta: 10), 0.1, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 10, beta: 50), 1.591638e-12, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 100, beta: 100), 2.208761e-61, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 500, beta: 500), 1.479902e-302, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 7000, beta: 2), 2.040525e-08, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 50000, beta: 2), 3.99992e-10, accuracy: 1e-5)
  }
  
  func testLogBetaFunction() {
    XCTAssertEqual(betaFunction(alpha: 1, beta: 1, log: true), 0, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 2, beta: 1, log: true), -0.6931472, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 3, beta: 1, log: true), -1.0986123, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 1, beta: 5, log: true), -1.609438, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 1, beta: 10, log: true), -2.302585, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 10, beta: 50, log: true), -27.16626, accuracy: 1e-5)
    XCTAssertEqual(betaFunction(alpha: 100, beta: 100, log: true), -139.66526, accuracy: 1e-5)
  }
}

#endif
