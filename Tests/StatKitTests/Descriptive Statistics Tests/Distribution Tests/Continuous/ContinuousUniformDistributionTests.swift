import Testing
import StatKit

@Suite("Continuous Uniform Distribution Tests", .tags(.distribution))
struct ContinuousUniformDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0.0, 1.0, 0.5),
      (-4.0, 9.0, 2.5),
    ]
  )
  func validInputReturnsCorrectMean(lower: Double, upper: Double, expectedMean: Double) async throws {
    let mean = ContinuousUniformDistribution(lower, upper).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0.0, 1.0, 1.0 / 12.0),
      (-4.0, 9.0, 14.083333333),
    ]
  )
  func validInputReturnsCorrectVariance(lower: Double, upper: Double, expectedVariance: Double) async throws {
    let variance = ContinuousUniformDistribution(lower, upper).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0.0, 1.0, 0.0),
      (-4.0, 9.0, 0.0),
    ]
  )
  func validInputReturnsCorrectSkewness(lower: Double, upper: Double, expectedSkewness: Double) async throws {
    let skewness = ContinuousUniformDistribution(lower, upper).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0.0, 1.0, -6.0 / 5.0),
      (-4.0, 9.0, -6.0 / 5.0),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(lower: Double, upper: Double, expectedKurtosis: Double) async throws {
    let kurtosis = ContinuousUniformDistribution(lower, upper).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0.0, 1.0, 1.0, 1.0),
      (0.0, 1.0, 0.0, 0.0),
      (0.0, 1.0, 0.4, 0.4),
      (-4.0, 9.0, 10.0, 1.0),
      (-4.0, 9.0, -8.0, 0.0),
      (-4.0, 9.0, 0.0, 4.0 / 13.0),
    ]
  )
  func validInputReturnsCorrectCDF(lower: Double, upper: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = ContinuousUniformDistribution(lower, upper).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (0.0, 1.0, 1.0, 0.0),
      (0.0, 1.0, 0.0, -Double.infinity),
      (0.0, 1.0, 0.4, -0.9162907319),
      (-4.0, 9.0, 10.0, 0.0),
      (-4.0, 9.0, -8.0, -Double.infinity),
      (-4.0, 9.0, 0.0, -1.1786549963),
    ]
  )
  func validInputReturnsCorrectLogCDF(lower: Double, upper: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = ContinuousUniformDistribution(lower, upper).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = ContinuousUniformDistribution(0, 1)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Double: Double]()) { result, number in
      let index = (number * 10).rounded(.down) / 10
      result[index, default: 0] += 1
    }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0.0, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.1, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.2, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.3, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.4, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.5, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.6, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.7, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.8, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    #expect(proportions[0.9, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
  }
}
