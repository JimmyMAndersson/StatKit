#if !os(watchOS)

import XCTest
import StatKit

final class ErlangDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = ErlangDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.mean, 1.0, accuracy: 1e-6)
    
    let secondDistribution = ErlangDistribution(shape: 5, scale: 10)
    XCTAssertEqual(secondDistribution.mean, 50.0, accuracy: 1e-6)
  }
  
  func testVariance() {
    let firstDistribution = ErlangDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.variance, 1.0, accuracy: 1e-6)
    
    let secondDistribution = ErlangDistribution(shape: 5, scale: 10)
    XCTAssertEqual(secondDistribution.variance, 500.0, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let firstDistribution = ErlangDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.skewness, 2.0, accuracy: 1e-6)
    
    let secondDistribution = ErlangDistribution(shape: 5, scale: 10)
    XCTAssertEqual(secondDistribution.skewness, 0.894427191, accuracy: 1e-6)
  }
  
  func testExcessKurtosis() {
    let firstDistribution = ErlangDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.excessKurtosis, 6.0, accuracy: 1e-6)

    let secondDistribution = ErlangDistribution(shape: 5, scale: 10)
    XCTAssertEqual(secondDistribution.excessKurtosis, 1.2, accuracy: 1e-6)
  }
  
  func testCDF() {
    let firstDistribution = ErlangDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 0.6321206, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.4), 0.32968, accuracy: 1e-6)
    
    let secondDistribution = ErlangDistribution(shape: 5, rate: 10)
    XCTAssertEqual(secondDistribution.cdf(x: 0.1), 0.0036598468, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 0.001), 0, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15), 1, accuracy: 1e-6)

    let thirdDistribution = ErlangDistribution(shape: 1000, rate: 20)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.1), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.001), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 15), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 50), 0.5042052, accuracy: 1e-6)
  }
  
  func testLogCDF() {
    let firstDistribution = ErlangDistribution(shape: 1, scale: 1)
    XCTAssertEqual(firstDistribution.cdf(x: 1, logarithmic: true), -0.4586751, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0, logarithmic: true), -.infinity, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.4, logarithmic: true), -1.1096329, accuracy: 1e-6)
    
    let secondDistribution = ErlangDistribution(shape: 5, rate: 10)
    XCTAssertEqual(secondDistribution.cdf(x: 0.1, logarithmic: true), -5.610333982897, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 0.001, logarithmic: true), -27.82167501344099, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15, logarithmic: true), 0, accuracy: 1e-6)
    
    let thirdDistribution = ErlangDistribution(shape: 1000, rate: 20)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.1, logarithmic: true), -5220.9789979, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.001, logarithmic: true), -9824.1711639, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 15, logarithmic: true), -507.9896393, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 50, logarithmic: true), -0.6847719, accuracy: 1e-6)
  }
  
  func testSampling() {
    let numberOfSamples = 1000000
    let distribution = ErlangDistribution(shape: 8, scale: 3)
    var samples = [Double]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[2] ?? -1, 0.0000097129388, accuracy: 0.01)
    XCTAssertEqual(proportions[3] ?? -1, 0.0000661934135, accuracy: 0.01)
    XCTAssertEqual(proportions[4] ?? -1, 0.0002642227930, accuracy: 0.01)
    XCTAssertEqual(proportions[5] ?? -1, 0.0007560535647, accuracy: 0.01)
    XCTAssertEqual(proportions[6] ?? -1, 0.0017257012298, accuracy: 0.01)
  }
}

#endif
