#if !os(watchOS)

import XCTest
@testable import StatKit

final class CovarianceTests: XCTestCase {
  func testCGPointPositivePopulationCovariance() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let calculatedCovariance = cgPointArray.covariance(of: \.x, and: \.y, from: .population)
    let expectedCovariance = 51.5
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testCGPointNegativePopulationCovariance() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 3, y: 9),
                        CGPoint(x: 4, y: 8),
                        CGPoint(x: 6, y: 7),
                        CGPoint(x: 8, y: 6),
                        CGPoint(x: 10, y: 5),
                        CGPoint(x: 17, y: 4),
                        CGPoint(x: 20, y: 3),
                        CGPoint(x: 27, y: 2),
                        CGPoint(x: 30, y: 1)]
    
    let calculatedCovariance = cgPointArray.covariance(of: \.x, and: \.y, from: .population)
    let expectedCovariance = -27.2
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testPopulationCovarianceWithSingleVariable() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let calculatedCovariance = cgPointArray.covariance(of: \.x, and: \.x, from: .population)
    let expectedCovariance = cgPointArray.variance(of: \.x, from: .population)
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testCGPointPopulationCovariancePerformance() {
    measure {
      for _ in 1...100 {
        let cgPointArray = [CGPoint(x: 1, y: 10),
                            CGPoint(x: 2, y: 20),
                            CGPoint(x: 3, y: 27),
                            CGPoint(x: 4, y: 30),
                            CGPoint(x: 5, y: 35),
                            CGPoint(x: 6, y: 38),
                            CGPoint(x: 7, y: 49),
                            CGPoint(x: 8, y: 56),
                            CGPoint(x: 9, y: 62),
                            CGPoint(x: 10, y: 69)]
        
        _ = cgPointArray.covariance(of: \.x, and: \.y, from: .population)
      }
    }
  }
  
  func testPopulationCovarianceCommutativity() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let firstCovariance = cgPointArray.covariance(of: \.x, and: \.y, from: .population)
    let secondCovariance = cgPointArray.covariance(of: \.y, and: \.x, from: .population)
    
    XCTAssertEqual(firstCovariance, secondCovariance, accuracy: 0.00001)
  }
  
  func testCGPointPositiveSampleCovariance() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let calculatedCovariance = cgPointArray.covariance(of: \.x, and: \.y, from: .sample)
    let expectedCovariance = 57.22222
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testCGPointNegativeSampleCovariance() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 3, y: 9),
                        CGPoint(x: 4, y: 8),
                        CGPoint(x: 6, y: 7),
                        CGPoint(x: 8, y: 6),
                        CGPoint(x: 10, y: 5),
                        CGPoint(x: 17, y: 4),
                        CGPoint(x: 20, y: 3),
                        CGPoint(x: 27, y: 2),
                        CGPoint(x: 30, y: 1)]
    
    let calculatedCovariance = cgPointArray.covariance(of: \.x, and: \.y, from: .sample)
    let expectedCovariance = -30.22222
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testSampleCovarianceWithSingleVariable() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let calculatedCovariance = cgPointArray.covariance(of: \.x, and: \.x, from: .sample)
    let expectedCovariance = cgPointArray.variance(of: \.x, from: .sample)
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testCGPointSampleCovariancePerformance() {
    measure {
      for _ in 1...100 {
        let cgPointArray = [CGPoint(x: 1, y: 10),
                            CGPoint(x: 2, y: 20),
                            CGPoint(x: 3, y: 27),
                            CGPoint(x: 4, y: 30),
                            CGPoint(x: 5, y: 35),
                            CGPoint(x: 6, y: 38),
                            CGPoint(x: 7, y: 49),
                            CGPoint(x: 8, y: 56),
                            CGPoint(x: 9, y: 62),
                            CGPoint(x: 10, y: 69)]
        
        _ = cgPointArray.covariance(of: \.x, and: \.y, from: .sample)
      }
    }
  }
  
  func testSampleCovariancecommutativity() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let firstCovariance = cgPointArray.covariance(of: \.x, and: \.y, from: .sample)
    let secondCovariance = cgPointArray.covariance(of: \.y, and: \.x, from: .sample)
    
    XCTAssertEqual(firstCovariance, secondCovariance, accuracy: 0.00001)
  }
}

#endif
