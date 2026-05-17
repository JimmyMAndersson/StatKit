import Testing
import StatKit

@Suite("Log-Logistic Distribution Tests", .tags(.distribution))
struct LogLogisticDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (1.0, 2.0, 1.570796327),
      (1.0, 5.0, 1.068959332),
      (2.0, 6.0, 2.094395102),
      (5.0, 8.0, 5.130860765),
      (10.0, 8.0, 10.261721530),
      (5.0, 12.0, 5.057575800),
      (10.0, 12.0, 10.115151599),
      (50.0, 8.0, 51.308607649),
      (50.0, 12.0, 50.575757996),
    ]
  )
  func validInputReturnsCorrectMean(alpha: Double, beta: Double, expectedMean: Double) async throws {
    let mean = LogLogisticDistribution(scale: alpha, shape: beta).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Mean is undefined when beta <= 1",
    arguments: [(1.0, 1.0), (1.0, 0.5)]
  )
  func meanIsNaNWhenBetaAtMostOne(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).mean.isNaN)
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (1.0, 5.0, 0.178632346),
      (2.0, 6.0, 0.450307460),
      (5.0, 8.0, 1.442286175),
      (10.0, 8.0, 5.769144699),
      (5.0, 12.0, 0.600865811),
      (10.0, 12.0, 2.403463243),
      (50.0, 8.0, 144.228617485),
      (50.0, 12.0, 60.086581084),
    ]
  )
  func validInputReturnsCorrectVariance(alpha: Double, beta: Double, expectedVariance: Double) async throws {
    let variance = LogLogisticDistribution(scale: alpha, shape: beta).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Variance is undefined when beta <= 2",
    arguments: [(1.0, 2.0), (1.0, 1.0)]
  )
  func varianceIsNaNWhenBetaAtMostTwo(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).variance.isNaN)
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (1.0, 5.0, 2.485275550),
      (2.0, 6.0, 1.819984765),
      (5.0, 8.0, 1.224648183),
      (10.0, 8.0, 1.224648183),
      (5.0, 12.0, 0.762656575),
      (10.0, 12.0, 0.762656575),
      (50.0, 8.0, 1.224648183),
      (50.0, 12.0, 0.762656575),
    ]
  )
  func validInputReturnsCorrectSkewness(alpha: Double, beta: Double, expectedSkewness: Double) async throws {
    let skewness = LogLogisticDistribution(scale: alpha, shape: beta).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Skewness is undefined when beta <= 3",
    arguments: [(1.0, 3.0), (1.0, 2.0)]
  )
  func skewnessIsNaNWhenBetaAtMostThree(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).skewness.isNaN)
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (1.0, 5.0, 26.556191909),
      (2.0, 6.0, 11.765639515),
      (5.0, 8.0, 5.342064360),
      (10.0, 8.0, 5.342064360),
      (5.0, 12.0, 2.697561181),
      (10.0, 12.0, 2.697561181),
      (50.0, 8.0, 5.342064360),
      (50.0, 12.0, 2.697561181),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(alpha: Double, beta: Double, expectedKurtosis: Double) async throws {
    let kurtosis = LogLogisticDistribution(scale: alpha, shape: beta).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-4))
  }

  @Test(
    "Excess kurtosis is undefined when beta <= 4",
    arguments: [(1.0, 4.0), (1.0, 3.0)]
  )
  func excessKurtosisIsNaNWhenBetaAtMostFour(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).excessKurtosis.isNaN)
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (1.0, 2.0, 0.5, 0.640000000),
      (1.0, 2.0, 1.0, 0.500000000),
      (1.0, 2.0, 2.0, 0.160000000),
      (2.0, 3.0, 1.0, 0.296296296),
      (2.0, 3.0, 2.0, 0.375000000),
      (2.0, 3.0, 4.0, 0.074074074),
    ]
  )
  func validInputReturnsCorrectPDF(alpha: Double, beta: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = LogLogisticDistribution(scale: alpha, shape: beta).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (1.0, 2.0, 0.5, -0.446287103),
      (1.0, 2.0, 1.0, -0.693147181),
      (1.0, 2.0, 2.0, -1.832581464),
      (2.0, 3.0, 1.0, -1.216395324),
      (2.0, 3.0, 2.0, -0.980829253),
      (2.0, 3.0, 4.0, -2.602689685),
    ]
  )
  func validInputReturnsCorrectLogPDF(alpha: Double, beta: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = LogLogisticDistribution(scale: alpha, shape: beta).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (1.0, 2.0, 0.5, 0.200000000),
      (1.0, 2.0, 1.0, 0.500000000),
      (1.0, 2.0, 2.0, 0.800000000),
      (2.0, 3.0, 1.0, 0.111111111),
      (2.0, 3.0, 2.0, 0.500000000),
      (2.0, 3.0, 4.0, 0.888888889),
    ]
  )
  func validInputReturnsCorrectCDF(alpha: Double, beta: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = LogLogisticDistribution(scale: alpha, shape: beta).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (1.0, 2.0, 0.5, -1.609437912),
      (1.0, 2.0, 1.0, -0.693147181),
      (1.0, 2.0, 2.0, -0.223143551),
      (2.0, 3.0, 1.0, -2.197224577),
      (2.0, 3.0, 2.0, -0.693147181),
      (2.0, 3.0, 4.0, -0.117783036),
    ]
  )
  func validInputReturnsCorrectLogCDF(alpha: Double, beta: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = LogLogisticDistribution(scale: alpha, shape: beta).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "PDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func pdfAtNaNIsNaN(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).pdf(x: .nan).isNaN)
  }

  @Test(
    "Log PDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logPDFAtNaNIsNaN(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).pdf(x: .nan, logarithmic: true).isNaN)
  }

  @Test(
    "CDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func cdfAtNaNIsNaN(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).cdf(x: .nan).isNaN)
  }

  @Test(
    "Log CDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logCDFAtNaNIsNaN(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).cdf(x: .nan, logarithmic: true).isNaN)
  }

  @Test(
    "PDF at x <= 0 returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func pdfAtOrBelowZeroIsZero(alpha: Double, beta: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta)
    #expect(distribution.pdf(x: 0) == 0)
    #expect(distribution.pdf(x: -1) == 0)
    #expect(distribution.pdf(x: -.infinity) == 0)
  }

  @Test(
    "Log PDF at x <= 0 returns -infinity",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logPDFAtOrBelowZeroIsNegativeInfinity(alpha: Double, beta: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta)
    #expect(distribution.pdf(x: 0, logarithmic: true) == -.infinity)
    #expect(distribution.pdf(x: -1, logarithmic: true) == -.infinity)
    #expect(distribution.pdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "PDF at +infinity returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func pdfAtPositiveInfinityIsZero(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).pdf(x: .infinity) == 0)
  }

  @Test(
    "Log PDF at +infinity returns -infinity",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logPDFAtPositiveInfinityIsNegativeInfinity(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).pdf(x: .infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "CDF at x <= 0 returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func cdfAtOrBelowZeroIsZero(alpha: Double, beta: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta)
    #expect(distribution.cdf(x: 0) == 0)
    #expect(distribution.cdf(x: -1) == 0)
    #expect(distribution.cdf(x: -.infinity) == 0)
  }

  @Test(
    "Log CDF at x <= 0 returns -infinity",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logCDFAtOrBelowZeroIsNegativeInfinity(alpha: Double, beta: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta)
    #expect(distribution.cdf(x: 0, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: -1, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "CDF at +infinity returns 1",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func cdfAtPositiveInfinityIsOne(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).cdf(x: .infinity) == 1)
  }

  @Test(
    "Log CDF at +infinity returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logCDFAtPositiveInfinityIsZero(alpha: Double, beta: Double) async throws {
    #expect(LogLogisticDistribution(scale: alpha, shape: beta).cdf(x: .infinity, logarithmic: true) == 0)
  }

#if swift(>=6.2)
  @Test("Non-positive alpha triggers a precondition failure")
  func nonPositiveAlphaTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = LogLogisticDistribution(alpha: 0, beta: 1)
    }
  }

  @Test("Non-positive beta triggers a precondition failure")
  func nonPositiveBetaTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = LogLogisticDistribution(alpha: 1, beta: 0)
    }
  }

  @Test("Non-positive sample count triggers a precondition failure")
  func nonPositiveSampleCountTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = LogLogisticDistribution(alpha: 1, beta: 2).sample(0)
    }
  }
#endif

  @Test(
    "Non-zero location shifts the mean correctly",
    arguments: [
      (1.0, 2.0,  1.0,  2.570796327),
      (1.0, 5.0, -2.0, -0.931040668),
      (5.0, 8.0,  3.0,  8.130860765),
    ]
  )
  func locationShiftsMean(alpha: Double, beta: Double, mu: Double, expectedMean: Double) async throws {
    let mean = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct PDF value",
    arguments: [
      (1.0, 2.0, 2.0, 2.5, 0.640000000),
      (1.0, 2.0, 2.0, 3.0, 0.500000000),
      (1.0, 2.0, 2.0, 4.0, 0.160000000),
    ]
  )
  func positiveLocationReturnsCorrectPDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedPDF: Double
  ) async throws {
    let pdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct PDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, 0.296296296),
      (2.0, 3.0, -1.0, 1.0, 0.375000000),
      (2.0, 3.0, -1.0, 3.0, 0.074074074),
    ]
  )
  func negativeLocationReturnsCorrectPDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedPDF: Double
  ) async throws {
    let pdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct log PDF value",
    arguments: [
      (1.0, 2.0, 2.0, 2.5, -0.446287103),
      (1.0, 2.0, 2.0, 3.0, -0.693147181),
    ]
  )
  func positiveLocationReturnsCorrectLogPDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedLogPDF: Double
  ) async throws {
    let pdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct log PDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, -1.216395324),
      (2.0, 3.0, -1.0, 1.0, -0.980829253),
    ]
  )
  func negativeLocationReturnsCorrectLogPDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedLogPDF: Double
  ) async throws {
    let pdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct CDF value",
    arguments: [
      (1.0, 2.0, 2.0, 2.5, 0.200000000),
      (1.0, 2.0, 2.0, 3.0, 0.500000000),
      (1.0, 2.0, 2.0, 4.0, 0.800000000),
    ]
  )
  func positiveLocationReturnsCorrectCDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedCDF: Double
  ) async throws {
    let cdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct CDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, 0.111111111),
      (2.0, 3.0, -1.0, 1.0, 0.500000000),
      (2.0, 3.0, -1.0, 3.0, 0.888888889),
    ]
  )
  func negativeLocationReturnsCorrectCDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedCDF: Double
  ) async throws {
    let cdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct log CDF value",
    arguments: [
      (1.0, 2.0, 2.0, 2.5, -1.609437912),
      (1.0, 2.0, 2.0, 3.0, -0.693147181),
    ]
  )
  func positiveLocationReturnsCorrectLogCDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedLogCDF: Double
  ) async throws {
    let cdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct log CDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, -2.197224577),
      (2.0, 3.0, -1.0, 1.0, -0.693147181),
    ]
  )
  func negativeLocationReturnsCorrectLogCDF(
    alpha: Double, beta: Double, mu: Double, x: Double, expectedLogCDF: Double
  ) async throws {
    let cdf = LogLogisticDistribution(scale: alpha, shape: beta, location: mu).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "PDF at x <= location returns 0",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func pdfAtOrBelowLocationIsZero(alpha: Double, beta: Double, mu: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta, location: mu)
    #expect(distribution.pdf(x: mu) == 0)
    #expect(distribution.pdf(x: mu - 1) == 0)
    #expect(distribution.pdf(x: -.infinity) == 0)
  }

  @Test(
    "Log PDF at x <= location returns -infinity",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func logPDFAtOrBelowLocationIsNegativeInfinity(alpha: Double, beta: Double, mu: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta, location: mu)
    #expect(distribution.pdf(x: mu, logarithmic: true) == -.infinity)
    #expect(distribution.pdf(x: mu - 1, logarithmic: true) == -.infinity)
    #expect(distribution.pdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "CDF at x <= location returns 0",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func cdfAtOrBelowLocationIsZero(alpha: Double, beta: Double, mu: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta, location: mu)
    #expect(distribution.cdf(x: mu) == 0)
    #expect(distribution.cdf(x: mu - 1) == 0)
    #expect(distribution.cdf(x: -.infinity) == 0)
  }

  @Test(
    "Log CDF at x <= location returns -infinity",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func logCDFAtOrBelowLocationIsNegativeInfinity(alpha: Double, beta: Double, mu: Double) async throws {
    let distribution = LogLogisticDistribution(scale: alpha, shape: beta, location: mu)
    #expect(distribution.cdf(x: mu, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: mu - 1, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1_000_000
    let distribution = LogLogisticDistribution(alpha: 1, beta: 2)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number.rounded(.down)), default: 0] += 1 }
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0, default: 0.0].isApproximatelyEqual(to: 0.500000000, absoluteTolerance: 0.01))
    #expect(proportions[1, default: 0.0].isApproximatelyEqual(to: 0.300000000, absoluteTolerance: 0.01))
    #expect(proportions[2, default: 0.0].isApproximatelyEqual(to: 0.100000000, absoluteTolerance: 0.01))
    #expect(proportions[3, default: 0.0].isApproximatelyEqual(to: 0.041666667, absoluteTolerance: 0.01))
    #expect(proportions[4, default: 0.0].isApproximatelyEqual(to: 0.020000000, absoluteTolerance: 0.01))
  }
}
