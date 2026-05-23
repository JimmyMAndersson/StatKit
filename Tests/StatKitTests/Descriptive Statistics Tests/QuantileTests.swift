import Testing
import StatKit

@Suite("Quantile Tests", .tags(.quantiles))
struct QuantileTests {
  @Test(
    "Valid data returns correct quantile",
    arguments: [
      ([1, 4, 2, 6, 4, 3], 0,    .inverseEmpiricalCDF,        1),
      ([1, 4, 2, 6, 4, 3], 0.25, .inverseEmpiricalCDF,        3),
      ([1, 4, 2, 6, 4, 3], 0.5,  .inverseEmpiricalCDF,        4),
      ([1, 4, 2, 6, 4, 3], 0.75, .inverseEmpiricalCDF,        4),
      ([1, 4, 2, 6, 4, 3], 1,    .inverseEmpiricalCDF,        6),
      ([1, 4, 2, 6, 4, 3], 0,    .averagedInverseEmpiricalCDF, 1),
      ([1, 4, 2, 6, 4, 3], 0.25, .averagedInverseEmpiricalCDF, 2.5),
      ([1, 4, 2, 6, 4, 3], 0.5,  .averagedInverseEmpiricalCDF, 3.5),
      ([1, 4, 2, 6, 4, 3], 0.75, .averagedInverseEmpiricalCDF, 4),
      ([1, 4, 2, 6, 4, 3], 1,    .averagedInverseEmpiricalCDF, 6),
      ([1, 4, 2, 6, 4, 3], 0,    .closest,       1),
      ([1, 4, 2, 6, 4, 3], 0.25, .closest,       2),
      ([1, 4, 2, 6, 4, 3], 0.5,  .closest,       3),
      ([1, 4, 2, 6, 4, 3], 0.75, .closest,       4),
      ([1, 4, 2, 6, 4, 3], 1,    .closest,       6),
      ([1, 4, 2, 6, 4, 3], 0,    .lerpInverseEmpiricalCDF,    1),
      ([1, 4, 2, 6, 4, 3], 0.25, .lerpInverseEmpiricalCDF,    2.25),
      ([1, 4, 2, 6, 4, 3], 0.5,  .lerpInverseEmpiricalCDF,    3.5),
      ([1, 4, 2, 6, 4, 3], 0.75, .lerpInverseEmpiricalCDF,    4),
      ([1, 4, 2, 6, 4, 3], 1,    .lerpInverseEmpiricalCDF,    6),
      ([7, 3, 10, 1, 8, 4, 9, 2, 5, 6], 0.5, .inverseEmpiricalCDF,        6),
      ([5, 9, 2, 7, 1, 8, 3, 6, 4],     0.5, .inverseEmpiricalCDF,        5),
      ([7, 3, 10, 1, 8, 4, 9, 2, 5, 6], 0.5, .averagedInverseEmpiricalCDF, 5.5),
      ([5, 9, 2, 7, 1, 8, 3, 6, 4],     0.5, .averagedInverseEmpiricalCDF, 5),
      ([7, 3, 10, 1, 8, 4, 9, 2, 5, 6], 0.5, .closest,       5),
      ([5, 9, 2, 7, 1, 8, 3, 6, 4],     0.5, .closest,       5),
      ([7, 3, 10, 1, 8, 4, 9, 2, 5, 6], 0.5, .lerpInverseEmpiricalCDF,    5.5),
      ([5, 9, 2, 7, 1, 8, 3, 6, 4],     0.5, .lerpInverseEmpiricalCDF,    5),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.25, .inverseEmpiricalCDF,        6),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.5,  .inverseEmpiricalCDF,        11),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.75, .inverseEmpiricalCDF,        16),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.25, .averagedInverseEmpiricalCDF, 5.5),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.5,  .averagedInverseEmpiricalCDF, 10.5),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.75, .averagedInverseEmpiricalCDF, 15.5),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.25, .closest,       6),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.5,  .closest,       11),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.75, .closest,       15),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.25, .lerpInverseEmpiricalCDF,    5.75),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.5,  .lerpInverseEmpiricalCDF,    10.5),
      ([15, 3, 8, 20, 1, 12, 7, 18, 5, 10, 14, 2, 9, 16, 4, 11, 19, 6, 13, 17], 0.75, .lerpInverseEmpiricalCDF,    15.25),
      ([1, 2], 0,    .inverseEmpiricalCDF,        1),
      ([1, 2], 1,    .inverseEmpiricalCDF,        2),
      ([1, 2], 0.25, .inverseEmpiricalCDF,        2),
      ([1, 2], 0.75, .inverseEmpiricalCDF,        2),
      ([1, 2], 0,    .averagedInverseEmpiricalCDF, 1),
      ([1, 2], 1,    .averagedInverseEmpiricalCDF, 2),
      ([1, 2], 0.25, .averagedInverseEmpiricalCDF, 1.5),
      ([1, 2], 0.75, .averagedInverseEmpiricalCDF, 1.5),
      ([1, 2], 0,    .closest,       1),
      ([1, 2], 1,    .closest,       2),
      ([1, 2], 0.25, .closest,       1),
      ([1, 2], 0.75, .closest,       2),
      ([1, 2], 0,    .lerpInverseEmpiricalCDF,    1),
      ([1, 2], 1,    .lerpInverseEmpiricalCDF,    2),
      ([1, 2], 0.25, .lerpInverseEmpiricalCDF,    1.25),
      ([1, 2], 0.75, .lerpInverseEmpiricalCDF,    1.75),
      ([5], 0.5, .inverseEmpiricalCDF,        5),
      ([5], 0.5, .averagedInverseEmpiricalCDF, 5),
      ([5], 0.5, .closest,       5),
      ([5], 0.5, .lerpInverseEmpiricalCDF,    5),
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
      ([], .closest),
      ([], .lerpInverseEmpiricalCDF),
    ] as [([Int], QuantileEstimationMethod)]
  )
  func invalidData(data: [Int], method: QuantileEstimationMethod) async {
    #expect(data.quantile(probability: 1, of: \.self).isNaN)
  }

  @Test(
    "Collection with NaN values returns NaN",
    arguments: [
      ([.nan, 1.0, 2.0],       0.5,  .inverseEmpiricalCDF),
      ([1.0, .nan, 2.0],       0.5,  .inverseEmpiricalCDF),
      ([1.0, 2.0, .nan],       0.5,  .inverseEmpiricalCDF),
      ([.nan, 1.0, 2.0],       0.5,  .averagedInverseEmpiricalCDF),
      ([.nan, 1.0, 2.0],       0.5,  .closest),
      ([.nan, 1.0, 2.0],       0.5,  .lerpInverseEmpiricalCDF),
      ([.nan, 1.0, 2.0],       0.0,  .inverseEmpiricalCDF),
      ([.nan, 1.0, 2.0],       1.0,  .inverseEmpiricalCDF),
    ] as [([Double], Double, QuantileEstimationMethod)]
  )
  func nanInCollection(data: [Double], probability: Double, method: QuantileEstimationMethod) async {
    #expect(data.quantile(probability: probability, of: \.self, method: method).isNaN)
  }

  @Test(
    "Infinity values without conflicting arithmetic return the correct quantile",
    arguments: [
      ([1.0, 2.0, .infinity],   0.75, .inverseEmpiricalCDF,        Double.infinity),
      ([1.0, .infinity],        0.5,  .inverseEmpiricalCDF,                                Double.infinity),
      ([-.infinity, 1.0, 2.0],  0.0,  .inverseEmpiricalCDF,                                -.infinity),
      ([1.0, 2.0, .infinity],   1.0,  .inverseEmpiricalCDF,                                Double.infinity),
      ([1.0, .infinity],        0.75, .closest,                               Double.infinity),
      ([-.infinity, 1.0],       0.25, .closest,                               -.infinity),
      ([1.0, .infinity],        0.5,  .averagedInverseEmpiricalCDF,                        Double.infinity),
      ([-.infinity, 1.0],       0.5,  .averagedInverseEmpiricalCDF,                        -.infinity),
      ([1.0, .infinity],        0.5,  .lerpInverseEmpiricalCDF,                            Double.infinity),
    ] as [([Double], Double, QuantileEstimationMethod, Double)]
  )
  func infinityWellBehaved(data: [Double], probability: Double, method: QuantileEstimationMethod, expectedQuantile: Double) async {
    let result = data.quantile(probability: probability, of: \.self, method: method)
    #expect(result == expectedQuantile)
  }

  @Test(
    "Conflicting infinities under arithmetic return NaN",
    arguments: [
      ([-.infinity, .infinity],  0.5,  .averagedInverseEmpiricalCDF),
      ([-.infinity, 1.0],        0.5,  .lerpInverseEmpiricalCDF),
      ([-.infinity, .infinity],  0.5,  .lerpInverseEmpiricalCDF),
    ] as [([Double], Double, QuantileEstimationMethod)]
  )
  func conflictingInfinitiesReturnNaN(data: [Double], probability: Double, method: QuantileEstimationMethod) async {
    #expect(data.quantile(probability: probability, of: \.self, method: method).isNaN)
  }
}
