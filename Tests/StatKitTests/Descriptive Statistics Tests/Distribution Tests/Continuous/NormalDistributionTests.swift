#if !os(watchOS)

import XCTest
import StatKit

final class NormalDistributionTests: XCTestCase {
  func testMean() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.mean, 0, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.mean, -4, accuracy: 1e-6)
  }
  
  func testVariance() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.variance, 1, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.variance, 9, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.skewness, 0, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.skewness, 0, accuracy: 1e-6)
  }
  
  func testKurtosis() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.kurtosis, 3, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.kurtosis, 3, accuracy: 1e-6)
  }
  
  func testCDF() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.cdf(x: 1), 0.8413447, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: 0), 0.5, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: 0.4), 0.6554217, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: -20), 0, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.cdf(x: 10), 0.99999847, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.cdf(x: -8), 0.09121122, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.cdf(x: 0), 0.90878878, accuracy: 1e-6)
  }
  
  func testLogCDF() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.cdf(x: 1, logarithmic: true), -0.1727538, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: 0, logarithmic: true), -0.6931472, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: 0.4, logarithmic: true), -0.4224764, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.cdf(x: -20, logarithmic: true), -.infinity, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.cdf(x: 10, logarithmic: true), -0.000001530628, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.cdf(x: -8, logarithmic: true), -2.394577366159, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.cdf(x: 0, logarithmic: true), -0.095642576741, accuracy: 1e-6)
  }
  
  func testPDF() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.pdf(x: 1), 0.2419707, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.pdf(x: 0), 0.3989423, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.pdf(x: 0.4), 0.3682701, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.pdf(x: 0), 0.054670025, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.pdf(x: -2), 0.106482669, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.pdf(x: 4), 0.003798662, accuracy: 1e-6)
  }
  
  func testLogPDF() {
    let standardDistribution = NormalDistribution(mean: 0, variance: 1)
    XCTAssertEqual(standardDistribution.pdf(x: 1, logarithmic: true), -1.4189385, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.pdf(x: 0, logarithmic: true), -0.9189385, accuracy: 1e-6)
    XCTAssertEqual(standardDistribution.pdf(x: 0.4, logarithmic: true), -0.9989385, accuracy: 1e-6)
    
    let offsetDistribution = NormalDistribution(mean: -4, variance: 9)
    XCTAssertEqual(offsetDistribution.pdf(x: 0, logarithmic: true), -2.906440, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.pdf(x: -2, logarithmic: true), -2.239773, accuracy: 1e-6)
    XCTAssertEqual(offsetDistribution.pdf(x: 4, logarithmic: true), -5.573106, accuracy: 1e-6)
  }
  
  func testSampling() {
    let numberOfSamples = 1000000
    let distribution = NormalDistribution(mean: 0, variance: 1)
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
