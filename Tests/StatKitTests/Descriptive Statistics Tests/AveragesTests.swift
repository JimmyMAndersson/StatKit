import XCTest
@testable import StatKit

final class AveragesTests: XCTestCase {
  func testIntegerArithmeticMean() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedMean = intArray.arithmeticMean
    let expectedMean = 3.0
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
  func testFloatingPointArithmeticMean() {
    let fpArray = [1.5, 2.5, 3.5, 4.5, 5.5]
    let calculatedMean = fpArray.arithmeticMean
    let expectedMean = 3.5
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
  func testEmptySetArithmeticMean() {
    let emptySet = [Double]()
    let calculatedMean = emptySet.arithmeticMean
    
    XCTAssertTrue(calculatedMean.isNaN)
  }
  
  func testIntMedian() {
    let intArray = [-1, 4, 2, 20, 3]
    let calculatedMedian = intArray.median()
    let expectedMedian = 3.0
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testFloatingPointMedian() {
    let fpArray = [-1.0, 4.0, 2.0, 20.0, 3.0, 60.0]
    let calculatedMedian = fpArray.median()
    let expectedMedian = 3.5
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testEmptySetMedian() {
    let emptySet = [Double]()
    let calculatedMedian = emptySet.median()
    
    XCTAssertTrue(calculatedMedian.isNaN)
  }
  
  func testStringMode() {
    let string = "Protocol Oriented Programming is amazing!"
    let calculatedMode = string.mode()
    let expectedMode = Set<Character>(["i", "o", " ", "r"])
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    for element in calculatedMode {
      XCTAssert(expectedMode.contains(element))
    }
  }
  
  func testIntArrayMode() {
    let intArray = [1, 2, 3, 4, 5, 6, 4]
    let calculatedMode = intArray.mode()
    let expectedMode = Set<Int>([4])
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    for element in calculatedMode {
      XCTAssert(expectedMode.contains(element))
    }
  }
  
  func testDoubleSetMode() {
    let doubleSet = Set<Double>(arrayLiteral: 1, 2, 3, 4, 5, 6, 7, 5, 4)
    let calculatedMode = doubleSet.mode()
    let expectedMode = Set<Double>([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0])
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    for element in calculatedMode {
      XCTAssert(expectedMode.contains(element))
    }
  }
  
  func testEmptyStringMode() {
    let emptyString = ""
    let calculatedMode = emptyString.mode()
    let expectedMode = Set<Character>()
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
  }
}
