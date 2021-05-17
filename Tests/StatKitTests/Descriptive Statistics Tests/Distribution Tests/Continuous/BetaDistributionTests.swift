#if !os(watchOS)

import XCTest
import StatKit

final class BetaDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(firstDistribution.mean, 0.5, accuracy: 1e-6)
    
    let secondDistribution = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(secondDistribution.mean, 0.7142857, accuracy: 1e-6)
  }
  
  func testVariance() {
    let firstDistribution = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(firstDistribution.variance, 0.08333333, accuracy: 1e-6)
    
    let secondDistribution = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(secondDistribution.variance, 0.02551020, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let firstDistribution = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(firstDistribution.skewness, 0, accuracy: 1e-6)
    
    let secondDistribution = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(secondDistribution.skewness, -0.59628479, accuracy: 1e-6)
  }
  
  func testKurtosis() {
    let firstDistribution = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(firstDistribution.kurtosis, 1.8, accuracy: 1e-6)
    
    let secondDistribution = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(secondDistribution.kurtosis, 2.88, accuracy: 1e-6)
  }
  
  func testExcessKurtosis() {
    let firstDistribution = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(firstDistribution.excessKurtosis, -1.2, accuracy: 1e-6)
    
    let secondDistribution = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(secondDistribution.excessKurtosis, -0.12, accuracy: 1e-6)
  }
  
  func testCDF() {
    let firstDistribution = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(firstDistribution.cdf(x: 0.1), 0.1, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.9), 0.9, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.4), 0.4, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 1, accuracy: 1e-6)
    
    let secondDistribution = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(secondDistribution.cdf(x: 0.1), 0.000055, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 0.9), 0.885735, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 0.4), 0.040960, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 1), 1, accuracy: 1e-6)
  }
  
  func testPDF() {
    let firstDistribution = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(firstDistribution.pdf(x: 0.1), 1, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.pdf(x: 0.9), 1, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.pdf(x: 0.4), 1, accuracy: 1e-6)
    
    let secondDistribution = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(secondDistribution.pdf(x: 0.1), 0.0027, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.pdf(x: 0.9), 1.9683, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.pdf(x: 0.4), 0.4608, accuracy: 1e-6)
  }
  
  func testSampling() {
    let numberOfSamples = 1000000
    let distribution = BetaDistribution(alpha: 5, beta: 2)
    var samples = [Double]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Double: Double]()) { result, number in
      let index = (number * 10).rounded(.down) / 10
      result[index, default: 0] += 1
    }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[0.0] ?? -1, 0.000055, accuracy: 0.01)
    XCTAssertEqual(proportions[0.2] ?? -1, 0.009335, accuracy: 0.01)
    XCTAssertEqual(proportions[0.4] ?? -1, 0.068415, accuracy: 0.01)
    XCTAssertEqual(proportions[0.6] ?? -1, 0.186895, accuracy: 0.01)
    XCTAssertEqual(proportions[0.8] ?? -1, 0.230375, accuracy: 0.01)
  }
}

#endif
