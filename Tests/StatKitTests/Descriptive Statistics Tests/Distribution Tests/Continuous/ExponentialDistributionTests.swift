import Testing
import StatKit

@Suite("Exponential Distribution Tests", .tags(.distribution))
struct ExponentialDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (1.0,  1.0),
      (57.0, 0.0175438),
    ]
  )
  func validInputReturnsCorrectMean(rate: Double, expectedMean: Double) async throws {
    let mean = ExponentialDistribution(rate: rate).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (1.0,  1.0),
      (57.0, 0.000307787),
    ]
  )
  func validInputReturnsCorrectVariance(rate: Double, expectedVariance: Double) async throws {
    let variance = ExponentialDistribution(rate: rate).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (1.0,  2.0),
      (57.0, 2.0),
    ]
  )
  func validInputReturnsCorrectSkewness(rate: Double, expectedSkewness: Double) async throws {
    let skewness = ExponentialDistribution(rate: rate).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (1.0,  6.0),
      (57.0, 6.0),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(rate: Double, expectedKurtosis: Double) async throws {
    let kurtosis = ExponentialDistribution(rate: rate).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (1.0,  1.0,  0.6321206),
      (1.0,  0.0,  0.0),
      (1.0,  0.4,  0.3296800),
      (57.0, 0.1,  0.9966540),
      (57.0, -8.0, 0.0),
      (57.0, 0.0,  0.0),
    ]
  )
  func validInputReturnsCorrectCDF(rate: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = ExponentialDistribution(rate: rate).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (1.0,  1.0,  -0.4586751),
      (1.0,  0.0,  -Double.infinity),
      (1.0,  0.4,  -1.1096329),
      (57.0, 0.1,  -0.003351576),
      (57.0, -8.0, -Double.infinity),
      (57.0, 0.0,  -Double.infinity),
    ]
  )
  func validInputReturnsCorrectLogCDF(rate: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = ExponentialDistribution(rate: rate).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (1.0,  0.0,  1.0),
      (1.0,  0.4,  0.6703200),
      (1.0,  1.0,  0.3678794),
      (1.0,  -1.0, 0.0),
      (57.0, 0.0,  57.0),
      (57.0, 0.1,  0.190720031),
    ]
  )
  func validInputReturnsCorrectPDF(rate: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = ExponentialDistribution(rate: rate).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (1.0,  0.0,   0.0),
      (1.0,  0.4,  -0.4),
      (1.0,  1.0,  -1.0),
      (1.0,  -1.0, -Double.infinity),
      (57.0, 0.0,   4.043051),
      (57.0, 0.1,  -1.656949),
    ]
  )
  func validInputReturnsCorrectLogPDF(rate: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = ExponentialDistribution(rate: rate).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "PDF at +infinity returns zero",
    arguments: [1.0, 57.0]
  )
  func pdfAtInfinityIsZero(rate: Double) async throws {
    #expect(ExponentialDistribution(rate: rate).pdf(x: .infinity) == 0)
  }

  @Test(
    "Log PDF at +infinity returns -infinity",
    arguments: [1.0, 57.0]
  )
  func logPDFAtInfinityIsNegativeInfinity(rate: Double) async throws {
    #expect(ExponentialDistribution(rate: rate).pdf(x: .infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "CDF at ±infinity returns correct value",
    arguments: [1.0, 57.0]
  )
  func cdfAtInfinityIsCorrect(rate: Double) async throws {
    let distribution = ExponentialDistribution(rate: rate)
    #expect(distribution.cdf(x: -.infinity) == 0)
    #expect(distribution.cdf(x: .infinity) == 1)
  }

  @Test(
    "Log CDF at ±infinity returns correct value",
    arguments: [1.0, 57.0]
  )
  func logCDFAtInfinityIsCorrect(rate: Double) async throws {
    let distribution = ExponentialDistribution(rate: rate)
    #expect(distribution.cdf(x: -.infinity, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: .infinity, logarithmic: true) == 0)
  }

#if swift(>=6.2)
  @Test("Non-positive rate triggers a precondition failure")
  func nonPositiveRateTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ExponentialDistribution(rate: 0)
    }
  }

  @Test("Non-positive sample count triggers a precondition failure")
  func nonPositiveSampleCountTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ExponentialDistribution(rate: 1).sample(0)
    }
  }
#endif

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1_000_000
    let distribution = ExponentialDistribution(rate: 0.2)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0, default: 0.0].isApproximatelyEqual(to: 0.18126, absoluteTolerance: 0.01))
    #expect(proportions[1, default: 0.0].isApproximatelyEqual(to: 0.14841, absoluteTolerance: 0.01))
    #expect(proportions[2, default: 0.0].isApproximatelyEqual(to: 0.12150, absoluteTolerance: 0.01))
    #expect(proportions[3, default: 0.0].isApproximatelyEqual(to: 0.09948, absoluteTolerance: 0.01))
  }
}
