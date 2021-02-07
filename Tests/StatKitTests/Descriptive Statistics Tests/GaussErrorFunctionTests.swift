#if !os(watchOS)

import XCTest
import StatKit

final class GausErrorFunctionTests: XCTestCase {
  func testNonNegativeInputs() {
    XCTAssertEqual(GaussErrorFunction.erf(1), 0.842700793, accuracy: 1e-5)
    XCTAssertEqual(GaussErrorFunction.erf(5), 1.0, accuracy: 1e-5)
    XCTAssertEqual(GaussErrorFunction.erf(0.5), 0.5204998778, accuracy: 1e-5)
    XCTAssertEqual(GaussErrorFunction.erf(0.1), 0.112462916, accuracy: 1e-5)
    XCTAssertEqual(GaussErrorFunction.erf(0), 0.0, accuracy: 1e-5)
  }
  
  func testNegativeInputs() {
    XCTAssertEqual(GaussErrorFunction.erf(-1), -0.842700793, accuracy: 1e-5)
    XCTAssertEqual(GaussErrorFunction.erf(-5), -1.0, accuracy: 1e-5)
    XCTAssertEqual(GaussErrorFunction.erf(-0.5), -0.5204998778, accuracy: 1e-5)
    XCTAssertEqual(GaussErrorFunction.erf(-0.1), -0.112462916, accuracy: 1e-5)
  }
}

#endif
