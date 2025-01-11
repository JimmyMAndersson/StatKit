import Testing
import StatKit

@Suite("Binomial Distribution Tests", .tags(.distribution))
struct BinomialDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0, 20, 0),
      (1, 1, 1),
      (0.5, 200, 100),
    ]
  )
  func validInputReturnsCorrectMean(probability: Double, trials: Int, expectedMean: Double) async throws {
    let mean = BinomialDistribution(probability: probability, trials: trials).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0, 20, 0),
      (1, 1, 0),
      (0.5, 200, 50),
    ]
  )
  func validInputReturnsCorrectVariance(probability: Double, trials: Int, expectedVariance: Double) async throws {
    let variance = BinomialDistribution(probability: probability, trials: trials).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0, 20, .infinity),
      (1, 1, -.infinity),
      (0.5, 200, 0),
      (0.3, 200, 0.06172133998)
    ]
  )
  func validInputReturnsCorrectSkewness(probability: Double, trials: Int, expectedSkewness: Double) async throws {
    let skewness = BinomialDistribution(probability: probability, trials: trials).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0, 20, .infinity),
      (1, 1, .infinity),
      (0.5, 20, -0.1),
      (0.7, 20, -0.0619047619),
      (0.05, 200, 0.07526315789)
    ]
  )
  func validInputReturnsCorrectSkewness(probability: Double, trials: Int, expectedKurtosis: Double) async throws {
    let kurtosis = BinomialDistribution(probability: probability, trials: trials).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PMF value",
    arguments: [
      (0, 20, 10, 0),
      (0.99, 1, 1, 0.99),
      (0.5, 20, 5, 0.0147857666015625),
    ]
  )
  func validInputReturnsCorrectSkewness(probability: Double, trials: Int, x: Int, expectedPMF: Double) async throws {
    let pmf = BinomialDistribution(probability: probability, trials: trials).pmf(x: x)
    #expect(pmf.isApproximatelyEqual(to: expectedPMF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0.5, 20, 1, 0.0000200271606),
      (0.5, 20, 0, 0.0000009536743),
      (0.5, 20, 10, 0.5880985260010),
      (0.7, 20, 10, 0.04796190),
      (0.7, 20, 7, 0.00127888),
      (0.7, 20, 15, 0.76249222),
    ]
  )
  func validInputReturnsCorrectCDF(probability: Double, trials: Int, x: Int, expectedCDF: Double) async throws {
    let cdf = BinomialDistribution(probability: probability, trials: trials).cdf(x: x, logarithmic: false)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameter return correct log CDF value",
    arguments: [
      (0.5, 20, 1, -10.8184212),
      (0.5, 20, 0, -13.8629436),
      (0.5, 20, 10, -0.5308608),
      (0.7, 20, 10, -3.037348),
      (0.7, 20, 7, -6.661771),
      (0.7, 20, 15, -0.271163),
    ]
  )
  func validInputReturnsCorrectLogCDF(probability: Double, trials: Int, x: Int, expectedLogCDF: Double) async throws {
    let cdf = BinomialDistribution(probability: probability, trials: trials).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 4000000
    let numberOfTrials = 5
    let distribution = BinomialDistribution(probability: 0.7, trials: numberOfTrials)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number), default: 0] += 1 }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    let testRange =  0 ... numberOfTrials

    for successes in testRange {
      #expect(proportions[successes, default: -1.0].isApproximatelyEqual(to: distribution.pmf(x: successes), absoluteTolerance: 1e-3))
    }
  }
}
