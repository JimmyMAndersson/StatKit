import Testing
import StatKit

@Suite("Normal Distribution Tests", .tags(.distribution))
struct NormalDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0.0, 1.0, 0.0),
      (-4.0, 9.0, -4.0),
    ]
  )
  func validInputReturnsCorrectMean(mean: Double, variance: Double, expectedMean: Double) async throws {
    let result = NormalDistribution(mean: mean, variance: variance).mean
    #expect(result.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0.0, 1.0, 1.0),
      (-4.0, 9.0, 9.0),
    ]
  )
  func validInputReturnsCorrectVariance(mean: Double, variance: Double, expectedVariance: Double) async throws {
    let result = NormalDistribution(mean: mean, variance: variance).variance
    #expect(result.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0.0, 1.0, 0.0),
      (-4.0, 9.0, 0.0),
    ]
  )
  func validInputReturnsCorrectSkewness(mean: Double, variance: Double, expectedSkewness: Double) async throws {
    let skewness = NormalDistribution(mean: mean, variance: variance).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0.0, 1.0, 0.0),
      (-4.0, 9.0, 0.0),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(mean: Double, variance: Double, expectedKurtosis: Double) async throws {
    let kurtosis = NormalDistribution(mean: mean, variance: variance).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0.0, 1.0, 1.0, 0.8413447),
      (0.0, 1.0, 0.0, 0.5),
      (0.0, 1.0, 0.4, 0.6554217),
      (0.0, 1.0, -20.0, 0.0),
      (-4.0, 9.0, 10.0, 0.99999847),
      (-4.0, 9.0, -8.0, 0.09121122),
      (-4.0, 9.0, 0.0, 0.90878878),
    ]
  )
  func validInputReturnsCorrectCDF(mean: Double, variance: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = NormalDistribution(mean: mean, variance: variance).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (0.0, 1.0, 1.0, -0.1727538),
      (0.0, 1.0, 0.0, -0.6931472),
      (0.0, 1.0, 0.4, -0.4224764),
      (0.0, 1.0, -20.0, -Double.infinity),
      (-4.0, 9.0, 10.0, -0.000001530628),
      (-4.0, 9.0, -8.0, -2.394577366159),
      (-4.0, 9.0, 0.0, -0.095642576741),
    ]
  )
  func validInputReturnsCorrectLogCDF(mean: Double, variance: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = NormalDistribution(mean: mean, variance: variance).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (0.0, 1.0, 1.0, 0.2419707),
      (0.0, 1.0, 0.0, 0.3989423),
      (0.0, 1.0, 0.4, 0.3682701),
      (-4.0, 9.0, 0.0, 0.054670025),
      (-4.0, 9.0, -2.0, 0.106482669),
      (-4.0, 9.0, 4.0, 0.003798662),
    ]
  )
  func validInputReturnsCorrectPDF(mean: Double, variance: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = NormalDistribution(mean: mean, variance: variance).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (0.0, 1.0, 1.0, -1.4189385),
      (0.0, 1.0, 0.0, -0.9189385),
      (0.0, 1.0, 0.4, -0.9989385),
      (-4.0, 9.0, 0.0, -2.906440),
      (-4.0, 9.0, -2.0, -2.239773),
      (-4.0, 9.0, 4.0, -5.573106),
    ]
  )
  func validInputReturnsCorrectLogPDF(mean: Double, variance: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = NormalDistribution(mean: mean, variance: variance).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct mean",
    arguments: [
      (0.0, 1.0, 0.0),
      (-4.0, 3.0, -4.0),
    ]
  )
  func validStandardDeviationInputReturnsCorrectMean(mean: Double, standardDeviation: Double, expectedMean: Double) async throws {
    let result = NormalDistribution(mean: mean, standardDeviation: standardDeviation).mean
    #expect(result.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct variance",
    arguments: [
      (0.0, 1.0, 1.0),
      (-4.0, 3.0, 9.0),
    ]
  )
  func validStandardDeviationInputReturnsCorrectVariance(mean: Double, standardDeviation: Double, expectedVariance: Double) async throws {
    let result = NormalDistribution(mean: mean, standardDeviation: standardDeviation).variance
    #expect(result.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct skewness",
    arguments: [
      (0.0, 1.0, 0.0),
      (-4.0, 3.0, 0.0),
    ]
  )
  func validStandardDeviationInputReturnsCorrectSkewness(mean: Double, standardDeviation: Double, expectedSkewness: Double) async throws {
    let skewness = NormalDistribution(mean: mean, standardDeviation: standardDeviation).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct excess kurtosis",
    arguments: [
      (0.0, 1.0, 0.0),
      (-4.0, 3.0, 0.0),
    ]
  )
  func validStandardDeviationInputReturnsCorrectExcessKurtosis(mean: Double, standardDeviation: Double, expectedKurtosis: Double) async throws {
    let kurtosis = NormalDistribution(mean: mean, standardDeviation: standardDeviation).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct CDF value",
    arguments: [
      (0.0, 1.0, 1.0, 0.8413447),
      (0.0, 1.0, 0.0, 0.5),
      (0.0, 1.0, 0.4, 0.6554217),
      (0.0, 1.0, -20.0, 0.0),
      (-4.0, 3.0, 10.0, 0.99999847),
      (-4.0, 3.0, -8.0, 0.09121122),
      (-4.0, 3.0, 0.0, 0.90878878),
    ]
  )
  func validStandardDeviationInputReturnsCorrectCDF(mean: Double, standardDeviation: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = NormalDistribution(mean: mean, standardDeviation: standardDeviation).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct log CDF value",
    arguments: [
      (0.0, 1.0, 1.0, -0.1727538),
      (0.0, 1.0, 0.0, -0.6931472),
      (0.0, 1.0, 0.4, -0.4224764),
      (0.0, 1.0, -20.0, -Double.infinity),
      (-4.0, 3.0, 10.0, -0.000001530628),
      (-4.0, 3.0, -8.0, -2.394577366159),
      (-4.0, 3.0, 0.0, -0.095642576741),
    ]
  )
  func validStandardDeviationInputReturnsCorrectLogCDF(mean: Double, standardDeviation: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = NormalDistribution(mean: mean, standardDeviation: standardDeviation).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct PDF value",
    arguments: [
      (0.0, 1.0, 1.0, 0.2419707),
      (0.0, 1.0, 0.0, 0.3989423),
      (0.0, 1.0, 0.4, 0.3682701),
      (-4.0, 3.0, 0.0, 0.054670025),
      (-4.0, 3.0, -2.0, 0.106482669),
      (-4.0, 3.0, 4.0, 0.003798662),
    ]
  )
  func validStandardDeviationInputReturnsCorrectPDF(mean: Double, standardDeviation: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = NormalDistribution(mean: mean, standardDeviation: standardDeviation).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid standard deviation-initialised distribution parameters return correct log PDF value",
    arguments: [
      (0.0, 1.0, 1.0, -1.4189385),
      (0.0, 1.0, 0.0, -0.9189385),
      (0.0, 1.0, 0.4, -0.9989385),
      (-4.0, 3.0, 0.0, -2.906440),
      (-4.0, 3.0, -2.0, -2.239773),
      (-4.0, 3.0, 4.0, -5.573106),
    ]
  )
  func validStandardDeviationInputReturnsCorrectLogPDF(mean: Double, standardDeviation: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = NormalDistribution(mean: mean, standardDeviation: standardDeviation).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = NormalDistribution(mean: 0, variance: 1)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Double: Double]()) { result, number in
      let index = (number * 10).rounded(.down) / 10
      result[index, default: 0] += 1
    }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[-0.4, default: 0.0].isApproximatelyEqual(to: 0.03604, absoluteTolerance: 0.01))
    #expect(proportions[-0.3, default: 0.0].isApproximatelyEqual(to: 0.03751, absoluteTolerance: 0.01))
    #expect(proportions[-0.2, default: 0.0].isApproximatelyEqual(to: 0.03865, absoluteTolerance: 0.01))
    #expect(proportions[-0.1, default: 0.0].isApproximatelyEqual(to: 0.03943, absoluteTolerance: 0.01))
    #expect(proportions[0.0, default: 0.0].isApproximatelyEqual(to: 0.03982, absoluteTolerance: 0.01))
    #expect(proportions[0.1, default: 0.0].isApproximatelyEqual(to: 0.03943, absoluteTolerance: 0.01))
    #expect(proportions[0.2, default: 0.0].isApproximatelyEqual(to: 0.03865, absoluteTolerance: 0.01))
    #expect(proportions[0.3, default: 0.0].isApproximatelyEqual(to: 0.03751, absoluteTolerance: 0.01))
    #expect(proportions[0.4, default: 0.0].isApproximatelyEqual(to: 0.03604, absoluteTolerance: 0.01))
  }
}
