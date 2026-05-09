import Testing
import StatKit

@Suite("Discrete Uniform Distribution Tests", .tags(.distribution))
struct DiscreteUniformDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0, 1, 0.5),
      (-4, 9, 2.5),
    ]
  )
  func validInputReturnsCorrectMean(lower: Int, upper: Int, expectedMean: Double) async throws {
    let mean = DiscreteUniformDistribution(lower, upper).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0, 1, 0.25),
      (-4, 9, 16.25),
    ]
  )
  func validInputReturnsCorrectVariance(lower: Int, upper: Int, expectedVariance: Double) async throws {
    let variance = DiscreteUniformDistribution(lower, upper).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0, 1, 0.0),
      (-4, 9, 0.0),
    ]
  )
  func validInputReturnsCorrectSkewness(lower: Int, upper: Int, expectedSkewness: Double) async throws {
    let skewness = DiscreteUniformDistribution(lower, upper).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0, 1, -2.0),
      (-4, 9, -1.2123076923),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(lower: Int, upper: Int, expectedKurtosis: Double) async throws {
    let kurtosis = DiscreteUniformDistribution(lower, upper).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0, 1, 1, 1.0),
      (0, 1, 0, 0.5),
      (0, 1, -1, 0.0),
      (-4, 9, 10, 1.0),
      (-4, 9, -8, 0.0),
      (-4, 9, 0, 5.0 / 14.0),
    ]
  )
  func validInputReturnsCorrectCDF(lower: Int, upper: Int, x: Int, expectedCDF: Double) async throws {
    let cdf = DiscreteUniformDistribution(lower, upper).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (0, 1, 1, 0.0),
      (0, 1, 0, -0.6931471806),
      (0, 1, -1, -Double.infinity),
      (-4, 9, 10, 0.0),
      (-4, 9, -8, -Double.infinity),
      (-4, 9, 0, -1.0296194172),
    ]
  )
  func validInputReturnsCorrectLogCDF(lower: Int, upper: Int, x: Int, expectedLogCDF: Double) async throws {
    let cdf = DiscreteUniformDistribution(lower, upper).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let lower = 1
    let upper = 10
    let distribution = DiscreteUniformDistribution(lower, upper)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in
      result[number, default: 0] += 1
    }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)

    for index in lower ... upper {
      #expect(proportions[index, default: 0.0].isApproximatelyEqual(to: 0.1, absoluteTolerance: 0.01))
    }
  }
}
