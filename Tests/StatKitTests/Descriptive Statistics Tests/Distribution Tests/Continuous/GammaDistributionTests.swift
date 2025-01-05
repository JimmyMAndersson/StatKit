#if !os(watchOS)

import XCTest
import StatKit

final class GammaDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = GammaDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.mean, 1.0, accuracy: 1e-6)
    
    let secondDistribution = GammaDistribution(shape: 0.5, scale: 10)
    XCTAssertEqual(secondDistribution.mean, 5.0, accuracy: 1e-6)
  }
  
  func testVariance() {
    let firstDistribution = GammaDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.variance, 1.0, accuracy: 1e-6)
    
    let secondDistribution = GammaDistribution(shape: 0.5, scale: 10)
    XCTAssertEqual(secondDistribution.variance, 50.0, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let firstDistribution = GammaDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.skewness, 2.0, accuracy: 1e-6)
    
    let secondDistribution = GammaDistribution(shape: 0.5, scale: 10)
    XCTAssertEqual(secondDistribution.skewness, 2.828427, accuracy: 1e-6)
  }
  
  func testKurtosis() {
    let firstDistribution = GammaDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.kurtosis, 9.0, accuracy: 1e-6)
    
    let secondDistribution = GammaDistribution(shape: 0.5, scale: 10)
    XCTAssertEqual(secondDistribution.kurtosis, 15.0, accuracy: 1e-6)
  }
  
  func testCDF() {
    let firstDistribution = GammaDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 0.6321206, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.4), 0.32968, accuracy: 1e-6)
    
    let secondDistribution = GammaDistribution(shape: 0.5, rate: 10)
    XCTAssertEqual(secondDistribution.cdf(x: 0.1), 0.8427008, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 0.001), 0.1124629, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15), 1, accuracy: 1e-6)
    
    let thirdDistribution = GammaDistribution(shape: 1000, rate: 20)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.1), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.001), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 15), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 50), 0.5042052, accuracy: 1e-6)
  }
  
  func testLogCDF() {
    let firstDistribution = GammaDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.cdf(x: 1, logarithmic: true), -0.4586751, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0, logarithmic: true), -.infinity, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.4, logarithmic: true), -1.1096329, accuracy: 1e-6)
    
    let secondDistribution = GammaDistribution(shape: 0.5, rate: 10)
    XCTAssertEqual(secondDistribution.cdf(x: 0.1, logarithmic: true), -0.1711433, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 0.001, logarithmic: true), -2.185132, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15, logarithmic: true), 0, accuracy: 1e-6)
    
    let thirdDistribution = GammaDistribution(shape: 1000, rate: 20)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.1, logarithmic: true), -5220.9789979, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.001, logarithmic: true), -9824.1711639, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 15, logarithmic: true), -507.9896393, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 50, logarithmic: true), -0.6847719, accuracy: 1e-6)
  }
  
  func testSamplingAlphaGreatherThanOne() {
    let numberOfSamples = 1000000
    let distribution = GammaDistribution(shape: 7.5, scale: 3)
    var samples = [Double]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[1] ?? -1, 0.000001881561, accuracy: 0.01)
    XCTAssertEqual(proportions[2] ?? -1, 0.000027759390, accuracy: 0.01)
    XCTAssertEqual(proportions[3] ?? -1, 0.000162396697, accuracy: 0.01)
    XCTAssertEqual(proportions[4] ?? -1, 0.000575600420, accuracy: 0.01)
    XCTAssertEqual(proportions[5] ?? -1, 0.001495003753, accuracy: 0.01)
    XCTAssertEqual(proportions[6] ?? -1, 0.003145153584, accuracy: 0.01)
  }
  
  func testSamplingAlphaLessThanOne() {
    let numberOfSamples = 1000000
    let distribution = GammaDistribution(shape: 0.5, scale: 1)
    var samples = [Double]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Double: Double]()) { result, number in result[(number * 10).rounded(.down) / 10, default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[0.0] ?? -1, 0.34527915398, accuracy: 0.01)
    XCTAssertEqual(proportions[0.1] ?? -1, 0.12763158915, accuracy: 0.01)
    XCTAssertEqual(proportions[0.2] ?? -1, 0.08851123078, accuracy: 0.01)
    XCTAssertEqual(proportions[0.3] ?? -1, 0.06748465656, accuracy: 0.01)
    XCTAssertEqual(proportions[0.4] ?? -1, 0.05378286166, accuracy: 0.01)
    XCTAssertEqual(proportions[0.5] ?? -1, 0.04398882957, accuracy: 0.01)
    XCTAssertEqual(proportions[0.6] ?? -1, 0.03659810765, accuracy: 0.01)
  }
}

#endif
