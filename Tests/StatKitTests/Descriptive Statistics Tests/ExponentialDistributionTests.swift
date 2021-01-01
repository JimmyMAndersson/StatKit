#if !os(watchOS)

import XCTest
@testable import StatKit

final class ExponentialDistributionTests: XCTestCase {
  func testMean() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.mean, 1.0, accuracy: 0.00001)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.mean, 0.01754, accuracy: 0.00001)
  }
  
  func testVariance() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.variance, 1.0, accuracy: 0.00001)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.variance, 0.00030, accuracy: 0.00001)
  }
  
  func testSkewness() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.skewness, 2.0, accuracy: 0.00001)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.skewness, 2.0, accuracy: 0.00001)
  }
  
  func testKurtosis() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.kurtosis, 9.0, accuracy: 0.00001)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.kurtosis, 9.0, accuracy: 0.00001)
  }
  
  func testExcessKurtosis() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.excessKurtosis, 6.0, accuracy: 0.00001)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.excessKurtosis, 6.0, accuracy: 0.00001)
  }
  
  func testCDF() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.cdf(x: 1), 0.63212, accuracy: 0.00001)
    XCTAssertEqual(firstExpDistribution.cdf(x: 0), 0, accuracy: 0.00001)
    XCTAssertEqual(firstExpDistribution.cdf(x: 0.4), 0.32968, accuracy: 0.00001)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.cdf(x: 0.1), 0.99665, accuracy: 0.00001)
    XCTAssertEqual(secondExpDistribution.cdf(x: -8), 0, accuracy: 0.00001)
    XCTAssertEqual(secondExpDistribution.cdf(x: 0), 0, accuracy: 0.00001)
  }
}

#endif
