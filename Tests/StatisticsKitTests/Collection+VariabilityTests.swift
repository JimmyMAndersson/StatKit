import XCTest
@testable import StatisticsKit

final class CollectionVariabilityTests: XCTestCase {
  func testIntegerMean() {
    let intArray = [1, 2, 3, 4, 5]
    let calculatedMean = intArray.mean
    let expectedMean = 3.0
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
  func testFloatingPointMean() {
    let fpArray = [1.5, 2.5, 3.5, 4.5, 5.5]
    let calculatedMean = fpArray.mean
    let expectedMean = 3.5
    
    XCTAssertEqual(calculatedMean, expectedMean)
  }
  
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
    let fpArray = [1, 2, 3, 4, 5]
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
  
  func testFPMeanPerformance() {
    let fpArray = [Int](1...999).map { Double($0) }
    measure {
      for _ in 1...1000 {
        let mean = fpArray.mean
      }
    }
  }
  
  func testFPVariancePerformance() {
    let fpArray = [Int](1...999).map { Double($0) }
    measure {
      for _ in 1...1000 {
        let mean = fpArray.variance(assuming: .sample)
      }
    }
  }
  
  func testIntegerMeanPerformance() {
    let intArray = [Int](1...999)
    measure {
      for _ in 1...1000 {
        let mean = intArray.mean
      }
    }
  }
  
  func testIntegerVariancePerformance() {
    let intArray = [Int](1...999)
    measure {
      for _ in 1...1000 {
        let mean = intArray.variance(assuming: .sample)
      }
    }
  }
}

