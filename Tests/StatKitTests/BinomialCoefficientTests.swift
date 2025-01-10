import Testing
import StatKit

@Suite("Binomial Coefficient Tests", .tags(.binomialCoefficient))
struct BinomialCoefficientTests {
  @Test(
    "Valid data returns correct binomial coefficient",
    arguments: [
      (5, 0, 1),
      (5, 1, 5),
      (5, 2, 10),
      (5, 3, 10),
      (5, 4, 5),
      (5, 5, 1),
      (0, 5, 0),
      (1, 10, 0),
      (10, 1, 10),
      (-5, -1, 0),
      (-5, -2, 0),
      (-5, -3, 0),
      (-5, -4, 0),
      (-5, -5, 1),
      (-3, -6, -10),
      (-1, 0, 1),
      (-128, -130, 8256),
    ]
  )
  func validData(_ n: Int, _ k: Int, _ expected: Int) async {
    #expect(choose(n: n, k: k) == expected)
  }
}
