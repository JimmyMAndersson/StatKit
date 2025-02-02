#if !os(watchOS)

import XCTest
import StatKit
import RealModule

final class BinomialDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.mean, 10, accuracy: 1e-6)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.mean, 14, accuracy: 1e-6)
  }
  
  func testVariance() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.variance, 5.0, accuracy: 1e-6)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.variance, 4.2, accuracy: 1e-6)
  }
  
  func testSkewness() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.skewness, 0, accuracy: 1e-6)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.skewness, -0.19518, accuracy: 1e-6)
  }
  
  func testExcessKurtosis() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.excessKurtosis, -0.1, accuracy: 1e-6)

    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.excessKurtosis, -0.0619047619, accuracy: 1e-6)
  }
  
  func testCDF() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 0.0000200271606, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0), 0.0000009536743, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 10), 0.5880985260010, accuracy: 1e-6)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.cdf(x: 10), 0.04796190, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 7), 0.00127888, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15), 0.76249222, accuracy: 1e-6)
  }
  
  func testLogCDF() {
    let firstDistribution = BinomialDistribution(probability: 0.5, trials: 20)
    XCTAssertEqual(firstDistribution.cdf(x: 1, logarithmic: true), -10.8184212, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0, logarithmic: true), -13.8629436, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 10, logarithmic: true), -0.5308608, accuracy: 1e-6)
    
    let secondDistribution = BinomialDistribution(probability: 0.7, trials: 20)
    XCTAssertEqual(secondDistribution.cdf(x: 10, logarithmic: true), -3.037348, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 7, logarithmic: true), -6.661771, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15, logarithmic: true), -0.271163, accuracy: 1e-6)
  }
  
  func testSampling() {
    let numberOfSamples = 1000000
    let distribution = BinomialDistribution(probability: 0.7, trials: 20)
    var samples = [Int]()
    
    measure {
      samples = distribution.sample(numberOfSamples)
    }
    
    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }
    
    XCTAssertEqual(samples.count, numberOfSamples)
    let lowerBound = Swift.max(0, Int(distribution.mean - 3 * (distribution.variance).squareRoot()))
    let upperBound = Swift.min(distribution.trials, Int(distribution.mean + 3 * (distribution.variance).squareRoot()))
    let testRange =  lowerBound ... upperBound
    for successes in testRange {
      XCTAssertEqual(proportions[successes] ?? -1, distribution.pmf(x: successes), accuracy: 0.01)
    }
  }
}

#endif
