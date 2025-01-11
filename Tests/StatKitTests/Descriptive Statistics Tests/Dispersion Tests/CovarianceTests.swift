import Testing
import StatKit

@Suite("Covariance Tests", .tags(.dispersion))
struct CovarianceTests {
  static private let validTestData: [[SIMD2<Double>]] = [
    [
      SIMD2(x: 1, y: 10),
      SIMD2(x: 2, y: 20),
      SIMD2(x: 3, y: 27),
      SIMD2(x: 4, y: 30),
      SIMD2(x: 5, y: 35),
      SIMD2(x: 6, y: 38),
      SIMD2(x: 7, y: 49),
      SIMD2(x: 8, y: 56),
      SIMD2(x: 9, y: 62),
      SIMD2(x: 10, y: 69)
    ],
    [
      SIMD2(x: 1, y: 10),
      SIMD2(x: 3, y: 9),
      SIMD2(x: 4, y: 8),
      SIMD2(x: 6, y: 7),
      SIMD2(x: 8, y: 6),
      SIMD2(x: 10, y: 5),
      SIMD2(x: 17, y: 4),
      SIMD2(x: 20, y: 3),
      SIMD2(x: 27, y: 2),
      SIMD2(x: 30, y: 1)
    ],
  ]

  static private let emptyData = [SIMD2<Double>]()

  static private let singleElementData = [
    SIMD2<Double>(x: 1, y: 1)
  ]

  @Test("Valid data returns correct covariance", arguments: [
    (Self.validTestData[0], 51.5, DataSetComposition.population),
    (Self.validTestData[1], -27.2, DataSetComposition.population),
    (Self.validTestData[0], 57.222222222, DataSetComposition.sample),
    (Self.validTestData[1], -30.222222222, DataSetComposition.sample),
  ])
  func validData(data: [SIMD2<Double>], expectedVariance: Double, composition: DataSetComposition) async {
    #expect(data.covariance(of: \.x, and: \.y, from: composition).isApproximatelyEqual(to: expectedVariance, absoluteTolerance: 1e-6))
  }

  @Test("Covariance of empty collection or single element collection is undefined", arguments: [emptyData, singleElementData], DataSetComposition.allCases)
  func emptyCollection(data: [SIMD2<Double>], composition: DataSetComposition) async {
    #expect(data.covariance(of: \.x, and: \.y, from: composition).isNaN)
  }

  @Test("Covariance is commutative", arguments: validTestData, DataSetComposition.allCases)
  func covarianceCommutative(data: [SIMD2<Double>], composition: DataSetComposition) async {
    #expect(data.covariance(of: \.x, and: \.y, from: composition) == data.covariance(of: \.y, and: \.x, from: composition))
  }

  @Test("Single variable covariance is equal to variance", arguments: validTestData, DataSetComposition.allCases)
  func singleVariableCovariance(data: [SIMD2<Double>], composition: DataSetComposition) async {
    #expect(data.covariance(of: \.x, and: \.x, from: composition) == data.variance(variable: \.x, from: composition))
    #expect(data.covariance(of: \.y, and: \.y, from: composition) == data.variance(variable: \.y, from: composition))
  }
}
