#if !os(watchOS)

import XCTest
import StatKit

final class PoissonDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = PoissonDistribution(rate: 1)
    XCTAssertEqual(firstDistribution.mean, 1.0, accuracy: 1e-5)
    
    let secondDistribution = PoissonDistribution(rate: 57)
    XCTAssertEqual(secondDistribution.mean, 57.0, accuracy: 1e-5)
  }
  
  func testVariance() {
    let firstDistribution = PoissonDistribution(rate: 1)
    XCTAssertEqual(firstDistribution.variance, 1.0, accuracy: 1e-5)
    
    let secondDistribution = PoissonDistribution(rate: 57)
    XCTAssertEqual(secondDistribution.variance, 57.0, accuracy: 1e-5)
  }
  
  func testSkewness() {
    let firstDistribution = PoissonDistribution(rate: 1)
    XCTAssertEqual(firstDistribution.skewness, 1.0, accuracy: 1e-5)
    
    let secondDistribution = PoissonDistribution(rate: 57)
    XCTAssertEqual(secondDistribution.skewness, 0.13245, accuracy: 1e-5)
  }
  
  func testKurtosis() {
    let firstDistribution = PoissonDistribution(rate: 1)
    XCTAssertEqual(firstDistribution.kurtosis, 4.0, accuracy: 1e-5)
    
    let secondDistribution = PoissonDistribution(rate: 57)
    XCTAssertEqual(secondDistribution.kurtosis, 3.01754, accuracy: 1e-5)
  }
  
  func testExcessKurtosis() {
    let firstDistribution = PoissonDistribution(rate: 1)
    XCTAssertEqual(firstDistribution.excessKurtosis, 1.0, accuracy: 1e-5)
    
    let secondDistribution = PoissonDistribution(rate: 57)
    XCTAssertEqual(secondDistribution.excessKurtosis, 0.01754, accuracy: 1e-5)
  }
  
  func testCDF() {
    let firstDistribution = PoissonDistribution(rate: 1)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 0.73576, accuracy: 1e-5)
    XCTAssertEqual(firstDistribution.cdf(x: 0), 0.36788, accuracy: 1e-5)
    XCTAssertEqual(firstDistribution.cdf(x: 6), 0.99992, accuracy: 1e-5)
    
    let secondDistribution = PoissonDistribution(rate: 8)
    XCTAssertEqual(secondDistribution.cdf(x: 1), 0.00302, accuracy: 1e-5)
    XCTAssertEqual(secondDistribution.cdf(x: 0), 0.00034, accuracy: 1e-5)
    XCTAssertEqual(secondDistribution.cdf(x: 6), 0.31337, accuracy: 1e-5)
  }
  
  func testSampling() {
    let numberOfSamples = 100000
    let distribution = PoissonDistribution(rate: 2)
    var samples = [Int]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[number, default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[0] ?? -1, 0.13533, accuracy: 0.01)
    XCTAssertEqual(proportions[1] ?? -1, 0.27067, accuracy: 0.01)
    XCTAssertEqual(proportions[2] ?? -1, 0.27067, accuracy: 0.01)
    XCTAssertEqual(proportions[3] ?? -1, 0.18044, accuracy: 0.01)
  }
}

#endif
