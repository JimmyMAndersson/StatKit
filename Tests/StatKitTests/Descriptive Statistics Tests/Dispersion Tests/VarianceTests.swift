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
    ] as [([Double], Double, DataSetComposition)]
  )
  func validData(data: [Double], expectedVariance: Double, composition: DataSetComposition) {
    #expect(data.variance(variable: \.self, from: composition).isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test("Variance of empty collection is undefined", arguments: [[Double]()], DataSetComposition.allCases)
  func emptyCollection(data: [Double], composition: DataSetComposition) {
    #expect(data.variance(variable: \.self, from: composition).isNaN)
  }

  @Test("Variance of single element collection is 0", arguments: [[1], [-1]] , DataSetComposition.allCases)
  func singleElementCollection(data: [Double], composition: DataSetComposition) {
    #expect(data.variance(variable: \.self, from: composition) == 0)
  }
}
