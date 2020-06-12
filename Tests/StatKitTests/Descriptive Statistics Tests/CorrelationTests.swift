import XCTest
@testable import StatKit

final class CorrelationTests: XCTestCase {
  func testCGPointPositiveCovariance() {
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
    
    let calculatedVariance = cgPointArray.covariance(of: \.x, and: \.y)
    let expectedCovariance = 51.5
    
    XCTAssertEqual(calculatedVariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testCGPointNegativeCovariance() {
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
    
    let calculatedVariance = cgPointArray.covariance(of: \.x, and: \.y)
    let expectedCovariance = -27.2
    
    XCTAssertEqual(calculatedVariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testCovarianceWithSelf() {
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
    
    let calculatedVariance = cgPointArray.covariance(of: \.x, and: \.x)
    let expectedCovariance = cgPointArray.variance(of: \.x, composition: .population)
    
    XCTAssertEqual(calculatedVariance, expectedCovariance, accuracy: 0.00001)
  }
  
  func testCGPointCovariancePerformance() {
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
        
        let calculatedVariance = cgPointArray.covariance(of: \.x, and: \.y)
      }
    }
  }
}
