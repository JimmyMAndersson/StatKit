import Testing
import StatKit

@Suite("Binomial Distribution Tests", .tags(.distribution))
struct BinomialDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0.0,  20,   0.0),
      (1.0,   1,   1.0),
      (0.5, 200, 100.0),
    ]
  )
  func validInputReturnsCorrectMean(probability: Double, trials: Int, expectedMean: Double) async throws {
    let mean = BinomialDistribution(probability: probability, trials: trials).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0.0,  20,  0.0),
      (1.0,   1,  0.0),
      (0.5, 200, 50.0),
    ]
  )
  func validInputReturnsCorrectVariance(probability: Double, trials: Int, expectedVariance: Double) async throws {
    let variance = BinomialDistribution(probability: probability, trials: trials).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0.0,  20, Double.infinity),
      (1.0,   1, -Double.infinity),
      (0.5, 200, 0.0),
      (0.3, 200, 0.06172133998),
    ]
  )
  func validInputReturnsCorrectSkewness(probability: Double, trials: Int, expectedSkewness: Double) async throws {
    let skewness = BinomialDistribution(probability: probability, trials: trials).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0.0,  20, Double.infinity),
      (1.0,   1, Double.infinity),
      (0.5,  20, -0.1),
      (0.7,  20, -0.0619047619),
      (0.05, 200, 0.07526315789),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(probability: Double, trials: Int, expectedKurtosis: Double) async throws {
    let kurtosis = BinomialDistribution(probability: probability, trials: trials).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PMF value",
    arguments: [
      (0.0,   20, 10, 0.0),
      (0.99,   1,  1, 0.99),
      (0.5,   20,  5, 0.01478576660),
      (0.5,  100, 50, 0.07958923739),
      (0.3,  100, 30, 0.08678391876),
    ]
  )
  func validInputReturnsCorrectPMF(probability: Double, trials: Int, x: Int, expectedPMF: Double) async throws {
    let pmf = BinomialDistribution(probability: probability, trials: trials).pmf(x: x)
    #expect(pmf.isApproximatelyEqual(to: expectedPMF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PMF value",
    arguments: [
      (0.99,   1,  1, -0.01005034),
      (0.5,   20,  5, -4.21409028),
      (0.5,  100, 50, -2.53087640),
      (0.3,  100, 30, -2.44433456),
    ]
  )
  func validInputReturnsCorrectLogPMF(probability: Double, trials: Int, x: Int, expectedLogPMF: Double) async throws {
    let pmf = BinomialDistribution(probability: probability, trials: trials).pmf(x: x, logarithmic: true)
    #expect(pmf.isApproximatelyEqual(to: expectedLogPMF, absoluteTolerance: 1e-5))
  }

  @Test(
    "PMF at boundary probability returns correct value",
    arguments: [
      (0.0, 10,  0,  1.0),
      (0.0, 10,  1,  0.0),
      (1.0, 10, 10,  1.0),
      (1.0, 10,  9,  0.0),
    ]
  )
  func pmfAtBoundaryProbabilityIsCorrect(probability: Double, trials: Int, x: Int, expectedPMF: Double) async throws {
    let pmf = BinomialDistribution(probability: probability, trials: trials).pmf(x: x)
    #expect(pmf.isApproximatelyEqual(to: expectedPMF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Log PMF at boundary probability returns zero",
    arguments: [
      (0.0, 10,  0),
      (1.0, 10, 10),
    ]
  )
  func logPMFAtBoundaryProbabilityIsZero(probability: Double, trials: Int, x: Int) async throws {
    let pmf = BinomialDistribution(probability: probability, trials: trials).pmf(x: x, logarithmic: true)
    #expect(pmf == 0)
  }

  @Test(
    "PMF outside valid range returns zero",
    arguments: [(0.5, 10), (0.3, 100)]
  )
  func pmfOutsideRangeIsZero(probability: Double, trials: Int) async throws {
    let distribution = BinomialDistribution(probability: probability, trials: trials)
    #expect(distribution.pmf(x: -1) == 0)
    #expect(distribution.pmf(x: trials + 1) == 0)
  }

  @Test(
    "Log PMF outside valid range returns negative infinity",
    arguments: [(0.5, 10), (0.3, 100)]
  )
  func logPMFOutsideRangeIsNegativeInfinity(probability: Double, trials: Int) async throws {
    let distribution = BinomialDistribution(probability: probability, trials: trials)
    #expect(distribution.pmf(x: -1, logarithmic: true) == -.infinity)
    #expect(distribution.pmf(x: trials + 1, logarithmic: true) == -.infinity)
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0.5, 20,  1, 0.0000200271606),
      (0.5, 20,  0, 0.0000009536743),
      (0.5, 20, 10, 0.5880985260010),
      (0.7, 20, 10, 0.04796190),
      (0.7, 20,  7, 0.00127888),
      (0.7, 20, 15, 0.76249222),
    ]
  )
  func validInputReturnsCorrectCDF(probability: Double, trials: Int, x: Int, expectedCDF: Double) async throws {
    let cdf = BinomialDistribution(probability: probability, trials: trials).cdf(x: x, logarithmic: false)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (0.5, 20,  1, -10.8184212),
      (0.5, 20,  0, -13.8629436),
      (0.5, 20, 10,  -0.5308608),
      (0.7, 20, 10,  -3.037348),
      (0.7, 20,  7,  -6.661771),
      (0.7, 20, 15,  -0.271163),
    ]
  )
  func validInputReturnsCorrectLogCDF(probability: Double, trials: Int, x: Int, expectedLogCDF: Double) async throws {
    let cdf = BinomialDistribution(probability: probability, trials: trials).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

#if swift(>=6.2)
  @Test("Negative trial count triggers a precondition failure")
  func negativeTrialsTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = BinomialDistribution(probability: 0.5, trials: -1)
    }
  }

  @Test("Out-of-range probability triggers a precondition failure")
  func outOfRangeProbabilityTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = BinomialDistribution(probability: 1.1, trials: 10)
    }
  }

  @Test("Non-positive sample count triggers a precondition failure")
  func nonPositiveSampleCountTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = BinomialDistribution(probability: 0.5, trials: 10).sample(0)
    }
  }
#endif

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1_000_000
    let numberOfTrials = 50
    let distribution = BinomialDistribution(probability: 0.7, trials: numberOfTrials)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    for successes in 0 ... numberOfTrials {
      #expect(proportions[successes, default: 0.0].isApproximatelyEqual(to: distribution.pmf(x: successes), absoluteTolerance: 1e-3))
    }
  }
}
