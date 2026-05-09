import Testing
import StatKit

@Suite("Chi-Squared Distribution Tests", .tags(.distribution))
struct ChiSquaredDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (2, 2.0),
      (7, 7.0),
    ]
  )
  func validInputReturnsCorrectMean(degreesOfFreedom: Int, expectedMean: Double) async throws {
    let mean = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (2, 4.0),
      (7, 14.0),
    ]
  )
  func validInputReturnsCorrectVariance(degreesOfFreedom: Int, expectedVariance: Double) async throws {
    let variance = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (2, 2.0),
      (7, 1.06904496765),
    ]
  )
  func validInputReturnsCorrectSkewness(degreesOfFreedom: Int, expectedSkewness: Double) async throws {
    let skewness = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (2, 6.0),
      (7, 1.7142857143),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(degreesOfFreedom: Int, expectedKurtosis: Double) async throws {
    let kurtosis = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (2, 1.0, 0.3032653),
      (2, 0.0, 0.5),
      (2, 0.4, 0.4093654),
      (7, 1.0, 0.01613138),
      (7, 2.5, 0.07530100),
      (7, 15.0, 0.01281853),
      (50, 0.1, 0.0),
      (50, 0.001, 0.0),
      (50, 15.0, 0.0),
      (50, 50.0, 0.039761475734),
    ]
  )
  func validInputReturnsCorrectPDF(degreesOfFreedom: Int, x: Double, expectedPDF: Double) async throws {
    let pdf = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (2, 1.0, -1.1931472),
      (2, 0.0, -0.6931472),
      (2, 0.4, -0.8931472),
      (7, 1.0, -4.126989),
      (7, 2.5, -2.586262),
      (7, 15.0, -4.356863),
      (50, 0.1, -127.425451),
      (50, 0.001, -237.900036),
      (50, 15.0, -14.620204),
      (50, 50.0, -3.224857),
    ]
  )
  func validInputReturnsCorrectLogPDF(degreesOfFreedom: Int, x: Double, expectedLogPDF: Double) async throws {
    let pdf = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (2, 1.0, 0.3934693402873665),
      (2, 0.0, 0.0),
      (2, 0.4, 0.18126924692201815),
      (7, 1.0, 0.005171463),
      (7, 2.5, 0.072902935),
      (7, 15.0, 0.964000595),
      (50, 0.1, 0.0),
      (50, 0.001, 0.0),
      (50, 15.0, 0.0),
      (50, 50.0, 0.52660153),
    ]
  )
  func validInputReturnsCorrectCDF(degreesOfFreedom: Int, x: Double, expectedCDF: Double) async throws {
    let cdf = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (2, 1.0, -0.9327521),
      (2, 0.0, -Double.infinity),
      (2, 0.4, -1.7077718),
      (7, 0.1, -12.97764902),
      (7, 0.001, -29.05728406),
      (7, 15.0, -0.03666337),
      (50, 0.1, -132.9449873),
      (50, 0.001, -248.0266475),
      (50, 15.0, -14.7963960),
      (50, 50.0, -0.6413111),
    ]
  )
  func validInputReturnsCorrectLogCDF(degreesOfFreedom: Int, x: Double, expectedLogCDF: Double) async throws {
    let cdf = ChiSquaredDistribution(degreesOfFreedom: degreesOfFreedom).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = ChiSquaredDistribution(degreesOfFreedom: 7)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0, default: 0.0].isApproximatelyEqual(to: 0.005171463, absoluteTolerance: 1e-3))
    #expect(proportions[1, default: 0.0].isApproximatelyEqual(to: 0.034988168, absoluteTolerance: 1e-3))
    #expect(proportions[2, default: 0.0].isApproximatelyEqual(to: 0.074838137, absoluteTolerance: 1e-3))
    #expect(proportions[3, default: 0.0].isApproximatelyEqual(to: 0.105224823, absoluteTolerance: 1e-3))
    #expect(proportions[4, default: 0.0].isApproximatelyEqual(to: 0.119814179, absoluteTolerance: 1e-3))
    #expect(proportions[5, default: 0.0].isApproximatelyEqual(to: 0.120213879, absoluteTolerance: 1e-3))
    #expect(proportions[6, default: 0.0].isApproximatelyEqual(to: 0.110869493, absoluteTolerance: 1e-3))
  }
}
