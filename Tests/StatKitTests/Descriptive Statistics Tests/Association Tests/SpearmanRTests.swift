import Testing
import StatKit

@Suite("Spearman R Tests", .tags(.correlationCoefficient))
struct SpearmanRTests {
  @Test("Monotonically increasing data yields a correlation of 1")
  func monotonicallyIncreasingData() async {
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

    #expect(data.spearmanR(of: \.x, and: \.y) == 1)
  }

  @Test("Monotonically decreasing data yields a correlation of -1")
  func monotonicallyDecreasingData() async {
    let data = [
      SIMD2(x: 1, y: -10),
      SIMD2(x: 2, y: -20),
      SIMD2(x: 3, y: -27),
      SIMD2(x: 4, y: -30),
      SIMD2(x: 5, y: -35),
      SIMD2(x: 6, y: -38),
      SIMD2(x: 7, y: -49),
      SIMD2(x: 8, y: -56),
      SIMD2(x: 9, y: -62),
      SIMD2(x: 10, y: -69)
    ]

    #expect(data.spearmanR(of: \.x, and: \.y) == -1)
  }

  @Test("Uncorrelated data yield a low correlation coefficient")
  func uncorrelatedData() async {
    let data = [
      SIMD2(x: 1, y: 5),
      SIMD2(x: 2, y: 2),
      SIMD2(x: 3, y: 6),
      SIMD2(x: 4, y: 7),
      SIMD2(x: 5, y: 8),
      SIMD2(x: 6, y: 9),
      SIMD2(x: 7, y: 10),
      SIMD2(x: 8, y: 1),
      SIMD2(x: 9, y: 7),
      SIMD2(x: 10, y: 1)
    ]

    #expect(data.spearmanR(of: \.x, and: \.y).isApproximatelyEqual(to: -0.024390697332764166, absoluteTolerance: 1e-6))
  }

  @Test("Correlation with respect to itself yields a high correlation coefficient")
  func correlationWithRespectToItself() async {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    #expect(data.spearmanR(of: \.self, and: \.self) == 1)
  }

  @Test("Correlation of empty collection is undefined")
  func emptyCollection() async {
    let data = [Double]()

    #expect(data.spearmanR(of: \.self, and: \.self).isNaN)
  }

  @Test("Correlation of collection-of-one is undefined")
  func collectionOfOne() async {
    let data = [1]

    #expect(data.spearmanR(of: \.self, and: \.self).isNaN)
  }

  @Test("Constant value data yields a low correlation coefficient")
  func constantValueData() async {
    let data = [1, 1, 1, 1, 1]

    #expect(data.spearmanR(of: \.self, and: \.self).isNaN)
  }
}
