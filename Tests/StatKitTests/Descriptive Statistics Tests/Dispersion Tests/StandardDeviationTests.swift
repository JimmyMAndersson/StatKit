import Testing
import StatKit

@Suite("Standard Deviation Tests", .tags(.dispersion))
struct StandardDeviationTests {
  @Test("Valid data returns correct standard deviation", arguments: [
    ((1 ... 5).map(\.realValue), 1.5811388301, DataSetComposition.sample),
    ((-5 ... 5).map(\.realValue), 3.3166247904, DataSetComposition.sample),
    ((1 ... 5).map(\.realValue), 1.4142135624, DataSetComposition.population),
    ((-5 ... 5).map(\.realValue), 3.1622776602, DataSetComposition.population),
  ])
  func validData(data: [Double], expectedVariance: Double, composition: DataSetComposition) {
    #expect(data.standardDeviation(variable: \.self, from: composition).isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test("Standard deviation of empty collection is undefined", arguments: [[Double]()], DataSetComposition.allCases)
  func emptyCollection(data: [Double], composition: DataSetComposition) {
    #expect(data.standardDeviation(variable: \.self, from: composition).isNaN)
  }

  @Test("Standard deviation of single element collection is 0", arguments: [[1], [-1]] , DataSetComposition.allCases)
  func singleElementCollection(data: [Double], composition: DataSetComposition) {
    #expect(data.standardDeviation(variable: \.self, from: composition) == 0)
  }
}
