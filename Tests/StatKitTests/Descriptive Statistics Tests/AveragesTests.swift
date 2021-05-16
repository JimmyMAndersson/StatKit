#if !os(watchOS)

import XCTest
import StatKit

final class AveragesTests: XCTestCase {
  func testIntegerArithmeticMean() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedMean = intArray.mean(of: \.self)
    let expectedMean = 3.0
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
  func testBigNumberIntegerArithmeticMean() {
    let value = Int.max / 9
    let bigIntArray = [9 * value, 6 * value, 3 * value]
    let calculatedMean = bigIntArray.mean(of: \.self)
    let expectedMean = Double(value * 6)
    
    XCTAssertEqual(calculatedMean, expectedMean, accuracy: 1e-6)
  }
  
  func testFloatingPointArithmeticMean() {
    let fpArray = [1.5, 2.5, 3.5, 4.5, 5.5]
    let calculatedMean = fpArray.mean(of: \.self)
    let expectedMean = 3.5
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
  func testObjectArithmeticMean() {
    let objectArray = [SIMD2(x: 0, y: 1), SIMD2(x: 1, y: 2), SIMD2(x: 2, y: 3)]
    let calculatedXMean = objectArray.mean(of: \.x)
    let expectedXMean = 1.0
    let calculatedYMean = objectArray.mean(of: \.y)
    let expectedYMean = 2.0
    
    XCTAssertEqual(calculatedXMean, expectedXMean)
    XCTAssertEqual(calculatedYMean, expectedYMean)
  }
  
  func testEmptySetArithmeticMean() {
    let emptySet = [Double]()
    let calculatedMean = emptySet.mean(of: \.self)
    
    XCTAssertTrue(calculatedMean.isNaN)
  }
  
  func testEvenCountMeanMedian() {
    let intArray = [-1, 4, 2, 20, 3, 6]
    let calculatedMedian = intArray.median(.mean, of: \.self)
    let expectedMedian = 3.5
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testOddCountMeanMedian() {
    let intArray = [-1, 4, 2, 20, 3]
    let calculatedMedian = intArray.median(.mean, of: \.self)
    let expectedMedian = 3.0
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testEvenCountLowMedian() {
    let intArray = [-1, 4, 2, 20, 3, 6]
    let calculatedMedian = intArray.median(.low, of: \.self)
    let expectedMedian = 3.0
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testOddCountLowMedian() {
    let intArray = [-1, 4, 2, 20, 3]
    let calculatedMedian = intArray.median(.low, of: \.self)
    let expectedMedian = 3.0
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testEvenCountHighMedian() {
    let intArray = [-1, 4, 2, 20, 3, 6]
    let calculatedMedian = intArray.median(.high, of: \.self)
    let expectedMedian = 4.0
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testOddCountHighMedian() {
    let intArray = [-1, 4, 2, 20, 3]
    let calculatedMedian = intArray.median(.high, of: \.self)
    let expectedMedian = 3.0
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testFloatingPointMedian() {
    let fpArray = [-1.0, 4.0, 2.0, 20.0, 3.0, 60.0]
    let calculatedMedian = fpArray.median(of: \.self)
    let expectedMedian = 3.5
    
    XCTAssertEqual(calculatedMedian, expectedMedian)
  }
  
  func testEmptySetMedian() {
    let emptySet = [Double]()
    let calculatedMedian = emptySet.median(of: \.self)
    
    XCTAssertTrue(calculatedMedian.isNaN)
  }
  
  func testStringMode() {
    let string = "Protocol Oriented Programming is amazing!"
    let calculatedMode = string.mode(of: \.self).sorted()
    let expectedMode = Set<Character>(["i", "o", " ", "r"]).sorted()
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    XCTAssert(calculatedMode == expectedMode)
  }
  
  func testIntArrayMode() {
    let intArray = [1, 2, 3, 4, 5, 6, 4]
    let calculatedMode = intArray.mode(of: \.self).sorted()
    let expectedMode = Set<Int>([4]).sorted()
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    XCTAssert(calculatedMode == expectedMode)
  }
  
  func testDoubleSetMode() {
    let doubleSet = Set<Double>(arrayLiteral: 1, 2, 3, 4, 5, 6, 7, 5, 4)
    let calculatedMode = doubleSet.mode(of: \.self).sorted()
    let expectedMode = Set<Double>([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0]).sorted()
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    XCTAssert(calculatedMode == expectedMode)
  }
  
  func testEmptyStringMode() {
    let emptyString = ""
    let calculatedMode = emptyString.mode(of: \.self).sorted()
    let expectedMode = Set<Character>().sorted()
    
    XCTAssertEqual(calculatedMode.count, expectedMode.count)
    XCTAssert(calculatedMode == expectedMode)
  }
  
  func testIntegerGeometricMean() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedMean = intArray.mean(.geometric, of: \.self)
    let expectedMean = 2.6051710847
    
    XCTAssertEqual(calculatedMean, expectedMean, accuracy: 1e-6)
  }
  
  func testFloatingPointGeometricMean() {
    let fpArray = [1.5, 2.5, 3.5, 4.5, 5.5]
    let calculatedMean = fpArray.mean(.geometric, of: \.self)
    let expectedMean = 3.1793248391
    
    XCTAssertEqual(calculatedMean, expectedMean, accuracy: 1e-6)
  }
  
  func testObjectGeometricMean() {
    let objectArray = [SIMD2(x: 3, y: 9), SIMD2(x: 3, y: 9), SIMD2(x: 3, y: 9)]
    let calculatedXMean = objectArray.mean(.geometric, of: \.x)
    let expectedXMean = 3.0
    let calculatedYMean = objectArray.mean(.geometric, of: \.y)
    let expectedYMean = 9.0
    
    XCTAssertEqual(calculatedXMean, expectedXMean, accuracy: 1e-6)
    XCTAssertEqual(calculatedYMean, expectedYMean, accuracy: 1e-6)
  }
  
  func testEmptySetGeometricMean() {
    let emptySet = [Int]()
    let calculatedMean = emptySet.mean(.geometric, of: \.self)
    
    XCTAssertTrue(calculatedMean.isNaN)
  }
  
  func testIntegerHarmonicMean() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedMean = intArray.mean(.harmonic, of: \.self)
    let expectedMean = 2.1897810218978
    
    XCTAssertEqual(calculatedMean, expectedMean, accuracy: 1e-6)
  }
  
  func testFloatingPointGHarmonicMean() {
    let fpArray = [1.5, 2.5, 3.5, 4.5, 5.5]
    let calculatedMean = fpArray.mean(.harmonic, of: \.self)
    let expectedMean = 2.8466973381531
    
    XCTAssertEqual(calculatedMean, expectedMean, accuracy: 1e-6)
  }
  
  func testObjectHarmonicMean() {
    let objectArray = [SIMD2(x: 3, y: 9), SIMD2(x: 3, y: 9), SIMD2(x: 3, y: 9)]
    let calculatedXMean = objectArray.mean(.harmonic, of: \.x)
    let expectedXMean = 3.0
    let calculatedYMean = objectArray.mean(.harmonic, of: \.y)
    let expectedYMean = 9.0
    
    XCTAssertEqual(calculatedXMean, expectedXMean, accuracy: 1e-6)
    XCTAssertEqual(calculatedYMean, expectedYMean, accuracy: 1e-6)
  }
  
  func testEmptySetHarmonicMean() {
    let emptySet = [Int]()
    let calculatedMean = emptySet.mean(.harmonic, of: \.self)
    
    XCTAssertTrue(calculatedMean.isNaN)
  }
}

#endif
