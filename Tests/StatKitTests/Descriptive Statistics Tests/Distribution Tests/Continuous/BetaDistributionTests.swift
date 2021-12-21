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
  
  func testCDF() {
    let first = BetaDistribution(alpha: 1, beta: 1)
    XCTAssertEqual(first.cdf(x: -1), 0, accuracy: 1e-6)
    XCTAssertEqual(first.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(first.cdf(x: 0.1), 0.1, accuracy: 1e-6)
    XCTAssertEqual(first.cdf(x: 0.9), 0.9, accuracy: 1e-6)
    XCTAssertEqual(first.cdf(x: 0.4), 0.4, accuracy: 1e-6)
    XCTAssertEqual(first.cdf(x: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(first.cdf(x: 2), 1, accuracy: 1e-6)
    
    let second = BetaDistribution(alpha: 5, beta: 2)
    XCTAssertEqual(second.cdf(x: -1), 0, accuracy: 1e-6)
    XCTAssertEqual(second.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(second.cdf(x: 0.1), 0.000055, accuracy: 1e-6)
    XCTAssertEqual(second.cdf(x: 0.9), 0.885735, accuracy: 1e-6)
    XCTAssertEqual(second.cdf(x: 0.4), 0.040960, accuracy: 1e-6)
    XCTAssertEqual(second.cdf(x: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(second.cdf(x: 2), 1, accuracy: 1e-6)
    
    let third = BetaDistribution(alpha: 0.1, beta: 5000)
    XCTAssertEqual(third.cdf(x: -1), 0, accuracy: 1e-6)
    XCTAssertEqual(third.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(third.cdf(x: 0.1), 1, accuracy: 1e-6)
    XCTAssertEqual(third.cdf(x: 0.9), 1, accuracy: 1e-6)
    XCTAssertEqual(third.cdf(x: 0.4), 1, accuracy: 1e-6)
    XCTAssertEqual(third.cdf(x: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(third.cdf(x: 2), 1, accuracy: 1e-6)
    
    let fourth = BetaDistribution(alpha: 0.1, beta: 0.1)
    XCTAssertEqual(fourth.cdf(x: -1), 0, accuracy: 1e-6)
    XCTAssertEqual(fourth.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(fourth.cdf(x: 0.1), 0.4063851, accuracy: 1e-6)
    XCTAssertEqual(fourth.cdf(x: 0.9), 0.5936149, accuracy: 1e-6)
    XCTAssertEqual(fourth.cdf(x: 0.4), 0.4821200, accuracy: 1e-6)
    XCTAssertEqual(fourth.cdf(x: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(fourth.cdf(x: 2), 1, accuracy: 1e-6)
    
    let fifth = BetaDistribution(alpha: 5000, beta: 5000)
    XCTAssertEqual(fifth.cdf(x: -1), 0, accuracy: 1e-6)
    XCTAssertEqual(fifth.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(fifth.cdf(x: 0.1), 0, accuracy: 1e-6)
    XCTAssertEqual(fifth.cdf(x: 0.9), 1, accuracy: 1e-6)
    XCTAssertEqual(fifth.cdf(x: 0.4), 4.518544e-91, accuracy: 1e-6)
    XCTAssertEqual(fifth.cdf(x: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(fifth.cdf(x: 2), 1, accuracy: 1e-6)
    
    let sixth = BetaDistribution(alpha: 10000, beta: 1)
    XCTAssertEqual(sixth.cdf(x: -1), 0, accuracy: 1e-6)
    XCTAssertEqual(sixth.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(sixth.cdf(x: 0.1), 0, accuracy: 1e-6)
    XCTAssertEqual(sixth.cdf(x: 0.9), 0, accuracy: 1e-6)
    XCTAssertEqual(sixth.cdf(x: 0.4), 0, accuracy: 1e-6)
    XCTAssertEqual(sixth.cdf(x: 1), 1, accuracy: 1e-6)
    XCTAssertEqual(sixth.cdf(x: 2), 1, accuracy: 1e-6)
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
