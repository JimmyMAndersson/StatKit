#if !os(watchOS)

import XCTest
import StatKit

final class ChiSquaredDistributionTests: XCTestCase {
  func testMean() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.mean, 2.0, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.mean, 7.0, accuracy: 1e-6)
  }

  func testVariance() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.variance, 4.0, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.variance, 14.0, accuracy: 1e-6)
  }

  func testSkewness() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.skewness, 2.0, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.skewness, 1.06904496765, accuracy: 1e-6)
  }

  func testExcessKurtosis() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.excessKurtosis, 6.0, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.excessKurtosis, 1.7142857143, accuracy: 1e-6)
  }

  func testPDF() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.pdf(x: 1), 0.3032653, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.pdf(x: 0), 0.5, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.pdf(x: 0.4), 0.4093654, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.pdf(x: 1), 0.01613138, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.pdf(x: 2.5), 0.07530100, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.pdf(x: 15), 0.01281853, accuracy: 1e-6)

    let thirdDistribution = ChiSquaredDistribution(degreesOfFreedom: 50)
    XCTAssertEqual(thirdDistribution.pdf(x: 0.1), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.pdf(x: 0.001), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.pdf(x: 15), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.pdf(x: 50), 0.039761475734, accuracy: 1e-6)
  }

  func testLogPDF() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.pdf(x: 1, logarithmic: true), -1.1931472, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.pdf(x: 0, logarithmic: true), -0.6931472, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.pdf(x: 0.4, logarithmic: true), -0.8931472, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.pdf(x: 1, logarithmic: true), -4.126989, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.pdf(x: 2.5, logarithmic: true), -2.586262, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.pdf(x: 15, logarithmic: true), -4.356863, accuracy: 1e-6)

    let thirdDistribution = ChiSquaredDistribution(degreesOfFreedom: 50)
    XCTAssertEqual(thirdDistribution.pdf(x: 0.1, logarithmic: true), -127.425451, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.pdf(x: 0.001, logarithmic: true), -237.900036, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.pdf(x: 15, logarithmic: true), -14.620204, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.pdf(x: 50, logarithmic: true), -3.224857, accuracy: 1e-6)
  }

  func testCDF() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.cdf(x: 1), 0.3934693402873665, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0), 0, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.4), 0.18126924692201815, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.cdf(x: 1), 0.005171463, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 2.5), 0.072902935, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15), 0.964000595, accuracy: 1e-6)

    let thirdDistribution = ChiSquaredDistribution(degreesOfFreedom: 50)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.1), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.001), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 15), 0, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 50), 0.52660153, accuracy: 1e-6)
  }

  func testLogCDF() {
    let firstDistribution = ChiSquaredDistribution(degreesOfFreedom: 2)
    XCTAssertEqual(firstDistribution.cdf(x: 1, logarithmic: true), -0.9327521, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0, logarithmic: true), -.infinity, accuracy: 1e-6)
    XCTAssertEqual(firstDistribution.cdf(x: 0.4, logarithmic: true), -1.7077718, accuracy: 1e-6)

    let secondDistribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    XCTAssertEqual(secondDistribution.cdf(x: 0.1, logarithmic: true), -12.97764902, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 0.001, logarithmic: true), -29.05728406, accuracy: 1e-6)
    XCTAssertEqual(secondDistribution.cdf(x: 15, logarithmic: true), -0.03666337, accuracy: 1e-6)

    let thirdDistribution = ChiSquaredDistribution(degreesOfFreedom: 50)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.1, logarithmic: true), -132.9449873, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 0.001, logarithmic: true), -248.0266475, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 15, logarithmic: true), -14.7963960, accuracy: 1e-6)
    XCTAssertEqual(thirdDistribution.cdf(x: 50, logarithmic: true), -0.6413111, accuracy: 1e-6)
  }

  func testSampling() {
    let numberOfSamples = 1000000
    let distribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    var samples = [Double]()

    measure {
      samples = distribution.sample(numberOfSamples)
    }

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    XCTAssertEqual(samples.count, numberOfSamples)
    XCTAssertEqual(proportions[0] ?? -1, 0.005171463, accuracy: 1e-3)
    XCTAssertEqual(proportions[1] ?? -1, 0.034988168, accuracy: 1e-3)
    XCTAssertEqual(proportions[2] ?? -1, 0.074838137, accuracy: 1e-3)
    XCTAssertEqual(proportions[3] ?? -1, 0.105224823, accuracy: 1e-3)
    XCTAssertEqual(proportions[4] ?? -1, 0.119814179, accuracy: 1e-3)
    XCTAssertEqual(proportions[5] ?? -1, 0.120213879, accuracy: 1e-3)
    XCTAssertEqual(proportions[6] ?? -1, 0.110869493, accuracy: 1e-3)
  }
}

#endif
