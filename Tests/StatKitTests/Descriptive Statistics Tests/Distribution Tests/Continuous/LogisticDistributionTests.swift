import Testing
import StatKit

@Suite("Logistic Distribution Tests", .tags(.distribution))
struct LogisticDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0.0, 1.0, 0.0),
      (2.0, 3.0, 2.0),
    ]
  )
  func validInputReturnsCorrectMean(mu: Double, scale: Double, expectedMean: Double) async throws {
    let mean = LogisticDistribution(mu: mu, scale: scale).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0.0, 1.0,  3.289868134),
      (2.0, 3.0, 29.608813203),
    ]
  )
  func validInputReturnsCorrectVariance(mu: Double, scale: Double, expectedVariance: Double) async throws {
    let variance = LogisticDistribution(mu: mu, scale: scale).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0.0, 1.0, 0.0),
      (2.0, 3.0, 0.0),
    ]
  )
  func validInputReturnsCorrectSkewness(mu: Double, scale: Double, expectedSkewness: Double) async throws {
    let skewness = LogisticDistribution(mu: mu, scale: scale).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0.0, 1.0, 1.2),
      (2.0, 3.0, 1.2),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(mu: Double, scale: Double, expectedKurtosis: Double) async throws {
    let kurtosis = LogisticDistribution(mu: mu, scale: scale).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0.0, 1.0, -2.0, 0.119202922),
      (0.0, 1.0, -1.0, 0.268941421),
      (0.0, 1.0,  0.0, 0.500000000),
      (0.0, 1.0,  1.0, 0.731058579),
      (0.0, 1.0,  2.0, 0.880797078),
      (2.0, 3.0, -1.0, 0.268941420),
      (2.0, 3.0,  2.0, 0.500000000),
      (2.0, 3.0,  5.0, 0.731058580),
    ]
  )
  func validInputReturnsCorrectCDF(mu: Double, scale: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = LogisticDistribution(mu: mu, scale: scale).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (0.0, 1.0, -2.0, -2.126928011),
      (0.0, 1.0,  0.0, -0.693147181),
      (0.0, 1.0,  2.0, -0.126928011),
      (2.0, 3.0, -1.0, -1.3132617),
      (2.0, 3.0,  2.0, -0.6931472),
      (2.0, 3.0,  5.0, -0.3132617),
    ]
  )
  func validInputReturnsCorrectLogCDF(mu: Double, scale: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = LogisticDistribution(mu: mu, scale: scale).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (0.0, 1.0, -2.0, 0.104993585),
      (0.0, 1.0, -1.0, 0.196611933),
      (0.0, 1.0,  0.0, 0.250000000),
      (0.0, 1.0,  1.0, 0.196611933),
      (0.0, 1.0,  2.0, 0.104993585),
      (2.0, 3.0, -1.0, 0.065537310),
      (2.0, 3.0,  2.0, 0.083333330),
      (2.0, 3.0,  5.0, 0.065537310),
    ]
  )
  func validInputReturnsCorrectPDF(mu: Double, scale: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = LogisticDistribution(mu: mu, scale: scale).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (0.0, 1.0, -2.0, -2.253856),
      (0.0, 1.0, -1.0, -1.626523),
      (0.0, 1.0,  0.0, -1.386294),
      (0.0, 1.0,  1.0, -1.626523),
      (0.0, 1.0,  2.0, -2.253856),
      (2.0, 3.0, -1.0, -2.725136),
      (2.0, 3.0,  2.0, -2.484907),
      (2.0, 3.0,  5.0, -2.725136),
    ]
  )
  func validInputReturnsCorrectLogPDF(mu: Double, scale: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = LogisticDistribution(mu: mu, scale: scale).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "PDF at ±infinity returns correct value",
    arguments: [(0.0, 1.0), (2.0, 3.0)]
  )
  func pdfAtInfinityIsZero(mu: Double, scale: Double) async throws {
    let distribution = LogisticDistribution(mu: mu, scale: scale)
    #expect(distribution.pdf(x: .infinity) == 0)
    #expect(distribution.pdf(x: -.infinity) == 0)
  }

  @Test(
    "Log PDF at ±infinity returns correct value",
    arguments: [(0.0, 1.0), (2.0, 3.0)]
  )
  func logPDFAtInfinityIsNegativeInfinity(mu: Double, scale: Double) async throws {
    let distribution = LogisticDistribution(mu: mu, scale: scale)
    #expect(distribution.pdf(x: .infinity, logarithmic: true) == -.infinity)
    #expect(distribution.pdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "CDF at ±infinity returns correct value",
    arguments: [(0.0, 1.0), (2.0, 3.0)]
  )
  func cdfAtInfinityIsCorrect(mu: Double, scale: Double) async throws {
    let distribution = LogisticDistribution(mu: mu, scale: scale)
    #expect(distribution.cdf(x: -.infinity) == 0)
    #expect(distribution.cdf(x: .infinity) == 1)
  }

  @Test(
    "Log CDF at ±infinity returns correct value",
    arguments: [(0.0, 1.0), (2.0, 3.0)]
  )
  func logCDFAtInfinityIsCorrect(mu: Double, scale: Double) async throws {
    let distribution = LogisticDistribution(mu: mu, scale: scale)
    #expect(distribution.cdf(x: -.infinity, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: .infinity, logarithmic: true) == 0)
  }

#if swift(>=6.2)
  @Test("Non-positive scale triggers a precondition failure")
  func nonPositiveScaleTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = LogisticDistribution(mu: 0, scale: 0)
    }
  }

  @Test("Non-positive sample count triggers a precondition failure")
  func nonPositiveSampleCountTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = LogisticDistribution(mu: 0, scale: 1).sample(0)
    }
  }
#endif

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1_000_000
    let distribution = LogisticDistribution(mu: 0, scale: 1)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number.rounded(.down)), default: 0] += 1 }
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[-5, default: 0.0].isApproximatelyEqual(to: 0.01129336, absoluteTolerance: 0.01))
    #expect(proportions[-4, default: 0.0].isApproximatelyEqual(to: 0.02943966, absoluteTolerance: 0.01))
    #expect(proportions[-3, default: 0.0].isApproximatelyEqual(to: 0.07177705, absoluteTolerance: 0.01))
    #expect(proportions[-2, default: 0.0].isApproximatelyEqual(to: 0.14973850, absoluteTolerance: 0.01))
    #expect(proportions[-1, default: 0.0].isApproximatelyEqual(to: 0.23105858, absoluteTolerance: 0.01))
    #expect(proportions[ 0, default: 0.0].isApproximatelyEqual(to: 0.23105858, absoluteTolerance: 0.01))
    #expect(proportions[ 1, default: 0.0].isApproximatelyEqual(to: 0.14973850, absoluteTolerance: 0.01))
    #expect(proportions[ 2, default: 0.0].isApproximatelyEqual(to: 0.07177705, absoluteTolerance: 0.01))
    #expect(proportions[ 3, default: 0.0].isApproximatelyEqual(to: 0.02943966, absoluteTolerance: 0.01))
    #expect(proportions[ 4, default: 0.0].isApproximatelyEqual(to: 0.01129336, absoluteTolerance: 0.01))
  }
}
