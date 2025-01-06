import Testing
import StatKit

@Suite("Kendall Tau Tests", .tags(.kendallTau, .correlationCoefficient))
struct KendallTauTests {
  @Test("Monotonically increasing data yields a correlation of 1", arguments: KendallTauVariant.allCases)
  func monotonicallyIncreasingData(variant: KendallTauVariant) {
    let data = (1 ... 5).map({ data in SIMD2(x: data, y: 2 * data) })

    #expect(data.kendallTau(of: \.x, and: \.y, variant: variant) == 1)
  }

  @Test("Monotonically decreasing data yields a correlation of -1", arguments: KendallTauVariant.allCases)
  func monotonicallyDecreasingData(variant: KendallTauVariant) {
    let data = (1 ... 5).map({ data in SIMD2(x: data, y: -data) })

    #expect(data.kendallTau(of: \.x, and: \.y, variant: variant) == -1)
  }

  @Test("Correlation of a variable with respect to itself is 1", arguments: KendallTauVariant.allCases)
  func correlationOfVariableWithRespectToItself(variant: KendallTauVariant) {
    let data = [1, 2, 3, 4, 5]
    #expect(data.kendallTau(of: \.self, and: \.self, variant: variant) == 1)
  }


  @Test("Tau-a correlation of constant data is defined")
  func tauAWithConstantData() {
    let data = [
      SIMD2(x: 1, y: 1),
      SIMD2(x: 2, y: 1),
      SIMD2(x: 3, y: 1),
      SIMD2(x: 4, y: 1),
      SIMD2(x: 5, y: 1),
    ]

    #expect(data.kendallTau(of: \.x, and: \.y, variant: .a) == 0)
  }

  @Test("Tau-b correlation of constant data is undefined")
  func tauBWithConstantData() {
    let data = [
      SIMD2(x: 1, y: 1),
      SIMD2(x: 2, y: 1),
      SIMD2(x: 3, y: 1),
      SIMD2(x: 4, y: 1),
      SIMD2(x: 5, y: 1),
    ]

    #expect(data.kendallTau(of: \.x, and: \.y, variant: .b).isNaN)
  }

  @Test("Valid data produces a valid correlation", arguments: KendallTauVariant.allCases)
  func validData(variant: KendallTauVariant) {
    let firstData = [
      SIMD2(x: 1, y: 5),
      SIMD2(x: 2, y: 1),
      SIMD2(x: 3, y: 2),
      SIMD2(x: 4, y: 4),
      SIMD2(x: 5, y: 3),
    ]

    #expect(firstData.kendallTau(of: \.x, and: \.y, variant: variant).isApproximatelyEqual(to: 0, absoluteTolerance: 1e-6))

    let secondData = [
      SIMD2(x: 1, y: 5),
      SIMD2(x: 2, y: 2),
      SIMD2(x: 3, y: 6),
      SIMD2(x: 4, y: 3),
      SIMD2(x: 5, y: 7),
      SIMD2(x: 6, y: 45),
      SIMD2(x: 7, y: 8),
      SIMD2(x: 8, y: 1),
      SIMD2(x: 9, y: -2),
      SIMD2(x: 10, y: -6)
    ]

    #expect(secondData.kendallTau(of: \.x, and: \.y, variant: variant).isApproximatelyEqual(to: -0.244444444, absoluteTolerance: 1e-6))
  }

  @Test("Tau-a correlation with ties")
  func tauAWithTies() {
    let data = [
      SIMD2(x: 1, y: 5),
      SIMD2(x: 2, y: 1),
      SIMD2(x: 3, y: 5),
      SIMD2(x: 4, y: 0),
      SIMD2(x: 5, y: 5),
    ]

    #expect(data.kendallTau(of: \.x, and: \.y, variant: .a).isApproximatelyEqual(to: -0.1, absoluteTolerance: 1e-6))
  }

  @Test("Tau-b correlation with ties")
  func tauBWithTies() {
    let data = [
      SIMD2(x: 1, y: 5),
      SIMD2(x: 2, y: 1),
      SIMD2(x: 3, y: 5),
      SIMD2(x: 4, y: 0),
      SIMD2(x: 5, y: 5),
    ]

    #expect(data.kendallTau(of: \.x, and: \.y, variant: .b).isApproximatelyEqual(to: -0.11952286093343936, absoluteTolerance: 1e-6))
  }

  @Test("Tau-a correlation with only ties")
  func tauAWithOnlyTies() {
    let data = [
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
    ]

    #expect(data.kendallTau(of: \.x, and: \.y, variant: .a) == 0)
  }

  @Test("Tau-b correlation with only ties")
  func tauBWithOnlyTies() {
    let data = [
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
      SIMD2(x: 1, y: 1),
    ]

    #expect(data.kendallTau(of: \.x, and: \.y, variant: .b).isNaN)
  }

  @Test("Correlation on empty collection is undefined", arguments: KendallTauVariant.allCases)
  func emptyCollection(variant: KendallTauVariant) {
    let data = [Int]()
    #expect(data.kendallTau(of: \.self, and: \.self, variant: variant).isNaN)
  }

  @Test("Correlation on collection of one is undefined", arguments: KendallTauVariant.allCases)
  func collectionOfOne(variant: KendallTauVariant) {
    let data = [1]
    #expect(data.kendallTau(of: \.self, and: \.self, variant: variant).isNaN)
  }
}
