#if !os(watchOS)

import XCTest
@testable import StatKit

final class UniformDistributionTests: XCTestCase {
  func testMean() {
    let standardDistribution = UniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.mean, 0.5, accuracy: 0.00001)
    
    let offsetDistribution = UniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.mean, 2.5, accuracy: 0.00001)
  }
  
  func testVariance() {
    let standardDistribution = UniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.variance, 1 / 12, accuracy: 0.00001)
    
    let offsetDistribution = UniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.variance, 14.08333, accuracy: 0.00001)
  }
  
  func testSkewness() {
    let standardDistribution = UniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.skewness, 0, accuracy: 0.00001)
    
    let offsetDistribution = UniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.skewness, 0, accuracy: 0.00001)
  }
  
  func testKurtosis() {
    let standardDistribution = UniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.kurtosis, 9 / 5, accuracy: 0.00001)
    
    let offsetDistribution = UniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.kurtosis, 9 / 5, accuracy: 0.00001)
  }
  
  func testCDF() {
    let standardDistribution = UniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.cdf(x: 1), 1, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.cdf(x: 0), 0, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.cdf(x: 0.4), 0.4, accuracy: 0.00001)
    
    let offsetDistribution = UniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.cdf(x: 10), 1, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.cdf(x: -8), 0, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.cdf(x: 0), 4 / 13, accuracy: 0.00001)
  }
}

#endif
