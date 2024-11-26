#if !os(watchOS)

import XCTest
import StatKit

final class PearsonRTests: XCTestCase {
  func testPearsonR() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]

    let calculatedCorrelation = simd2Array.pearsonR(of: \.x, and: \.y)
    let expectedCorrelation = 0.99329456

    XCTAssertEqual(calculatedCorrelation, expectedCorrelation, accuracy: 1e-6)
  }

  func testPearsonRWithSingleVariable() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]

    let calculatedCorrelation = simd2Array.pearsonR(of: \.x, and: \.x)
    let expectedCorrelation = 1.0

    XCTAssertEqual(calculatedCorrelation, expectedCorrelation, accuracy: 1e-6)
  }

  func testPearsonRWithEmptyCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedCorrelation = simd2Array.pearsonR(of: \.x, and: \.y)

    XCTAssert(calculatedCorrelation.isNaN)
  }

  func testPearsonRWithConstantValueArray() {
    let simd2Array = [SIMD2(x: 1, y: 6),
                      SIMD2(x: 2, y: 6),
                      SIMD2(x: 3, y: 6),
                      SIMD2(x: 4, y: 6),
                      SIMD2(x: 5, y: 6),
                      SIMD2(x: 6, y: 6),
                      SIMD2(x: 7, y: 6),
                      SIMD2(x: 8, y: 6),
                      SIMD2(x: 9, y: 6),
                      SIMD2(x: 10, y: 6)]
    let calculatedCorrelation = simd2Array.pearsonR(of: \.x, and: \.y)

    XCTAssertTrue(calculatedCorrelation.isNaN)
  }
}

#endif
