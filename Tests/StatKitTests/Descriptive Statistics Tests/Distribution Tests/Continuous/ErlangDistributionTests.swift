import Testing
import StatKit

@Suite("Erlang Distribution Tests", .tags(.distribution))
struct ErlangDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (1, 1.0, 1.0),
      (5, 10.0, 50.0),
    ]
  )
  func validInputReturnsCorrectMean(shape: Int, scale: Double, expectedMean: Double) async throws {
    let mean = ErlangDistribution(shape: shape, scale: scale).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (1, 1.0, 1.0),
      (5, 10.0, 500.0),
    ]
  )
  func validInputReturnsCorrectVariance(shape: Int, scale: Double, expectedVariance: Double) async throws {
    let variance = ErlangDistribution(shape: shape, scale: scale).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (1, 1.0, 2.0),
      (5, 10.0, 0.894427191),
    ]
  )
  func validInputReturnsCorrectSkewness(shape: Int, scale: Double, expectedSkewness: Double) async throws {
    let skewness = ErlangDistribution(shape: shape, scale: scale).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (1, 1.0, 6.0),
      (5, 10.0, 1.2),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(shape: Int, scale: Double, expectedKurtosis: Double) async throws {
    let kurtosis = ErlangDistribution(shape: shape, scale: scale).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid scale-initialised distribution parameters return correct CDF value",
    arguments: [
      (1, 1.0, 1.0, 0.6321206),
      (1, 1.0, 0.0, 0.0),
      (1, 1.0, 0.4, 0.32968),
    ]
  )
  func validScaleInputReturnsCorrectCDF(shape: Int, scale: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = ErlangDistribution(shape: shape, scale: scale).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid rate-initialised distribution parameters return correct CDF value",
    arguments: [
      (5, 10.0, 0.1, 0.0036598468),
      (5, 10.0, 0.001, 0.0),
      (5, 10.0, 15.0, 1.0),
      (1000, 20.0, 0.1, 0.0),
      (1000, 20.0, 0.001, 0.0),
      (1000, 20.0, 15.0, 0.0),
      (1000, 20.0, 50.0, 0.5042052),
    ]
  )
  func validRateInputReturnsCorrectCDF(shape: Int, rate: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = ErlangDistribution(shape: shape, rate: rate).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid scale-initialised distribution parameters return correct log CDF value",
    arguments: [
      (1, 1.0, 1.0, -0.4586751),
      (1, 1.0, 0.0, -Double.infinity),
      (1, 1.0, 0.4, -1.1096329),
    ]
  )
  func validScaleInputReturnsCorrectLogCDF(shape: Int, scale: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = ErlangDistribution(shape: shape, scale: scale).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid rate-initialised distribution parameters return correct log CDF value",
    arguments: [
      (5, 10.0, 0.1, -5.610333982897),
      (5, 10.0, 0.001, -27.82167501344099),
      (5, 10.0, 15.0, 0.0),
      (1000, 20.0, 0.1, -5220.9789979),
      (1000, 20.0, 0.001, -9824.1711639),
      (1000, 20.0, 15.0, -507.9896393),
      (1000, 20.0, 50.0, -0.6847719),
    ]
  )
  func validRateInputReturnsCorrectLogCDF(shape: Int, rate: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = ErlangDistribution(shape: shape, rate: rate).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = ErlangDistribution(shape: 8, scale: 3)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[2, default: 0.0].isApproximatelyEqual(to: 0.0000097129388, absoluteTolerance: 0.01))
    #expect(proportions[3, default: 0.0].isApproximatelyEqual(to: 0.0000661934135, absoluteTolerance: 0.01))
    #expect(proportions[4, default: 0.0].isApproximatelyEqual(to: 0.0002642227930, absoluteTolerance: 0.01))
    #expect(proportions[5, default: 0.0].isApproximatelyEqual(to: 0.0007560535647, absoluteTolerance: 0.01))
    #expect(proportions[6, default: 0.0].isApproximatelyEqual(to: 0.0017257012298, absoluteTolerance: 0.01))
  }
}
