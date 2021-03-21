#if !os(watchOS)

import XCTest
import StatKit

final class RangeTests: XCTestCase {
  func testIntegerArrayRange() {
    let array = [1, 2, 3, 4, 5]
    let calculatedRange = array.range(of: \.self)
    let expectedRange = 4.0
    
    XCTAssertEqual(calculatedRange, expectedRange, accuracy: 1e-5)
  }
  
  func testFloatingPointArrayRange() {
    let array = [1.5, 22.8, 3.1, 4.0, 5.3]
    let calculatedRange = array.range(of: \.self)
    let expectedRange = 21.3
    
    XCTAssertEqual(calculatedRange, expectedRange, accuracy: 1e-5)
  }
  
  func testEmptyArrayRange() {
    let array = [Int]()
    let calculatedRange = array.range(of: \.self)
    
    XCTAssertTrue(calculatedRange.isNaN)
  }
  
  func testObjectArrayRange() {
    let array = [SIMD2(x: 1, y: 2),
                 SIMD2(x: 6, y: -5),
                 SIMD2(x: 10, y: 19),
                 SIMD2(x: 28, y: 2)]
    
    let calculatedRange = array.range(of: \.y)
    let expectedRange = 24.0
    
    XCTAssertEqual(calculatedRange, expectedRange, accuracy: 1e-5)
  }
}

#endif
