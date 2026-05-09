import Testing
import StatKit

@Suite("Poisson Distribution Tests", .tags(.distribution))
struct PoissonDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (1.0, 1.0),
      (57.0, 57.0),
    ]
  )
  func validInputReturnsCorrectMean(rate: Double, expectedMean: Double) async throws {
    let mean = PoissonDistribution(rate: rate).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (1.0, 1.0),
      (57.0, 57.0),
    ]
  )
  func validInputReturnsCorrectVariance(rate: Double, expectedVariance: Double) async throws {
    let variance = PoissonDistribution(rate: rate).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (1.0, 1.0),
      (57.0, 0.1324532357),
    ]
  )
  func validInputReturnsCorrectSkewness(rate: Double, expectedSkewness: Double) async throws {
    let skewness = PoissonDistribution(rate: rate).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (1.0, 1.0),
      (57.0, 0.01754386),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(rate: Double, expectedKurtosis: Double) async throws {
    let kurtosis = PoissonDistribution(rate: rate).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (1.0, 1, 0.73575888),
      (1.0, 0, 0.36788),
      (1.0, 6, 0.9999168),
      (8.0, 1, 0.00302),
      (8.0, 0, 0.00033546),
      (8.0, 6, 0.31337428),
    ]
  )
  func validInputReturnsCorrectCDF(rate: Double, x: Int, expectedCDF: Double) async throws {
    let cdf = PoissonDistribution(rate: rate).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (1.0, 1, -0.30685281944),
      (1.0, 0, -1.00000000000),
      (1.0, 6, -0.00008324461),
      (8.0, 1, -5.802775),
      (8.0, 0, -8.000000),
      (8.0, 6, -1.160357),
    ]
  )
  func validInputReturnsCorrectLogCDF(rate: Double, x: Int, expectedLogCDF: Double) async throws {
    let cdf = PoissonDistribution(rate: rate).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = PoissonDistribution(rate: 2)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[number, default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0, default: 0.0].isApproximatelyEqual(to: 0.13533, absoluteTolerance: 0.01))
    #expect(proportions[1, default: 0.0].isApproximatelyEqual(to: 0.27067, absoluteTolerance: 0.01))
    #expect(proportions[2, default: 0.0].isApproximatelyEqual(to: 0.27067, absoluteTolerance: 0.01))
    #expect(proportions[3, default: 0.0].isApproximatelyEqual(to: 0.18044, absoluteTolerance: 0.01))
  }
}
