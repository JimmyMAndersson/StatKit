import Testing
import StatKit

@Suite("Quantile Tests", .tags(.quantiles))
struct QuantileTests {
  @Test(
    "Valid data returns correct quantile",
    arguments: [
      ([1, 4, 2, 6, 4, 3], 1, .inverseEmpiricalCDF, 6),
      ([1, 4, 2, 6, 4, 3], 0, .inverseEmpiricalCDF, 1),
      ([1, 4, 2, 6, 4, 3], 1, .averagedInverseEmpiricalCDF, 6),
      ([1, 4, 2, 6, 4, 3], 0, .averagedInverseEmpiricalCDF, 1),
      ([1, 4, 2, 6, 4, 3], 1, .closestOrOddIndexed, 6),
      ([1, 4, 2, 6, 4, 3], 0, .closestOrOddIndexed, 1),
      ([1, 4, 2, 6, 4, 3], 1, .lerpInverseEmpiricalCDF, 6),
      ([1, 4, 2, 6, 4, 3], 0, .lerpInverseEmpiricalCDF, 1),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 0.5, .inverseEmpiricalCDF, 5),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9], 0.5, .inverseEmpiricalCDF, 5),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 0.5, .averagedInverseEmpiricalCDF, 5.5),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9], 0.5, .averagedInverseEmpiricalCDF, 5),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 0.5, .closestOrOddIndexed, 5),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9], 0.5, .closestOrOddIndexed, 4),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 0.5, .lerpInverseEmpiricalCDF, 5),
      ([1, 2, 3, 4, 5, 6, 7, 8, 9], 0.5, .lerpInverseEmpiricalCDF, 4.5),
    ] as [([Int], Double, QuantileEstimationMethod, Double)]
  )
  func validData(data: [Int], probability: Double, method: QuantileEstimationMethod, expectedQuantile: Double) async {
    #expect(data.quantile(probability: probability, of: \.self, method: method).isApproximatelyEqual(to: expectedQuantile, absoluteTolerance: 1e-6))
  }

  @Test(
    "Invalid data returns NaN",
    arguments: [
      ([], .inverseEmpiricalCDF),
      ([], .averagedInverseEmpiricalCDF),
      ([], .closestOrOddIndexed),
      ([], .lerpInverseEmpiricalCDF),
    ] as [([Int], QuantileEstimationMethod)]
  )
  func invalidData(data: [Int], method: QuantileEstimationMethod) async {
    #expect(data.quantile(probability: 1, of: \.self).isNaN)
  }
}
