#if !os(watchOS)

import XCTest
import StatKit

final class ExponentialDistributionTests: XCTestCase {
  func testMean() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.mean, 1.0, accuracy: 1e-6)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.mean, 0.0175438, accuracy: 1e-6)
  }
  
  func testVariance() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.variance, 1.0, accuracy: 1e-6)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.variance, 0.000307787, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.skewness, 2.0, accuracy: 1e-6)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.skewness, 2.0, accuracy: 1e-6)
  }
  
  func testExcessKurtosis() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.excessKurtosis, 6.0, accuracy: 1e-6)

    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.excessKurtosis, 6.0, accuracy: 1e-6)
  }
  
  func testCDF() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.cdf(x: 1), 0.63212, accuracy: 1e-6)
    XCTAssertEqual(firstExpDistribution.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(firstExpDistribution.cdf(x: 0.4), 0.32968, accuracy: 1e-6)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.cdf(x: 0.1), 0.9966540, accuracy: 1e-6)
    XCTAssertEqual(secondExpDistribution.cdf(x: -8), 0, accuracy: 1e-6)
    XCTAssertEqual(secondExpDistribution.cdf(x: 0), 0, accuracy: 1e-6)
  }
  
  func testLogCDF() {
    let firstExpDistribution = ExponentialDistribution(rate: 1)
    XCTAssertEqual(firstExpDistribution.cdf(x: 1, logarithmic: true), -0.4586751, accuracy: 1e-6)
    XCTAssertEqual(firstExpDistribution.cdf(x: 0, logarithmic: true), -.infinity, accuracy: 1e-6)
    XCTAssertEqual(firstExpDistribution.cdf(x: 0.4, logarithmic: true), -1.1096329, accuracy: 1e-6)
    
    let secondExpDistribution = ExponentialDistribution(rate: 57)
    XCTAssertEqual(secondExpDistribution.cdf(x: 0.1, logarithmic: true), -0.003351576, accuracy: 1e-6)
    XCTAssertEqual(secondExpDistribution.cdf(x: -8, logarithmic: true), -.infinity, accuracy: 1e-6)
    XCTAssertEqual(secondExpDistribution.cdf(x: 0, logarithmic: true), -.infinity, accuracy: 1e-6)
  }
  
  func testSampling() {
    let numberOfSamples = 1000000
    let distribution = ExponentialDistribution(rate: 0.2)
    var samples = [Double]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[0] ?? -1, 0.18126, accuracy: 0.01)
    XCTAssertEqual(proportions[1] ?? -1, 0.14841, accuracy: 0.01)
    XCTAssertEqual(proportions[2] ?? -1, 0.12150, accuracy: 0.01)
    XCTAssertEqual(proportions[3] ?? -1, 0.09948, accuracy: 0.01)
  }
}

#endif
