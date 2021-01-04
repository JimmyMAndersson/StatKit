#if !os(watchOS)

import XCTest
@testable import StatKit

final class ContinuousUniformDistributionTests: XCTestCase {
  func testMean() {
    let standardDistribution = ContinuousUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.mean, 0.5, accuracy: 0.00001)
    
    let offsetDistribution = ContinuousUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.mean, 2.5, accuracy: 0.00001)
  }
  
  func testVariance() {
    let standardDistribution = ContinuousUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.variance, 1 / 12, accuracy: 0.00001)
    
    let offsetDistribution = ContinuousUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.variance, 14.08333, accuracy: 0.00001)
  }
  
  func testSkewness() {
    let standardDistribution = ContinuousUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.skewness, 0, accuracy: 0.00001)
    
    let offsetDistribution = ContinuousUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.skewness, 0, accuracy: 0.00001)
  }
  
  func testKurtosis() {
    let standardDistribution = ContinuousUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.kurtosis, 9 / 5, accuracy: 0.00001)
    
    let offsetDistribution = ContinuousUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.kurtosis, 9 / 5, accuracy: 0.00001)
  }
  
  func testExcessKurtosis() {
    let standardDistribution = ContinuousUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.excessKurtosis, -6 / 5, accuracy: 0.00001)
    
    let offsetDistribution = ContinuousUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.excessKurtosis, -6 / 5, accuracy: 0.00001)
  }
  
  func testCDF() {
    let standardDistribution = ContinuousUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.cdf(x: 1), 1, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.cdf(x: 0), 0, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.cdf(x: 0.4), 0.4, accuracy: 0.00001)
    
    let offsetDistribution = ContinuousUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.cdf(x: 10), 1, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.cdf(x: -8), 0, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.cdf(x: 0), 4 / 13, accuracy: 0.00001)
  }
  
  func testSampling() {
    let numberOfSamples = 100000
    let distribution = ContinuousUniformDistribution(0, 1)
    let samples = distribution.sample(numberOfSamples)
    var proportions = samples.reduce(into: [Double: Double]()) { result, number in
      let index = (number * 10).rounded(.down) / 10
      result[index, default: 0] += 1
    }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[0.0] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.1] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.2] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.3] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.4] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.5] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.6] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.7] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.8] ?? -1, 0.1, accuracy: 0.01)
    XCTAssertEqual(proportions[0.9] ?? -1, 0.1, accuracy: 0.01)
  }
}

#endif
