import Testing
import StatKit

@Suite("Arcsine Distribution Tests", .tags(.distribution))
struct ArcSineDistributionTests {
  @Test(
    "Valid distribution parameters return correct mean",
    arguments: [
      (0.0, 1.0, 0.5),
      (2.0, 6.0, 4.0),
    ]
  )
  func validInputReturnsCorrectMean(lowerBound: Double, upperBound: Double, expectedMean: Double) async throws {
    let mean = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).mean
    #expect(mean.isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct variance",
    arguments: [
      (0.0, 1.0, 0.125),
      (2.0, 6.0, 2.0),
    ]
  )
  func validInputReturnsCorrectVariance(lowerBound: Double, upperBound: Double, expectedVariance: Double) async throws {
    let variance = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).variance
    #expect(variance.isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct skewness",
    arguments: [
      (0.0, 1.0, 0.0),
      (2.0, 6.0, 0.0),
    ]
  )
  func validInputReturnsCorrectSkewness(lowerBound: Double, upperBound: Double, expectedSkewness: Double) async throws {
    let skewness = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).skewness
    #expect(skewness.isApproximatelyEqual(to: expectedSkewness, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct excess kurtosis",
    arguments: [
      (0.0, 1.0, -1.5),
      (2.0, 6.0, -1.5),
    ]
  )
  func validInputReturnsCorrectExcessKurtosis(lowerBound: Double, upperBound: Double, expectedKurtosis: Double) async throws {
    let kurtosis = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).excessKurtosis
    #expect(kurtosis.isApproximatelyEqual(to: expectedKurtosis, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct CDF value",
    arguments: [
      (0.0, 1.0, -1.0, 0.0),
      (0.0, 1.0, 0.0, 0.0),
      (0.0, 1.0, 0.25, 0.333333),
      (0.0, 1.0, 0.5, 0.5),
      (0.0, 1.0, 0.75, 0.666667),
      (0.0, 1.0, 1.0, 1.0),
      (0.0, 1.0, 2.0, 1.0),
      (2.0, 6.0, 1.0, 0.0),
      (2.0, 6.0, 2.0, 0.0),
      (2.0, 6.0, 4.0, 0.5),
      (2.0, 6.0, 5.0, 0.666667),
      (2.0, 6.0, 6.0, 1.0),
      (2.0, 6.0, 7.0, 1.0),
    ]
  )
  func validInputReturnsCorrectCDF(lowerBound: Double, upperBound: Double, x: Double, expectedCDF: Double) async throws {
    let cdf = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).cdf(x: x, logarithmic: false)
    #expect(cdf.isApproximatelyEqual(to: expectedCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct log CDF value",
    arguments: [
      (0.0, 1.0, -1.0, -Double.infinity),
      (0.0, 1.0, 0.0, -Double.infinity),
      (0.0, 1.0, 0.25, -1.098612),
      (0.0, 1.0, 0.5, -0.693147),
      (0.0, 1.0, 0.75, -0.405465),
      (0.0, 1.0, 1.0, 0.0),
      (0.0, 1.0, 2.0, 0.0),
    ]
  )
  func validInputReturnsCorrectLogCDF(lowerBound: Double, upperBound: Double, x: Double, expectedLogCDF: Double) async throws {
    let cdf = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).cdf(x: x, logarithmic: true)
    #expect(cdf.isApproximatelyEqual(to: expectedLogCDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid distribution parameters return correct PDF value",
    arguments: [
      (0.0, 1.0, -1.0, 0.0),
      (0.0, 1.0, 0.25, 0.735105),
      (0.0, 1.0, 0.5, 0.636620),
      (0.0, 1.0, 0.75, 0.735105),
      (0.0, 1.0, 2.0, 0.0),
    ]
  )
  func validInputReturnsCorrectPDF(lowerBound: Double, upperBound: Double, x: Double, expectedPDF: Double) async throws {
    let pdf = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).pdf(x: x, logarithmic: false)
    #expect(pdf.isApproximatelyEqual(to: expectedPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "PDF at distribution boundary returns infinity",
    arguments: [
      (0.0, 1.0, 0.0),
      (0.0, 1.0, 1.0),
      (2.0, 6.0, 2.0),
      (2.0, 6.0, 6.0),
    ]
  )
  func boundaryReturnsInfinitePDF(lowerBound: Double, upperBound: Double, x: Double) async throws {
    let pdf = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).pdf(x: x, logarithmic: false)
    #expect(pdf == .infinity)
  }

  @Test(
    "Valid distribution parameters return correct log PDF value",
    arguments: [
      (0.0, 1.0, -1.0, -Double.infinity),
      (0.0, 1.0, 0.25, -0.307742),
      (0.0, 1.0, 0.5, -0.451583),
      (0.0, 1.0, 0.75, -0.307742),
      (0.0, 1.0, 2.0, -Double.infinity),
    ]
  )
  func validInputReturnsCorrectLogPDF(lowerBound: Double, upperBound: Double, x: Double, expectedLogPDF: Double) async throws {
    let pdf = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).pdf(x: x, logarithmic: true)
    #expect(pdf.isApproximatelyEqual(to: expectedLogPDF, absoluteTolerance: 1e-6))
  }

  @Test(
    "Log PDF at distribution boundary returns infinity",
    arguments: [
      (0.0, 1.0, 0.0),
      (0.0, 1.0, 1.0),
      (2.0, 6.0, 2.0),
      (2.0, 6.0, 6.0),
    ]
  )
  func boundaryReturnsInfiniteLogPDF(lowerBound: Double, upperBound: Double, x: Double) async throws {
    let pdf = ArcSineDistribution(lowerBound: lowerBound, upperBound: upperBound).pdf(x: x, logarithmic: true)
    #expect(pdf == .infinity)
  }

#if swift(>=6.2)
  @Test("Infinite lower bound triggers a precondition failure")
  func infiniteLowerBoundTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ArcSineDistribution(lowerBound: .infinity, upperBound: 1)
    }
  }

  @Test("NaN lower bound triggers a precondition failure")
  func nanLowerBoundTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ArcSineDistribution(lowerBound: .nan, upperBound: 1)
    }
  }

  @Test("Infinite upper bound triggers a precondition failure")
  func infiniteUpperBoundTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ArcSineDistribution(lowerBound: 0, upperBound: .infinity)
    }
  }

  @Test("NaN upper bound triggers a precondition failure")
  func nanUpperBoundTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ArcSineDistribution(lowerBound: 0, upperBound: .nan)
    }
  }

  @Test("Lower bound greater than upper bound triggers a precondition failure")
  func lowerBoundGreaterThanUpperBoundTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ArcSineDistribution(lowerBound: 1, upperBound: 0)
    }
  }

  @Test("Equal bounds trigger a precondition failure")
  func equalBoundsTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ArcSineDistribution(lowerBound: 1, upperBound: 1)
    }
  }

  @Test("Non-positive sample count triggers a precondition failure")
  func nonPositiveSampleCountTriggersPreconditionFailure() async {
    await #expect(processExitsWith: .failure) {
      _ = ArcSineDistribution(lowerBound: 0, upperBound: 1).sample(0)
    }
  }
#endif

  @Test("Sampling from a distribution returns correct proportions")
  func testSampling() async throws {
    let numberOfSamples = 1000000
    let distribution = ArcSineDistribution(lowerBound: 0, upperBound: 1)
    let samples = distribution.sample(numberOfSamples)

    var proportions = samples.reduce(into: [Double: Double]()) { result, number in
      let index = (number * 10).rounded(.down) / 10
      result[index, default: 0] += 1
    }

    for key in proportions.keys { proportions[key]? /= Double(numberOfSamples) }

    #expect(samples.count == numberOfSamples)
    #expect(proportions[0.0, default: 0.0].isApproximatelyEqual(to: 0.20483, absoluteTolerance: 0.01))
    #expect(proportions[0.4, default: 0.0].isApproximatelyEqual(to: 0.06411, absoluteTolerance: 0.01))
    #expect(proportions[0.9, default: 0.0].isApproximatelyEqual(to: 0.20483, absoluteTolerance: 0.01))
  }
}
