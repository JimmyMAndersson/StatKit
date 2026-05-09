import Testing
import StatKit

@Suite("Geometric Distribution Tests", .tags(.distribution))
struct GeometricDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0.5, 2.0),
      (0.7, 1.428571),
    ]
  )
  func validInputReturnsCorrectMean(probability: Double, expectedMean: Double) async throws {
    let mean = GeometricDistribution(probability: probability).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0.5, 2.0),
      (0.7, 0.6122449),
    ]
  )
  func validInputReturnsCorrectVariance(probability: Double, expectedVariance: Double) async throws {
    let variance = GeometricDistribution(probability: probability).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0.5, 2.12132),
      (0.7, 2.373464),
    ]
  )
  func validInputReturnsCorrectSkewness(probability: Double, expectedSkewness: Double) async throws {
    let skewness = GeometricDistribution(probability: probability).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0.5, 6.5),
      (0.7, 7.63333333),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(probability: Double, expectedKurtosis: Double) async throws {
    let kurtosis = GeometricDistribution(probability: probability).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0.5, 1, 0.5),
      (0.5, 3, 0.875),
      (0.5, 7, 0.9921875),
      (0.7, 1, 0.7),
      (0.7, 3, 0.973),
      (0.7, 7, 0.9997813),
    ]
  )
  func validInputReturnsCorrectCDF(probability: Double, x: Int, expectedCDF: Double) async throws {
    let cdf = GeometricDistribution(probability: probability).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (0.5, 1, -0.693147181),
      (0.5, 3, -0.133531393),
      (0.5, 7, -0.007843177),
      (0.7, 1, -0.3566749439),
      (0.7, 3, -0.0273711968),
      (0.7, 7, -0.0002187239),
    ]
  )
  func validInputReturnsCorrectLogCDF(probability: Double, x: Int, expectedLogCDF: Double) async throws {
    let cdf = GeometricDistribution(probability: probability).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = GeometricDistribution(probability: 0.7)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[number, default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)

    for x in 1 ... 10 {
      #expect(proportions[x, default: 0.0].isApproximatelyEqual(to: distribution.pmf(x: x), absoluteTolerance: 0.01))
    }
  }
}
