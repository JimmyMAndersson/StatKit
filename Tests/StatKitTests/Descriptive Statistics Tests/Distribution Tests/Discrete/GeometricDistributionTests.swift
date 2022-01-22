#if !os(watchOS)

import XCTest
import StatKit

final class GeometricDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = GeometricDistribution(probability: 0.5)
    XCTAssertEqual(firstDistribution.mean, 2, accuracy: 1e-6)
    
    let secondDistribution = GeometricDistribution(probability: 0.7)
    XCTAssertEqual(secondDistribution.mean, 1.428571, accuracy: 1e-6)
  }
  
  func testVariance() {
    let firstDistribution = GeometricDistribution(probability: 0.5)
    XCTAssertEqual(firstDistribution.variance, 2, accuracy: 1e-6)
    
    let secondDistribution = GeometricDistribution(probability: 0.7)
    XCTAssertEqual(secondDistribution.variance, 0.6122449, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let firstDistribution = GeometricDistribution(probability: 0.5)
    XCTAssertEqual(firstDistribution.skewness, 2.12132, accuracy: 1e-6)
    
    let secondDistribution = GeometricDistribution(probability: 0.7)
    XCTAssertEqual(secondDistribution.skewness, 2.373464, accuracy: 1e-6)
  }
  
  func testKurtosis() {
    let firstDistribution = GeometricDistribution(probability: 0.5)
    XCTAssertEqual(firstDistribution.kurtosis, 9.5, accuracy: 1e-6)
    
    let secondDistribution = GeometricDistribution(probability: 0.7)
    XCTAssertEqual(secondDistribution.kurtosis, 10.63333333, accuracy: 1e-6)
  }
  
  func testCDF() {
    let firstDistribution = GeometricDistribution(probability: 0.5)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 0.5, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 3), 0.875, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 7), 0.9921875, accuracy: 1e-6)
    
    let secondDistribution = GeometricDistribution(probability: 0.7)
    XCTAssertEqual(secondDistribution.cdf(x: 1), 0.7, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 3), 0.973, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 7), 0.9997813, accuracy: 1e-6)
  }
  
  func testLogCDF() {
    let firstDistribution = GeometricDistribution(probability: 0.5)
    XCTAssertEqual(firstDistribution.cdf(x: 1, logarithmic: true), -0.693147181, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 3, logarithmic: true), -0.133531393, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 7, logarithmic: true), -0.007843177, accuracy: 1e-6)
    
    let secondDistribution = GeometricDistribution(probability: 0.7)
    XCTAssertEqual(secondDistribution.cdf(x: 1, logarithmic: true), -0.3566749439, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 3, logarithmic: true), -0.0273711968, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 7, logarithmic: true), -0.0002187239, accuracy: 1e-6)
  }
  
  func testSampling() {
    let numberOfSamples = 1000000
    let distribution = GeometricDistribution(probability: 0.7)
    var samples = [Int]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    let lowerBound = 1
    let upperBound = 10
    let testRange =  lowerBound ... upperBound
    for successes in testRange {
      XCTAssertEqual(proportions[successes] ?? -1, distribution.pmf(x: successes), accuracy: 0.01)
    }
  }
}

#endif
