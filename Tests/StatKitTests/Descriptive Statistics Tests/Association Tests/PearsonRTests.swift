import Testing
import StatKit

@Suite("Pearsons R Tests", .tags(.correlationCoefficient))
struct PearsonRTests {
  @Test("Highly correlated variables yield high correlation coefficient")
  func highlyCorrelatedVariables() async {
    let data = [
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
    ]

    #expect(data.pearsonR(of: \.x, and: \.y).isApproximatelyEqual(to: 0.99329456, absoluteTolerance: 1e-6))
  }

  @Test("Uncorrelated variables yield low correlation coefficient")
  func uncorrelatedVariables() async {
    let data = [
      SIMD2(x: 1, y: 1),
      SIMD2(x: 2, y: -2),
      SIMD2(x: 3, y: -1),
      SIMD2(x: 4, y: 1),
      SIMD2(x: 5, y: 1),
      SIMD2(x: 6, y: -2),
      SIMD2(x: 7, y: -1),
      SIMD2(x: 8, y: 1)
    ]

    #expect(data.pearsonR(of: \.x, and: \.y).isApproximatelyEqual(to: 0.04199605, absoluteTolerance: 1e-6))
  }

  @Test("Correlation of one variable to itself is one")
  func correlationToSelf() async {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    #expect(data.pearsonR(of: \.self, and: \.self) == 1)
  }

  @Test("Correlation of empty collection is undefined")
  func emptyCollection() async {
    let data = [Int8]()

    #expect(data.pearsonR(of: \.self, and: \.self).isNaN)
  }

  @Test("Correlation where one variable is constant yields zero")
  func constantValueCollection() async {
    let data = [
      SIMD2(x: 1, y: 6),
      SIMD2(x: 2, y: 6),
      SIMD2(x: 3, y: 6),
      SIMD2(x: 4, y: 6),
      SIMD2(x: 5, y: 6),
      SIMD2(x: 6, y: 6),
      SIMD2(x: 7, y: 6),
      SIMD2(x: 8, y: 6),
      SIMD2(x: 9, y: 6),
      SIMD2(x: 10, y: 6)
    ]

    #expect(data.pearsonR(of: \.x, and: \.y) == 0)
  }
}
