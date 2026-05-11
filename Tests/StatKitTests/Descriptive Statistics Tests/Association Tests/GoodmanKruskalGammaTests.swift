import Testing
import StatKit

private enum EducationLevel: Comparable, Hashable {
  case highSchool, bachelor, master, doctorate
}

private enum IncomeLevel: Comparable, Hashable {
  case low, middle, high
}

@Suite("Goodman-Kruskal Gamma Tests", .tags(.correlationCoefficient))
struct GoodmanKruskalGammaTests {
  @Test("Monotonically increasing data yields a gamma of 1")
  func monotonicallyIncreasingData() async {
    let data = (1 ... 5).map { SIMD2(x: $0, y: 2 * $0) }
    #expect(data.goodmanKruskalGamma(of: \.x, and: \.y) == 1)
  }

  @Test("Monotonically decreasing data yields a gamma of -1")
  func monotonicallyDecreasingData() async {
    let data: [SIMD2<Int>] = (1 ... 5).map { SIMD2(x: $0, y: -$0) }
    #expect(data.goodmanKruskalGamma(of: \.x, and: \.y) == -1)
  }

  @Test("Gamma of a variable with respect to itself is 1")
  func correlationOfVariableWithRespectToItself() async {
    let data: [Int] = [1, 2, 3, 4, 5]
    #expect(data.goodmanKruskalGamma(of: \.self, and: \.self) == 1)
  }

  @Test("Gamma of constant data is undefined")
  func constantData() async {
    let data: [SIMD2<Int>] = (1 ... 5).map { SIMD2(x: $0, y: 1) }
    #expect(data.goodmanKruskalGamma(of: \.x, and: \.y).isNaN)
  }

  @Test("Gamma on empty collection is undefined")
  func emptyCollection() async {
    let data: [Int] = [Int]()
    #expect(data.goodmanKruskalGamma(of: \.self, and: \.self).isNaN)
  }

  @Test("Gamma on collection of one is undefined")
  func collectionOfOne() async {
    let data: [Int] = [1]
    #expect(data.goodmanKruskalGamma(of: \.self, and: \.self).isNaN)
  }

  @Test("Ordinal data produces a valid gamma")
  func ordinalData() async {
    let data: [(education: EducationLevel, income: IncomeLevel)] = [
      (.highSchool, .low), (.highSchool, .low), (.highSchool, .middle),
      (.bachelor, .low), (.bachelor, .middle), (.bachelor, .middle), (.bachelor, .high),
      (.master, .middle), (.master, .high), (.master, .high),
      (.doctorate, .high), (.doctorate, .high),
    ]

    #expect(
      data.goodmanKruskalGamma(of: \.education, and: \.income)
        .isApproximatelyEqual(to: 0.8947368421, absoluteTolerance: 1e-6)
    )
  }

  @Test("Valid data produces a valid gamma")
  func validData() async {
    let data: [(income: Int, satisfaction: Int)] = [
      (1, 1), (1, 1), (1, 1), (1, 1),
      (1, 2), (1, 2), (1, 2),
      (1, 3),
      (2, 1), (2, 1),
      (2, 2), (2, 2), (2, 2), (2, 2), (2, 2),
      (2, 3), (2, 3), (2, 3),
      (3, 1),
      (3, 2), (3, 2), (3, 2),
      (3, 3), (3, 3), (3, 3), (3, 3), (3, 3), (3, 3),
    ]

    #expect(
      data.goodmanKruskalGamma(of: \.income, and: \.satisfaction)
        .isApproximatelyEqual(to: 0.5888888889, absoluteTolerance: 1e-6)
    )
  }
}
