#if !os(watchOS)

import XCTest
@testable import StatKit

final class RangeTests: XCTestCase {
  func testIntegerArrayRange() {
    let array = [1, 2, 3, 4, 5]
    let calculatedRange = array.range(of: \.self)
    let expectedRange = 4.0
    
    XCTAssertEqual(calculatedRange, expectedRange, accuracy: 0.00001)
  }
  
  func testFloatingPointArrayRange() {
    let array = [1.5, 22.8, 3.1, 4.0, 5.3]
    let calculatedRange = array.range(of: \.self)
    let expectedRange = 21.3
    
    XCTAssertEqual(calculatedRange, expectedRange, accuracy: 0.00001)
  }
  
  func testEmptyArrayRange() {
    let array = [Int]()
    let calculatedRange = array.range(of: \.self)
    
    XCTAssertTrue(calculatedRange.isNaN)
  }
  
  func testObjectArrayRange() {
    let array = [CGPoint(x: 1, y: 2),
                 CGPoint(x: 6, y: -5),
                 CGPoint(x: 10, y: 19),
                 CGPoint(x: 28, y: 2)]
    
    let calculatedRange = array.range(of: \.y)
    let expectedRange = 24.0
    
    XCTAssertEqual(calculatedRange, expectedRange, accuracy: 0.00001)
  }
}

#endif
