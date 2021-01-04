#if !os(watchOS)

import XCTest
@testable import StatKit

final class NormalDistributionTests: XCTestCase {
  func testMean() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.mean, 0, accuracy: 0.00001)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.mean, -4, accuracy: 0.00001)
  }
  
  func testVariance() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.variance, 1, accuracy: 0.00001)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.variance, 9, accuracy: 0.00001)
  }
  
  func testSkewness() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.skewness, 0, accuracy: 0.00001)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.skewness, 0, accuracy: 0.00001)
  }
  
  func testKurtosis() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.kurtosis, 3, accuracy: 0.00001)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.kurtosis, 3, accuracy: 0.00001)
  }
  
  func testExcessKurtosis() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.excessKurtosis, 0, accuracy: 0.00001)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.excessKurtosis, 0, accuracy: 0.00001)
  }
  
  func testCDF() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.cdf(x: 1), 0.84134, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.cdf(x: 0), 0.5, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.cdf(x: 0.4), 0.65542, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.cdf(x: -20), 2.753624e-89, accuracy: 0.00001)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.cdf(x: 10), 0.99999, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.cdf(x: -8), 0.09121, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.cdf(x: 0), 0.90878, accuracy: 0.00001)
  }
  
  func testPDF() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.pdf(x: 1), 0.24197, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.pdf(x: 0), 0.39894, accuracy: 0.00001)
    XCTAssertEqual(standardDistribution.pdf(x: 0.4), 0.36827, accuracy: 0.00001)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.pdf(x: 0), 0.05467, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.pdf(x: -2), 0.10648, accuracy: 0.00001)
    XCTAssertEqual(offsetDistribution.pdf(x: 4), 0.00379, accuracy: 0.00001)
  }
  
  func testSampling() {
    let numberOfSamples = 100000
    let distribution = NormalDistribution(mean: 0, variance: 1)
    let samples = distribution.sample(numberOfSamples)
    var proportions = samples.reduce(into: [Double: Double]()) { result, number in
      let index = (number * 10).rounded(.down) / 10
      result[index, default: 0] += 1
    }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[-0.4] ?? -1, 0.03604, accuracy: 0.01)
    XCTAssertEqual(proportions[-0.3] ?? -1, 0.03751, accuracy: 0.01)
    XCTAssertEqual(proportions[-0.2] ?? -1, 0.03865, accuracy: 0.01)
    XCTAssertEqual(proportions[-0.1] ?? -1, 0.03943, accuracy: 0.01)
    XCTAssertEqual(proportions[0.0] ?? -1, 0.03982, accuracy: 0.01)
    XCTAssertEqual(proportions[0.1] ?? -1, 0.03943, accuracy: 0.01)
    XCTAssertEqual(proportions[0.2] ?? -1, 0.03865, accuracy: 0.01)
    XCTAssertEqual(proportions[0.3] ?? -1, 0.03751, accuracy: 0.01)
    XCTAssertEqual(proportions[0.4] ?? -1, 0.03604, accuracy: 0.01)
  }
}

#endif
