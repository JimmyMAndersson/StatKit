import XCTest
@testable import StatKit

final class VariabilityTests: XCTestCase {
  func testIntegerSampleVariance() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedVariance = intArray.variance(assuming: .sample)
    let expectedVariance = 2.5
    
    XCTAssertEqual(calculatedVariance, expectedVariance)
  }
  
  func testIntegerPopulationVariance() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedVariance = intArray.variance(assuming: .population)
    let expectedVariance = 2.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance)
  }
  
  func testFloatingPointSampleVariance() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedVariance = fpArray.variance(assuming: .sample)
    let expectedVariance = 2.5
    
    XCTAssertEqual(calculatedVariance, expectedVariance)
  }
  
  func testFloatingPointPopulationVariance() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedVariance = fpArray.variance(assuming: .population)
    let expectedVariance = 2.0
    
    XCTAssertEqual(calculatedVariance, expectedVariance)
  }
  
  func testIntegerSampleStandardDeviation() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = intArray.standardDeviation(assuming: .sample)
    let expectedStandardDeviation = (2.5).squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation)
  }
  
  func testIntegerPopulationStandardDeviation() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = intArray.standardDeviation(assuming: .population)
    let expectedStandardDeviation = 2.0.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation)
  }
  
  func testFloatingPointSampleStandardDeviation() {
    let fpArray = [1, 2, 3, 4, 5]
    let calculatedStandardDeviation = fpArray.standardDeviation(assuming: .sample)
    let expectedStandardDeviation = 2.5.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation)
  }
  
  func testFloatingPointPopulationStandardDeviation() {
    let fpArray = [1.0, 2.0, 3.0, 4.0, 5.0]
    let calculatedStandardDeviation = fpArray.standardDeviation(assuming: .population)
    let expectedStandardDeviation = 2.0.squareRoot()
    
    XCTAssertEqual(calculatedStandardDeviation, expectedStandardDeviation)
  }
}
