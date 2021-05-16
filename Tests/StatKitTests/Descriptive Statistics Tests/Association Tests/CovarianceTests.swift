#if !os(watchOS)

#if os(Linux)
import Glibc
#else
import Darwin
#endif

import XCTest
import StatKit

final class CovarianceTests: XCTestCase {
  func testSIMD2PositivePopulationCovariance() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let calculatedCovariance = simd2Array.covariance(of: \.x, and: \.y, from: .population)
    let expectedCovariance = 51.5
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 1e-6)
  }
  
  func testSIMD2NegativePopulationCovariance() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 3, y: 9),
                      SIMD2(x: 4, y: 8),
                      SIMD2(x: 6, y: 7),
                      SIMD2(x: 8, y: 6),
                      SIMD2(x: 10, y: 5),
                      SIMD2(x: 17, y: 4),
                      SIMD2(x: 20, y: 3),
                      SIMD2(x: 27, y: 2),
                      SIMD2(x: 30, y: 1)]
    
    let calculatedCovariance = simd2Array.covariance(of: \.x, and: \.y, from: .population)
    let expectedCovariance = -27.2
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 1e-6)
  }
  
  func testPopulationCovarianceWithSingleVariable() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let calculatedCovariance = simd2Array.covariance(of: \.x, and: \.x, from: .population)
    let expectedCovariance = simd2Array.variance(of: \.x, from: .population)
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 1e-6)
  }
  
  func testSIMD2PopulationCovariancePerformance() {
    measure {
      for _ in 1...100 {
        let simd2Array = [SIMD2(x: 1, y: 10),
                          SIMD2(x: 2, y: 20),
                          SIMD2(x: 3, y: 27),
                          SIMD2(x: 4, y: 30),
                          SIMD2(x: 5, y: 35),
                          SIMD2(x: 6, y: 38),
                          SIMD2(x: 7, y: 49),
                          SIMD2(x: 8, y: 56),
                          SIMD2(x: 9, y: 62),
                          SIMD2(x: 10, y: 69)]
        
        _ = simd2Array.covariance(of: \.x, and: \.y, from: .population)
      }
    }
  }
  
  func testPopulationCovarianceCommutativity() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let firstCovariance = simd2Array.covariance(of: \.x, and: \.y, from: .population)
    let secondCovariance = simd2Array.covariance(of: \.y, and: \.x, from: .population)
    
    XCTAssertEqual(firstCovariance, secondCovariance, accuracy: 1e-6)
  }
  
  func testSIMD2PositiveSampleCovariance() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let calculatedCovariance = simd2Array.covariance(of: \.x, and: \.y, from: .sample)
    let expectedCovariance = 57.222222222
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 1e-6)
  }
  
  func testSIMD2NegativeSampleCovariance() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 3, y: 9),
                      SIMD2(x: 4, y: 8),
                      SIMD2(x: 6, y: 7),
                      SIMD2(x: 8, y: 6),
                      SIMD2(x: 10, y: 5),
                      SIMD2(x: 17, y: 4),
                      SIMD2(x: 20, y: 3),
                      SIMD2(x: 27, y: 2),
                      SIMD2(x: 30, y: 1)]
    
    let calculatedCovariance = simd2Array.covariance(of: \.x, and: \.y, from: .sample)
    let expectedCovariance = -30.222222222
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 1e-6)
  }
  
  func testSampleCovarianceWithSingleVariable() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let calculatedCovariance = simd2Array.covariance(of: \.x, and: \.x, from: .sample)
    let expectedCovariance = simd2Array.variance(of: \.x, from: .sample)
    
    XCTAssertEqual(calculatedCovariance, expectedCovariance, accuracy: 1e-6)
  }
  
  func testSIMD2SampleCovariancePerformance() {
    measure {
      for _ in 1...100 {
        let simd2Array = [SIMD2(x: 1, y: 10),
                          SIMD2(x: 2, y: 20),
                          SIMD2(x: 3, y: 27),
                          SIMD2(x: 4, y: 30),
                          SIMD2(x: 5, y: 35),
                          SIMD2(x: 6, y: 38),
                          SIMD2(x: 7, y: 49),
                          SIMD2(x: 8, y: 56),
                          SIMD2(x: 9, y: 62),
                          SIMD2(x: 10, y: 69)]
        
        _ = simd2Array.covariance(of: \.x, and: \.y, from: .sample)
      }
    }
  }
  
  func testSampleCovariancecommutativity() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let firstCovariance = simd2Array.covariance(of: \.x, and: \.y, from: .sample)
    let secondCovariance = simd2Array.covariance(of: \.y, and: \.x, from: .sample)
    
    XCTAssertEqual(firstCovariance, secondCovariance, accuracy: 1e-6)
  }
}

#endif
