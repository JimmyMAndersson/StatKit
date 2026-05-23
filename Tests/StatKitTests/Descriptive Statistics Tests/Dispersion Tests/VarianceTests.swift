import Testing
import StatKit

@Suite("Variance Tests", .tags(.dispersion))
struct VarianceTests {
  @Test(
    "Valid data returns correct variance",
    arguments: [
      ((1 ... 5).map(\.realValue), 2.5, DataSetComposition.sample),
      ((-5 ... 5).map(\.realValue), 11.0, DataSetComposition.sample),
      ((1 ... 5).map(\.realValue), 2, DataSetComposition.population),
      ((-5 ... 5).map(\.realValue), 10, DataSetComposition.population),
      ([42.0, 42.0], 0.0, DataSetComposition.sample),
      ([42.0, 42.0], 0.0, DataSetComposition.population),
    ] as [([Double], Double, DataSetComposition)]
  )
  func validData(data: [Double], expectedVariance: Double, composition: DataSetComposition) {
    #expect(data.variance(variable: \.self, from: composition).isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test("Variance of empty collection is undefined", arguments: [[Double]()], DataSetComposition.allCases)
  func emptyCollection(data: [Double], composition: DataSetComposition) {
    #expect(data.variance(variable: \.self, from: composition).isNaN)
  }

  @Test(
    "Population variance of single-element collection is 0",
    arguments: [[1.0], [-1.0], [42.0]] as [[Double]]
  )
  func singleElementPopulationVariance(data: [Double]) {
    #expect(data.variance(variable: \.self, from: .population) == 0)
  }

  @Test(
    "Sample variance of single-element collection is undefined",
    arguments: [[1.0], [-1.0], [42.0]] as [[Double]]
  )
  func singleElementSampleVariance(data: [Double]) {
    #expect(data.variance(variable: \.self, from: .sample).isNaN)
  }

  @Test("Variance of collection containing NaN is NaN", arguments: DataSetComposition.allCases)
  func collectionContainingNaN(composition: DataSetComposition) {
    let data = [1.0, Double.nan, 3.0]
    #expect(data.variance(variable: \.self, from: composition).isNaN)
  }

  @Test("Variance of collection containing infinity is NaN", arguments: DataSetComposition.allCases)
  func collectionContainingInfinity(composition: DataSetComposition) {
    let data = [1.0, Double.infinity, 3.0]
    #expect(data.variance(variable: \.self, from: composition).isNaN)
  }
}
