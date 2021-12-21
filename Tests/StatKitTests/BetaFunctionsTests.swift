import XCTest
import StatKit

final class BetaTests: XCTestCase {
  func testBeta() {
    XCTAssertEqual(beta(alpha: 1, beta: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 2, beta: 1), 0.5, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 3, beta: 1), 0.33333333333, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 1, beta: 5), 0.2, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 1, beta: 10), 0.1, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 10, beta: 50), 1.591638e-12, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 100, beta: 100), 2.208761e-61, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 500, beta: 500), 1.479902e-302, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 7000, beta: 2), 2.040525e-08, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 50000, beta: 2), 3.99992e-10, accuracy: 1e-6)
  }
  
  func testLogBeta() {
    XCTAssertEqual(beta(alpha: 1, beta: 1, logarithmic: true), 0, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 2, beta: 1, logarithmic: true), -0.6931472, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 3, beta: 1, logarithmic: true), -1.0986123, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 1, beta: 5, logarithmic: true), -1.609438, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 1, beta: 10, logarithmic: true), -2.302585, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 10, beta: 50, logarithmic: true), -27.16625743, accuracy: 1e-6)
    XCTAssertEqual(beta(alpha: 100, beta: 100, logarithmic: true), -139.66526, accuracy: 1e-6)
  }
}
