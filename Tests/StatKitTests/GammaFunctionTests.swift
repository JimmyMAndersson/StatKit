#if !os(watchOS)

import XCTest
import StatKit

final class GammaFunctionTests: XCTestCase {
  func testPositiveGammaFunction() {
    XCTAssertEqual(gammaFunction(x: 1), 1)
    XCTAssertEqual(gammaFunction(x: 2), 1)
    XCTAssertEqual(gammaFunction(x: 3), 2)
    XCTAssertEqual(gammaFunction(x: 6), 120)
    XCTAssertEqual(gammaFunction(x: 11), 3628800)
  }
}

#endif
