#if !os(watchOS)

import XCTest
import StatKit

final class BinomialDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.mean, 10, accuracy: 1e-5)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.mean, 14, accuracy: 1e-5)
  }
  
  func testVariance() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.variance, 5.0, accuracy: 1e-5)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.variance, 4.2, accuracy: 1e-5)
  }
  
  func testSkewness() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.skewness, 0, accuracy: 1e-5)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.skewness, -0.19518, accuracy: 1e-5)
  }
  
  func testKurtosis() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.kurtosis, 2.9, accuracy: 1e-5)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.kurtosis, 2.938095, accuracy: 1e-5)
  }
  
  func testExcessKurtosis() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.excessKurtosis, -0.1, accuracy: 1e-5)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.excessKurtosis, -0.061905, accuracy: 1e-5)
  }
  
  func testCDF() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 0.0000200271606, accuracy: 1e-5)
    XCTAssertEqual(firstDistribution.cdf(x: 0), 0.0000009536743, accuracy: 1e-5)
    XCTAssertEqual(firstDistribution.cdf(x: 10), 0.5880985260010, accuracy: 1e-5)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.cdf(x: 10), 0.04796190, accuracy: 1e-5)
    XCTAssertEqual(secondDistribution.cdf(x: 7), 0.00127888, accuracy: 1e-5)
    XCTAssertEqual(secondDistribution.cdf(x: 15), 0.76249222, accuracy: 1e-5)
  }
  
  func testSampling() {
    let numberOfSamples = 100000
    let distribution = BinomialDistribution(probability: 0.7, trials: 20)
    var samples = [Int]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    let lowerBound = Swift.max(0, Int(distribution.mean - 3 * sqrt(distribution.variance)))
    let upperBound = Swift.min(distribution.trials, Int(distribution.mean + 3 * sqrt(distribution.variance)))
    let testRange =  lowerBound ... upperBound
    for successes in testRange {
      XCTAssertEqual(proportions[successes] ?? -1, distribution.pmf(x: successes), accuracy: 0.01)
    }
  }
}

#endif
