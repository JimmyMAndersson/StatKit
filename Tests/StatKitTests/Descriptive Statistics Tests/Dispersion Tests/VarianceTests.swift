#if !os(watchOS)

import XCTest
import StatKit
import RealModule

final class VariabilityTests: XCTestCase {
  func testIntegerSampleVariance() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedVariance = variance(of: intArray, variable: \.self, from: .sample)
    let expectedVariance = 2.5
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testIntegerPopulationVariance() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedVariance = variance(of: intArray, variable: \.self, from: .population)
    let expectedVariance = 2.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testFloatingPointSampleVariance() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedVariance = variance(of: fpArray, variable: \.self, from: .sample)
    let expectedVariance = 2.5
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testFloatingPointPopulationVariance() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedVariance = variance(of: fpArray, variable: \.self, from: .population)
    let expectedVariance = 2.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testEmptySetSampleVariance() {
    let emptySet = [Int]()
    let calculatedVariance = variance(of: emptySet, variable: \.self, from: .sample)
    
    XCTAssertTrue(calculatedVariance.isNaN)
  }
  
  func testSingleEntrySetSampleVariance() {
    let emptySet = [1]
    let calculatedVariance = variance(of: emptySet, variable: \.self, from: .sample)
    let expectedVariance = 0.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testIntegerSampleStandardDeviation() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = standardDeviation(of: intArray, variable: \.self, from: .sample)
    let expectedStandardDeviation = (2.5).squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testIntegerPopulationStandardDeviation() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = standardDeviation(of: intArray, variable: \.self, from: .population)
    let expectedStandardDeviation = 2.0.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testFloatingPointSampleStandardDeviation() {
    let fpArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = standardDeviation(of: fpArray, variable: \.self, from: .sample)
    let expectedStandardDeviation = 2.5.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testFloatingPointPopulationStandardDeviation() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedStandardDeviation = standardDeviation(of: fpArray, variable: \.self, from: .population)
    let expectedStandardDeviation = 2.0.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testEmptySetSampleStandardDeviation() {
    let emptySet = [Int]()
    let calculatedVariance = standardDeviation(of: emptySet, variable: \.self, from: .sample)
    
    XCTAssertTrue(calculatedVariance.isNaN)
  }
  
  func testSingleEntrySetSampleStandardDeviation() {
    let emptySet = [1]
    let calculatedVariance = standardDeviation(of: emptySet, variable: \.self, from: .sample)
    let expectedVariance = 0.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
}

#endif
