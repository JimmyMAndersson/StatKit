import Testing
import StatKit

@Suite("Beta Distribution Tests", .tags(.distribution))
struct BetaDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (1.0, 1.0, 0.5),
      (5.0, 2.0, 0.7142857),
    ]
  )
  func validInputReturnsCorrectMean(alpha: Double, beta: Double, expectedMean: Double) async throws {
    let mean = BetaDistribution(alpha: alpha, beta: beta).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (1.0, 1.0, 0.08333333),
      (5.0, 2.0, 0.02551020),
    ]
  )
  func validInputReturnsCorrectVariance(alpha: Double, beta: Double, expectedVariance: Double) async throws {
    let variance = BetaDistribution(alpha: alpha, beta: beta).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (1.0, 1.0, 0.0),
      (5.0, 2.0, -0.59628479),
    ]
  )
  func validInputReturnsCorrectSkewness(alpha: Double, beta: Double, expectedSkewness: Double) async throws {
    let skewness = BetaDistribution(alpha: alpha, beta: beta).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (1.0, 1.0, -1.2),
      (5.0, 2.0, -0.12),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(alpha: Double, beta: Double, expectedKurtosis: Double) async throws {
    let kurtosis = BetaDistribution(alpha: alpha, beta: beta).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (1.0, 1.0, -1.0, 0.0),
      (1.0, 1.0, 0.0, 0.0),
      (1.0, 1.0, 0.1, 0.1),
      (1.0, 1.0, 0.9, 0.9),
      (1.0, 1.0, 0.4, 0.4),
      (1.0, 1.0, 1.0, 1.0),
      (1.0, 1.0, 2.0, 1.0),
      (5.0, 2.0, -1.0, 0.0),
      (5.0, 2.0, 0.0, 0.0),
      (5.0, 2.0, 0.1, 0.000055),
      (5.0, 2.0, 0.9, 0.885735),
      (5.0, 2.0, 0.4, 0.040960),
      (5.0, 2.0, 1.0, 1.0),
      (5.0, 2.0, 2.0, 1.0),
      (0.1, 5000.0, -1.0, 0.0),
      (0.1, 5000.0, 0.0, 0.0),
      (0.1, 5000.0, 0.1, 1.0),
      (0.1, 5000.0, 0.9, 1.0),
      (0.1, 5000.0, 0.4, 1.0),
      (0.1, 5000.0, 1.0, 1.0),
      (0.1, 5000.0, 2.0, 1.0),
      (0.1, 0.1, -1.0, 0.0),
      (0.1, 0.1, 0.0, 0.0),
      (0.1, 0.1, 0.1, 0.4063851),
      (0.1, 0.1, 0.9, 0.5936149),
      (0.1, 0.1, 0.4, 0.4821200),
      (0.1, 0.1, 1.0, 1.0),
      (0.1, 0.1, 2.0, 1.0),
      (5000.0, 5000.0, -1.0, 0.0),
      (5000.0, 5000.0, 0.0, 0.0),
      (5000.0, 5000.0, 0.1, 0.0),
      (5000.0, 5000.0, 0.9, 1.0),
      (5000.0, 5000.0, 0.4, 4.518544e-91),
      (5000.0, 5000.0, 1.0, 1.0),
      (5000.0, 5000.0, 2.0, 1.0),
      (10000.0, 1.0, -1.0, 0.0),
      (10000.0, 1.0, 0.0, 0.0),
      (10000.0, 1.0, 0.1, 0.0),
      (10000.0, 1.0, 0.9, 0.0),
      (10000.0, 1.0, 0.4, 0.0),
      (10000.0, 1.0, 1.0, 1.0),
      (10000.0, 1.0, 2.0, 1.0),
    ]
  )
  func validInputReturnsCorrectCDF(alpha: Double, beta: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = BetaDistribution(alpha: alpha, beta: beta).cdf(x: x, logarithmic: false)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (1.0, 1.0, -1.0, -Double.infinity),
      (1.0, 1.0, 0.0, -Double.infinity),
      (1.0, 1.0, 0.1, -2.3025851),
      (1.0, 1.0, 0.9, -0.1053605),
      (1.0, 1.0, 0.4, -0.9162907),
      (1.0, 1.0, 1.0, 0.0),
      (1.0, 1.0, 2.0, 0.0),
      (5.0, 2.0, -1.0, -Double.infinity),
      (5.0, 2.0, 0.0, -Double.infinity),
      (5.0, 2.0, 0.1, -9.8081774),
      (5.0, 2.0, 0.9, -0.1213375),
      (5.0, 2.0, 0.4, -3.1951593),
      (5.0, 2.0, 1.0, 0.0),
      (5.0, 2.0, 2.0, 0.0),
      (0.1, 5000.0, -1.0, -Double.infinity),
      (0.1, 5000.0, 0.0, -Double.infinity),
      (0.1, 5000.0, 0.1, 0.0),
      (0.1, 5000.0, 0.9, 0.0),
      (0.1, 5000.0, 0.4, 0.0),
      (0.1, 5000.0, 1.0, 0.0),
      (0.1, 5000.0, 2.0, 0.0),
    ]
  )
  func validInputReturnsCorrectLogCDF(alpha: Double, beta: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = BetaDistribution(alpha: alpha, beta: beta).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (1.0, 1.0, 0.1, 1.0),
      (1.0, 1.0, 0.9, 1.0),
      (1.0, 1.0, 0.4, 1.0),
      (5.0, 2.0, 0.1, 0.0027),
      (5.0, 2.0, 0.9, 1.9683),
      (5.0, 2.0, 0.4, 0.4608),
      // Boundary points: x = 0
      (0.5, 0.5, 0.0, Double.infinity),  // alpha < 1 → +∞
      (0.9, 0.9, 0.0, Double.infinity),  // alpha < 1 → +∞
      (1.0, 1.0, 0.0, 1.0),             // alpha = 1 → 1/B(α,β) = 1
      (2.0, 2.0, 0.0, 0.0),             // alpha > 1 → 0
      // Boundary points: x = 1
      (0.5, 0.5, 1.0, Double.infinity),  // beta < 1 → +∞
      (0.9, 0.9, 1.0, Double.infinity),  // beta < 1 → +∞
      (1.0, 1.0, 1.0, 1.0),             // beta = 1 → 1/B(α,β) = 1
      (2.0, 2.0, 1.0, 0.0),             // beta > 1 → 0
    ]
  )
  func validInputReturnsCorrectPDF(alpha: Double, beta: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = BetaDistribution(alpha: alpha, beta: beta).pdf(x: x, logarithmic: false)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (1.0, 1.0, -1.0, -Double.infinity),
      (1.0, 1.0, 0.9, 0.0),
      (1.0, 1.0, 0.4, 0.0),
      (5.0, 2.0, -1.0, -Double.infinity),
      (5.0, 2.0, 0.9, 0.6771702),
      (5.0, 2.0, 0.4, -0.7747912),
      (0.1, 5000.0, -1.0, -Double.infinity),
      (0.1, 5000.0, 0.9, -11511.929057),
      (0.1, 5000.0, 0.4, -2554.193633),
      // Boundary points: x = 0
      (0.5, 0.5, 0.0, Double.infinity),   // alpha < 1 → +∞
      (0.9, 0.9, 0.0, Double.infinity),   // alpha < 1 → +∞
      (1.0, 1.0, 0.0, 0.0),              // alpha = 1 → log(1/B(1,1)) = 0
      (2.0, 2.0, 0.0, -Double.infinity),  // alpha > 1 → -∞
      // Boundary points: x = 1
      (0.5, 0.5, 1.0, Double.infinity),   // beta < 1 → +∞
      (0.9, 0.9, 1.0, Double.infinity),   // beta < 1 → +∞
      (1.0, 1.0, 1.0, 0.0),              // beta = 1 → log(1/B(1,1)) = 0
      (2.0, 2.0, 1.0, -Double.infinity),  // beta > 1 → -∞
    ]
  )
  func validInputReturnsCorrectLogPDF(alpha: Double, beta: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = BetaDistribution(alpha: alpha, beta: beta).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = BetaDistribution(alpha: 5, beta: 2)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Double: Double]()) { result, number in
      let index = (number * 10).rounded(.down) / 10
      result[index, default: 0] += 1
    }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0.0, default: 0.0].isApproximatelyEqual(to: 0.000055, absoluteTolerance: 0.01))
    #expect(proportions[0.2, default: 0.0].isApproximatelyEqual(to: 0.009335, absoluteTolerance: 0.01))
    #expect(proportions[0.4, default: 0.0].isApproximatelyEqual(to: 0.068415, absoluteTolerance: 0.01))
    #expect(proportions[0.6, default: 0.0].isApproximatelyEqual(to: 0.186895, absoluteTolerance: 0.01))
    #expect(proportions[0.8, default: 0.0].isApproximatelyEqual(to: 0.230375, absoluteTolerance: 0.01))
  }
}
