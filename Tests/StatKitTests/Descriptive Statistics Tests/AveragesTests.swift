import XCTest
@testable import StatKit

final class AveragesTests: XCTestCase {
  func testIntegerArithmeticMean() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedMean = intArray.arithmeticMean(over: \.self)
    let expectedMean = 3.0
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
  func testFloatingPointArithmeticMean() {
    let fpArray = [1.5, 2.5, 3.5, 4.5, 5.5]
    let calculatedMean = fpArray.arithmeticMean(over: \.self)
    let expectedMean = 3.5
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
  func testObjectArithmeticMean() {
    let objectArray = [CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 2, y: 3)]
    let calculatedXMean = objectArray.arithmeticMean(over: \.x)
    let expectedXMean = 1.0
    let calculatedYMean = objectArray.arithmeticMean(over: \.y)
    let expectedYMean = 2.0
    
    XCTAssertEqual(calculatedXMean, expectedXMean)
    XCTAssertEqual(calculatedYMean, expectedYMean)
  }
  
  func testEmptySetArithmeticMean() {
    let emptySet = [Double]()
    let calculatedMean = emptySet.arithmeticMean(over: \.self)
    
    XCTAssertTrue(calculatedMean.isNaN)
  }
  
  func testIntMedian() {
    let intArray = [-1, 4, 2, 20, 3]
    let calculatedMedian = intArray.median(over: \.self)
    let expectedMedian = 3.0
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testFloatingPointMedian() {
    let fpArray = [-1.0, 4.0, 2.0, 20.0, 3.0, 60.0]
    let calculatedMedian = fpArray.median(over: \.self)
    let expectedMedian = 3.5
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testEmptySetMedian() {
    let emptySet = [Double]()
    let calculatedMedian = emptySet.median(over: \.self)
    
    XCTAssertTrue(calculatedMedian.isNaN)
  }
  
  func testStringMode() {
    let string = "Protocol Oriented Programming is amazing!"
    let calculatedMode = string.mode(over: \.self)
    let expectedMode = Set<Character>(["i", "o", " ", "r"])
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    for element in calculatedMode {
      XCTAssert(expectedMode.contains(element))
    }
  }
  
  func testIntArrayMode() {
    let intArray = [1, 2, 3, 4, 5, 6, 4]
    let calculatedMode = intArray.mode(over: \.self)
    let expectedMode = Set<Int>([4])
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    for element in calculatedMode {
      XCTAssert(expectedMode.contains(element))
    }
  }
  
  func testDoubleSetMode() {
    let doubleSet = Set<Double>(arrayLiteral: 1, 2, 3, 4, 5, 6, 7, 5, 4)
    let calculatedMode = doubleSet.mode(over: \.self)
    let expectedMode = Set<Double>([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0])
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    for element in calculatedMode {
      XCTAssert(expectedMode.contains(element))
    }
  }
  
  func testEmptyStringMode() {
    let emptyString = ""
    let calculatedMode = emptyString.mode(over: \.self)
    let expectedMode = Set<Character>()
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
  }
  
  func testIntegerGeometricMean() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedMean = intArray.geometricMean(over: \.self)
    let expectedMean = 2.6051710847
    
    XCTAssertEqual(calculatedMean, expectedMean, accuracy: 0.00001)
  }
  
  func testFloatingPointGeometricMean() {
    let fpArray = [1.5, 2.5, 3.5, 4.5, 5.5]
    let calculatedMean = fpArray.geometricMean(over: \.self)
    let expectedMean = 3.1793248391
    
    XCTAssertEqual(calculatedMean, expectedMean, accuracy: 0.000001)
  }
  
  func testObjectGeometricMean() {
    let objectArray = [CGPoint(x: 3, y: 9), CGPoint(x: 3, y: 9), CGPoint(x: 3, y: 9)]
    let calculatedXMean = objectArray.geometricMean(over: \.x)
    let expectedXMean = 3.0
    let calculatedYMean = objectArray.geometricMean(over: \.y)
    let expectedYMean = 9.0
    
    XCTAssertEqual(calculatedXMean, expectedXMean)
    XCTAssertEqual(calculatedYMean, expectedYMean, accuracy: 0.000000001)
    
  }
}
