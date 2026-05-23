import Testing
import StatKit

@Suite("Standard Deviation Tests", .tags(.dispersion))
struct StandardDeviationTests {
  @Test("Valid data returns correct standard deviation", arguments: [
    ((1 ... 5).map(\.realValue), 1.5811388301, DataSetComposition.sample),
    ((-5 ... 5).map(\.realValue), 3.3166247904, DataSetComposition.sample),
    ((1 ... 5).map(\.realValue), 1.4142135624, DataSetComposition.population),
    ((-5 ... 5).map(\.realValue), 3.1622776602, DataSetComposition.population),
    ([42.0, 42.0], 0.0, DataSetComposition.sample),
    ([42.0, 42.0], 0.0, DataSetComposition.population),
  ] as [([Double], Double, DataSetComposition)])
  func validData(data: [Double], expectedStdDev: Double, composition: DataSetComposition) {
    #expect(data.standardDeviation(variable: \.self, from: composition).isApproximatelyEqual(to: expectedStdDev, absoluteTolerance: 1e-6))
  }

  @Test("Standard deviation of empty collection is undefined", arguments: [[Double]()], DataSetComposition.allCases)
  func emptyCollection(data: [Double], composition: DataSetComposition) {
    #expect(data.standardDeviation(variable: \.self, from: composition).isNaN)
  }

  @Test(
    "Population standard deviation of single-element collection is 0",
    arguments: [[1.0], [-1.0], [42.0]] as [[Double]]
  )
  func singleElementPopulationStdDev(data: [Double]) {
    #expect(data.standardDeviation(variable: \.self, from: .population) == 0)
  }

  @Test(
    "Sample standard deviation of single-element collection is undefined",
    arguments: [[1.0], [-1.0], [42.0]] as [[Double]]
  )
  func singleElementSampleStdDev(data: [Double]) {
    #expect(data.standardDeviation(variable: \.self, from: .sample).isNaN)
  }

  @Test("Standard deviation of collection containing NaN is NaN", arguments: DataSetComposition.allCases)
  func collectionContainingNaN(composition: DataSetComposition) {
    let data = [1.0, Double.nan, 3.0]
    #expect(data.standardDeviation(variable: \.self, from: composition).isNaN)
  }

  @Test("Standard deviation of collection containing infinity is NaN", arguments: DataSetComposition.allCases)
  func collectionContainingInfinity(composition: DataSetComposition) {
    let data = [1.0, Double.infinity, 3.0]
    #expect(data.standardDeviation(variable: \.self, from: composition).isNaN)
  }
}
