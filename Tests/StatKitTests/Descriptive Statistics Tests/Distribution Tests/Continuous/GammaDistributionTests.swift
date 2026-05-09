import Testing
import StatKit

@Suite("Gamma Distribution Tests", .tags(.distribution))
struct GammaDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (1.0, 1.0, 1.0),
      (0.5, 10.0, 5.0),
    ]
  )
  func validInputReturnsCorrectMean(shape: Double, scale: Double, expectedMean: Double) async throws {
    let mean = GammaDistribution(shape: shape, scale: scale).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (1.0, 1.0, 1.0),
      (0.5, 10.0, 50.0),
    ]
  )
  func validInputReturnsCorrectVariance(shape: Double, scale: Double, expectedVariance: Double) async throws {
    let variance = GammaDistribution(shape: shape, scale: scale).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (1.0, 1.0, 2.0),
      (0.5, 10.0, 2.828427),
    ]
  )
  func validInputReturnsCorrectSkewness(shape: Double, scale: Double, expectedSkewness: Double) async throws {
    let skewness = GammaDistribution(shape: shape, scale: scale).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (1.0, 1.0, 6.0),
      (0.5, 10.0, 12.0),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(shape: Double, scale: Double, expectedKurtosis: Double) async throws {
    let kurtosis = GammaDistribution(shape: shape, scale: scale).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid scale-initialised distribution parameters return correct CDF value",
    arguments: [
      (1.0, 1.0, 1.0, 0.6321206),
      (1.0, 1.0, 0.0, 0.0),
      (1.0, 1.0, 0.4, 0.32968),
    ]
  )
  func validScaleInputReturnsCorrectCDF(shape: Double, scale: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = GammaDistribution(shape: shape, scale: scale).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid rate-initialised distribution parameters return correct CDF value",
    arguments: [
      (0.5, 10.0, 0.1, 0.8427008),
      (0.5, 10.0, 0.001, 0.1124629),
      (0.5, 10.0, 15.0, 1.0),
      (1000.0, 20.0, 0.1, 0.0),
      (1000.0, 20.0, 0.001, 0.0),
      (1000.0, 20.0, 15.0, 0.0),
      (1000.0, 20.0, 50.0, 0.5042052),
    ]
  )
  func validRateInputReturnsCorrectCDF(shape: Double, rate: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = GammaDistribution(shape: shape, rate: rate).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid scale-initialised distribution parameters return correct log CDF value",
    arguments: [
      (1.0, 1.0, 1.0, -0.4586751),
      (1.0, 1.0, 0.0, -Double.infinity),
      (1.0, 1.0, 0.4, -1.1096329),
    ]
  )
  func validScaleInputReturnsCorrectLogCDF(shape: Double, scale: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = GammaDistribution(shape: shape, scale: scale).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid rate-initialised distribution parameters return correct log CDF value",
    arguments: [
      (0.5, 10.0, 0.1, -0.1711433),
      (0.5, 10.0, 0.001, -2.185132),
      (0.5, 10.0, 15.0, 0.0),
      (1000.0, 20.0, 0.1, -5220.9789979),
      (1000.0, 20.0, 0.001, -9824.1711639),
      (1000.0, 20.0, 15.0, -507.9896393),
      (1000.0, 20.0, 50.0, -0.6847719),
    ]
  )
  func validRateInputReturnsCorrectLogCDF(shape: Double, rate: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = GammaDistribution(shape: shape, rate: rate).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution with shape ≥ 1 returns correct proportions")
  func testSamplingShapeGreaterThanOne() async throws {
    let numberOfSamples = 1000000
    let distribution = GammaDistribution(shape: 7.5, scale: 3)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[2, default: 0.0].isApproximatelyEqual(to: 0.000027759390, absoluteTolerance: 0.01))
    #expect(proportions[3, default: 0.0].isApproximatelyEqual(to: 0.000162396697, absoluteTolerance: 0.01))
    #expect(proportions[4, default: 0.0].isApproximatelyEqual(to: 0.000575600420, absoluteTolerance: 0.01))
    #expect(proportions[5, default: 0.0].isApproximatelyEqual(to: 0.001495003753, absoluteTolerance: 0.01))
    #expect(proportions[6, default: 0.0].isApproximatelyEqual(to: 0.003145153584, absoluteTolerance: 0.01))
  }

  @Test("Sampling from a distribution with shape < 1 returns correct proportions")
  func testSamplingShapeLessThanOne() async throws {
    let numberOfSamples = 1000000
    let distribution = GammaDistribution(shape: 0.5, scale: 1)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Double: Double]()) { result, number in result[(number * 10).rounded(.down) / 10, default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0.0, default: 0.0].isApproximatelyEqual(to: 0.34527915398, absoluteTolerance: 0.01))
    #expect(proportions[0.1, default: 0.0].isApproximatelyEqual(to: 0.12763158915, absoluteTolerance: 0.01))
    #expect(proportions[0.2, default: 0.0].isApproximatelyEqual(to: 0.08851123078, absoluteTolerance: 0.01))
    #expect(proportions[0.3, default: 0.0].isApproximatelyEqual(to: 0.06748465656, absoluteTolerance: 0.01))
    #expect(proportions[0.4, default: 0.0].isApproximatelyEqual(to: 0.05378286166, absoluteTolerance: 0.01))
    #expect(proportions[0.5, default: 0.0].isApproximatelyEqual(to: 0.04398882957, absoluteTolerance: 0.01))
    #expect(proportions[0.6, default: 0.0].isApproximatelyEqual(to: 0.03659810765, absoluteTolerance: 0.01))
  }
}
