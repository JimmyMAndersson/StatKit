#if !os(watchOS)

import XCTest
import StatKit

final class VariabilityTests: XCTestCase {
  func testIntegerSampleVariance() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedVariance = intArray.variance(of: \.self, from: .sample)
    let expectedVariance = 2.5
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testIntegerPopulationVariance() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedVariance = intArray.variance(of: \.self, from: .population)
    let expectedVariance = 2.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testFloatingPointSampleVariance() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedVariance = fpArray.variance(of: \.self, from: .sample)
    let expectedVariance = 2.5
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testFloatingPointPopulationVariance() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedVariance = fpArray.variance(of: \.self, from: .population)
    let expectedVariance = 2.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testEmptySetSampleVariance() {
    let emptySet = [Int]()
    let calculatedVariance = emptySet.variance(of: \.self, from: .sample)
    
    XCTAssertTrue(calculatedVariance.isNaN)
  }
  
  func testSingleEntrySetSampleVariance() {
    let emptySet = [1]
    let calculatedVariance = emptySet.variance(of: \.self, from: .sample)
    let expectedVariance = 0.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
  
  func testIntegerSampleStandardDeviation() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = intArray.standardDeviation(of: \.self, from: .sample)
    let expectedStandardDeviation = (2.5).squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testIntegerPopulationStandardDeviation() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = intArray.standardDeviation(of: \.self, from: .population)
    let expectedStandardDeviation = 2.0.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testFloatingPointSampleStandardDeviation() {
    let fpArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = fpArray.standardDeviation(of: \.self, from: .sample)
    let expectedStandardDeviation = 2.5.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testFloatingPointPopulationStandardDeviation() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedStandardDeviation = fpArray.standardDeviation(of: \.self, from: .population)
    let expectedStandardDeviation = 2.0.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation, accuracy: 1e-6)
  }
  
  func testEmptySetSampleStandardDeviation() {
    let emptySet = [Int]()
    let calculatedVariance = emptySet.standardDeviation(of: \.self, from: .sample)
    
    XCTAssertTrue(calculatedVariance.isNaN)
  }
  
  func testSingleEntrySetSampleStandardDeviation() {
    let emptySet = [1]
    let calculatedVariance = emptySet.standardDeviation(of: \.self, from: .sample)
    let expectedVariance = 0.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance, accuracy: 1e-6)
  }
}

#endif
