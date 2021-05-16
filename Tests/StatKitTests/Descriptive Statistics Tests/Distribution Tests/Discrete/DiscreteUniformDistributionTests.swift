#if !os(watchOS)

import XCTest
import StatKit

final class DiscreteUniformDistributionTests: XCTestCase {
  func testMean() {
    let standardDistribution = DiscreteUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.mean, 0.5, accuracy: 1e-6)
    
    let offsetDistribution = DiscreteUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.mean, 2.5, accuracy: 1e-6)
  }
  
  func testVariance() {
    let standardDistribution = DiscreteUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.variance, 0.25, accuracy: 1e-6)
    
    let offsetDistribution = DiscreteUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.variance, 16.25, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let standardDistribution = DiscreteUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.skewness, 0, accuracy: 1e-6)
    
    let offsetDistribution = DiscreteUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.skewness, 0, accuracy: 1e-6)
  }
  
  func testKurtosis() {
    let standardDistribution = DiscreteUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.kurtosis, 1, accuracy: 1e-6)
    
    let offsetDistribution = DiscreteUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.kurtosis, 1.787692, accuracy: 1e-6)
  }
  
  func testExcessKurtosis() {
    let standardDistribution = DiscreteUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.excessKurtosis, -2, accuracy: 1e-6)
    
    let offsetDistribution = DiscreteUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.excessKurtosis, -1.212308, accuracy: 1e-6)
  }
  
  func testCDF() {
    let standardDistribution = DiscreteUniformDistribution(0, 1)
    XCTAssertEqual(standardDistribution.cdf(x: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: 0), 0.5, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: -1), 0, accuracy: 1e-6)
    
    let offsetDistribution = DiscreteUniformDistribution(-4, 9)
    XCTAssertEqual(offsetDistribution.cdf(x: 10), 1, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.cdf(x: -8), 0, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.cdf(x: 0), 5 / 14, accuracy: 1e-6)
  }
  
  func testSampling() {
    let numberOfSamples = 1000000
    let lower = 1
    let upper = 10
    let distribution = DiscreteUniformDistribution(lower, upper)
    var samples = [Int]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in
      result[number, default: 0] += 1
    }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    
    for index in lower ... upper {
      XCTAssertEqual(proportions[index] ?? -1, 0.1, accuracy: 0.01)
    }
  }
}

#endif
