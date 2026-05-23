import Testing
import StatKit

@Suite("Weibull Distribution Tests", .tags(.distribution))
struct WeibullDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (1.0, 1.0, 1.000000000),
      (2.0, 1.0, 2.000000000),
      (1.0, 2.0, 0.886226925),
      (2.0, 2.0, 1.772453851),
      (1.0, 0.5, 2.000000000),
      (3.0, 3.0, 2.678938535),
    ]
  )
  func validInputReturnsCorrectMean(scale: Double, shape: Double, expectedMean: Double) async throws {
    let mean = WeibullDistribution(scale: scale, shape: shape).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (1.0, 1.0,  1.000000000),
      (2.0, 1.0,  4.000000000),
      (1.0, 2.0,  0.214601837),
      (2.0, 2.0,  0.858407346),
      (1.0, 0.5, 20.000000000),
      (3.0, 3.0,  0.947995964),
    ]
  )
  func validInputReturnsCorrectVariance(scale: Double, shape: Double, expectedVariance: Double) async throws {
    let variance = WeibullDistribution(scale: scale, shape: shape).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (1.0, 1.0, 2.000000000),
      (2.0, 1.0, 2.000000000),
      (1.0, 2.0, 0.631110658),
      (1.0, 3.0, 0.168102842),
      (1.0, 0.5, 6.618761213),
    ]
  )
  func validInputReturnsCorrectSkewness(scale: Double, shape: Double, expectedSkewness: Double) async throws {
    let skewness = WeibullDistribution(scale: scale, shape: shape).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (1.0, 1.0,  6.000000000),
      (2.0, 1.0,  6.000000000),
      (1.0, 2.0,  0.245089301),
      (1.0, 3.0, -0.270536367),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(scale: Double, shape: Double, expectedKurtosis: Double) async throws {
    let kurtosis = WeibullDistribution(scale: scale, shape: shape).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-4))
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (1.0, 1.0, 1.0, 0.367879441),
      (1.0, 1.0, 2.0, 0.135335283),
      (1.0, 2.0, 1.0, 0.735758882),
      (1.0, 3.0, 1.0, 1.103638324),
      (2.0, 2.0, 2.0, 0.367879441),
      (2.0, 3.0, 2.0, 0.551819162),
      (1.0, 2.0, 0.5, 0.778800783),
      (2.0, 3.0, 1.0, 0.330936338),
    ]
  )
  func validInputReturnsCorrectPDF(scale: Double, shape: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = WeibullDistribution(scale: scale, shape: shape).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (1.0, 1.0, 1.0, -1.000000000),
      (1.0, 1.0, 2.0, -2.000000000),
      (1.0, 2.0, 1.0, -0.306852819),
      (1.0, 3.0, 1.0,  0.098612289),
      (2.0, 2.0, 2.0, -1.000000000),
      (2.0, 3.0, 2.0, -0.594534892),
      (1.0, 2.0, 0.5, -0.250000000),
      (2.0, 3.0, 1.0, -1.105829253),
    ]
  )
  func validInputReturnsCorrectLogPDF(scale: Double, shape: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = WeibullDistribution(scale: scale, shape: shape).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (1.0, 1.0, 1.0, 0.632120559),
      (1.0, 1.0, 2.0, 0.864664717),
      (1.0, 2.0, 1.0, 0.632120559),
      (1.0, 3.0, 1.0, 0.632120559),
      (2.0, 2.0, 2.0, 0.632120559),
      (2.0, 3.0, 2.0, 0.632120559),
      (1.0, 2.0, 0.5, 0.221199217),
      (2.0, 3.0, 1.0, 0.117503097),
    ]
  )
  func validInputReturnsCorrectCDF(scale: Double, shape: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = WeibullDistribution(scale: scale, shape: shape).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (1.0, 1.0, 1.0, -0.458675145),
      (1.0, 1.0, 2.0, -0.145413458),
      (1.0, 2.0, 1.0, -0.458675145),
      (1.0, 3.0, 1.0, -0.458675145),
      (2.0, 2.0, 2.0, -0.458675145),
      (2.0, 3.0, 2.0, -0.458675145),
      (1.0, 2.0, 0.5, -1.508691549),
      (2.0, 3.0, 1.0, -2.141290585),
    ]
  )
  func validInputReturnsCorrectLogCDF(scale: Double, shape: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = WeibullDistribution(scale: scale, shape: shape).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "PDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func pdfAtNaNIsNaN(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).pdf(x: .nan).isNaN)
  }

  @Test(
    "Log PDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logPDFAtNaNIsNaN(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).pdf(x: .nan, logarithmic: true).isNaN)
  }

  @Test(
    "CDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func cdfAtNaNIsNaN(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).cdf(x: .nan).isNaN)
  }

  @Test(
    "Log CDF at NaN returns NaN",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logCDFAtNaNIsNaN(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).cdf(x: .nan, logarithmic: true).isNaN)
  }

  @Test(
    "PDF at x < 0 returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func pdfBelowZeroIsZero(scale: Double, shape: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape)
    #expect(distribution.pdf(x: -1) == 0)
    #expect(distribution.pdf(x: -.infinity) == 0)
  }

  @Test(
    "Log PDF at x < 0 returns -infinity",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logPDFBelowZeroIsNegativeInfinity(scale: Double, shape: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape)
    #expect(distribution.pdf(x: -1, logarithmic: true) == -.infinity)
    #expect(distribution.pdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "PDF at x = 0 returns 0 when shape > 1",
    arguments: [(1.0, 2.0), (1.0, 3.0), (2.0, 5.0)]
  )
  func pdfAtZeroIsZeroWhenShapeAboveOne(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).pdf(x: 0) == 0)
  }

  @Test(
    "Log PDF at x = 0 returns -infinity when shape > 1",
    arguments: [(1.0, 2.0), (1.0, 3.0), (2.0, 5.0)]
  )
  func logPDFAtZeroIsNegativeInfinityWhenShapeAboveOne(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).pdf(x: 0, logarithmic: true) == -.infinity)
  }

  @Test(
    "PDF at x = 0 returns 1/scale when shape equals 1",
    arguments: [(1.0, 1.0), (2.0, 1.0), (4.0, 1.0)]
  )
  func pdfAtZeroIsInverseScaleWhenShapeEqualsOne(scale: Double, shape: Double) async throws {
    let pdf = WeibullDistribution(scale: scale, shape: shape).pdf(x: 0)
    #expect(pdf.isApproximatelyEqual(to: 1 / scale, absoluteTolerance: 1e-9))
  }

  @Test(
    "Log PDF at x = 0 returns -log(scale) when shape equals 1",
    arguments: [(1.0, 1.0), (2.0, 1.0), (4.0, 1.0)]
  )
  func logPDFAtZeroIsNegativeLogScaleWhenShapeEqualsOne(scale: Double, shape: Double) async throws {
    let logPDF = WeibullDistribution(scale: scale, shape: shape).pdf(x: 0, logarithmic: true)
    let expected = -Double.log(scale)
    if scale == 1.0 {
      #expect(logPDF == 0)
    } else {
      #expect(logPDF.isApproximatelyEqual(to: expected, absoluteTolerance: 1e-9))
    }
  }

  @Test(
    "PDF at x = 0 returns +infinity when shape < 1",
    arguments: [(1.0, 0.5), (2.0, 0.5), (1.0, 0.1)]
  )
  func pdfAtZeroIsInfiniteWhenShapeBelowOne(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).pdf(x: 0) == .infinity)
  }

  @Test(
    "PDF at +infinity returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func pdfAtPositiveInfinityIsZero(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).pdf(x: .infinity) == 0)
  }

  @Test(
    "Log PDF at +infinity returns -infinity",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logPDFAtPositiveInfinityIsNegativeInfinity(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).pdf(x: .infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "CDF at x <= 0 returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func cdfAtOrBelowZeroIsZero(scale: Double, shape: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape)
    #expect(distribution.cdf(x: 0) == 0)
    #expect(distribution.cdf(x: -1) == 0)
    #expect(distribution.cdf(x: -.infinity) == 0)
  }

  @Test(
    "Log CDF at x <= 0 returns -infinity",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logCDFAtOrBelowZeroIsNegativeInfinity(scale: Double, shape: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape)
    #expect(distribution.cdf(x: 0, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: -1, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "CDF at +infinity returns 1",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func cdfAtPositiveInfinityIsOne(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).cdf(x: .infinity) == 1)
  }

  @Test(
    "Log CDF at +infinity returns 0",
    arguments: [(1.0, 2.0), (2.0, 3.0)]
  )
  func logCDFAtPositiveInfinityIsZero(scale: Double, shape: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape).cdf(x: .infinity, logarithmic: true) == 0)
  }

#if swift(>=6.2)
  @Test("Non-positive scale triggers a precondition failure")
  func nonPositiveScaleTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = WeibullDistribution(scale: 0, shape: 1)
    }
  }

  @Test("Non-positive shape triggers a precondition failure")
  func nonPositiveShapeTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = WeibullDistribution(scale: 1, shape: 0)
    }
  }

  @Test("Non-positive sample count triggers a precondition failure")
  func nonPositiveSampleCountTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = WeibullDistribution(scale: 1, shape: 2).sample(0)
    }
  }
#endif

  @Test(
    "Non-zero location shifts the mean correctly",
    arguments: [
      (1.0, 2.0,  2.0,  2.886226925),
      (1.0, 1.0, -1.0,  0.000000000),
      (2.0, 3.0, -1.0,  0.785959024),
    ]
  )
  func locationShiftsMean(scale: Double, shape: Double, location: Double, expectedMean: Double) async throws {
    let mean = WeibullDistribution(scale: scale, shape: shape, location: location).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct PDF value",
    arguments: [
      (1.0, 2.0, 2.0, 3.0, 0.735758882),
      (1.0, 2.0, 2.0, 2.5, 0.778800783),
      (1.0, 2.0, 2.0, 4.0, 0.073262555),
    ]
  )
  func positiveLocationReturnsCorrectPDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedPDF: Double
  ) async throws {
    let pdf = WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct PDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, 0.330936338),
      (2.0, 3.0, -1.0, 1.0, 0.551819162),
    ]
  )
  func negativeLocationReturnsCorrectPDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedPDF: Double
  ) async throws {
    let pdf = WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: x)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct log PDF value",
    arguments: [
      (1.0, 2.0, 2.0, 3.0, -0.306852819),
      (1.0, 2.0, 2.0, 2.5, -0.250000000),
    ]
  )
  func positiveLocationReturnsCorrectLogPDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedLogPDF: Double
  ) async throws {
    let logPDF = WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: x, logarithmic: true)
    #expect(logPDF.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct log PDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, -1.105829253),
      (2.0, 3.0, -1.0, 1.0, -0.594534892),
    ]
  )
  func negativeLocationReturnsCorrectLogPDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedLogPDF: Double
  ) async throws {
    let logPDF = WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: x, logarithmic: true)
    #expect(logPDF.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct CDF value",
    arguments: [
      (1.0, 2.0, 2.0, 3.0, 0.632120559),
      (1.0, 2.0, 2.0, 2.5, 0.221199217),
      (1.0, 2.0, 2.0, 4.0, 0.981684361),
    ]
  )
  func positiveLocationReturnsCorrectCDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedCDF: Double
  ) async throws {
    let cdf = WeibullDistribution(scale: scale, shape: shape, location: location).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct CDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, 0.117503097),
      (2.0, 3.0, -1.0, 1.0, 0.632120559),
    ]
  )
  func negativeLocationReturnsCorrectCDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedCDF: Double
  ) async throws {
    let cdf = WeibullDistribution(scale: scale, shape: shape, location: location).cdf(x: x)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Positive location returns correct log CDF value",
    arguments: [
      (1.0, 2.0, 2.0, 3.0, -0.458675145),
      (1.0, 2.0, 2.0, 2.5, -1.508691549),
    ]
  )
  func positiveLocationReturnsCorrectLogCDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedLogCDF: Double
  ) async throws {
    let logCDF = WeibullDistribution(scale: scale, shape: shape, location: location).cdf(x: x, logarithmic: true)
    #expect(logCDF.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Negative location returns correct log CDF value",
    arguments: [
      (2.0, 3.0, -1.0, 0.0, -2.141290585),
      (2.0, 3.0, -1.0, 1.0, -0.458675145),
    ]
  )
  func negativeLocationReturnsCorrectLogCDF(
    scale: Double, shape: Double, location: Double, x: Double, expectedLogCDF: Double
  ) async throws {
    let logCDF = WeibullDistribution(scale: scale, shape: shape, location: location).cdf(x: x, logarithmic: true)
    #expect(logCDF.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "PDF at x < location returns 0",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func pdfBelowLocationIsZero(scale: Double, shape: Double, location: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape, location: location)
    #expect(distribution.pdf(x: location - 1) == 0)
    #expect(distribution.pdf(x: -.infinity) == 0)
  }

  @Test(
    "Log PDF at x < location returns -infinity",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func logPDFBelowLocationIsNegativeInfinity(scale: Double, shape: Double, location: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape, location: location)
    #expect(distribution.pdf(x: location - 1, logarithmic: true) == -.infinity)
    #expect(distribution.pdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test(
    "PDF at x = location returns 0 when shape > 1",
    arguments: [(1.0, 2.0, 3.0), (2.0, 5.0, -1.0)]
  )
  func pdfAtLocationIsZeroWhenShapeAboveOne(scale: Double, shape: Double, location: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: location) == 0)
  }

  @Test(
    "Log PDF at x = location returns -infinity when shape > 1",
    arguments: [(1.0, 2.0, 3.0), (2.0, 5.0, -1.0)]
  )
  func logPDFAtLocationIsNegativeInfinityWhenShapeAboveOne(scale: Double, shape: Double, location: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: location, logarithmic: true) == -.infinity)
  }

  @Test(
    "PDF at x = location returns 1/scale when shape equals 1",
    arguments: [(1.0, 1.0, 3.0), (2.0, 1.0, -1.0)]
  )
  func pdfAtLocationIsInverseScaleWhenShapeEqualsOne(scale: Double, shape: Double, location: Double) async throws {
    let pdf = WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: location)
    #expect(pdf.isApproximatelyEqual(to: 1 / scale, absoluteTolerance: 1e-9))
  }

  @Test(
    "PDF at x = location returns +infinity when shape < 1",
    arguments: [(1.0, 0.5, 3.0), (2.0, 0.5, -1.0)]
  )
  func pdfAtLocationIsInfiniteWhenShapeBelowOne(scale: Double, shape: Double, location: Double) async throws {
    #expect(WeibullDistribution(scale: scale, shape: shape, location: location).pdf(x: location) == .infinity)
  }

  @Test(
    "CDF at x <= location returns 0",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func cdfAtOrBelowLocationIsZero(scale: Double, shape: Double, location: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape, location: location)
    #expect(distribution.cdf(x: location) == 0)
    #expect(distribution.cdf(x: location - 1) == 0)
    #expect(distribution.cdf(x: -.infinity) == 0)
  }

  @Test(
    "Log CDF at x <= location returns -infinity",
    arguments: [(1.0, 2.0, 3.0), (2.0, 3.0, -1.0)]
  )
  func logCDFAtOrBelowLocationIsNegativeInfinity(scale: Double, shape: Double, location: Double) async throws {
    let distribution = WeibullDistribution(scale: scale, shape: shape, location: location)
    #expect(distribution.cdf(x: location, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: location - 1, logarithmic: true) == -.infinity)
    #expect(distribution.cdf(x: -.infinity, logarithmic: true) == -.infinity)
  }

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1_000_000
    let distribution = WeibullDistribution(scale: 1, shape: 1)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Int: Double]()) { result, number in result[Int(number.rounded(.down)), default: 0] += 1 }
    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0, default: 0.0].isApproximatelyEqual(to: 0.632120559, absoluteTolerance: 0.01))
    #expect(proportions[1, default: 0.0].isApproximatelyEqual(to: 0.232544158, absoluteTolerance: 0.01))
    #expect(proportions[2, default: 0.0].isApproximatelyEqual(to: 0.085548215, absoluteTolerance: 0.01))
    #expect(proportions[3, default: 0.0].isApproximatelyEqual(to: 0.031471429, absoluteTolerance: 0.01))
  }
}
