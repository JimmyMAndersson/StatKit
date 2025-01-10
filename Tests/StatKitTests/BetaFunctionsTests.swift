import Testing
import StatKit

@Suite("Beta Function Tests", .tags(.betaFunction))
struct BetaFunctionTests {
  @Test(
    "Valid data returns correct Beta function value",
    arguments: [
      (1, 1, 1),
      (2, 1, 0.5),
      (3, 1, 0.33333333333),
      (1, 5, 0.2),
      (1, 10, 0.1),
      (10, 50, 1.591638e-12),
      (100, 100, 2.208761e-61),
      (500, 500, 1.479902e-302),
      (7000, 2, 2.040525e-08),
      (50000, 2, 3.99992e-10),
    ]
  )
  func validData(alphaParameter: Double, betaParameter: Double, expectation: Double) async {
    #expect(beta(alpha: alphaParameter, beta: betaParameter).isApproximatelyEqual(to: expectation, absoluteTolerance: 1e-6))
  }

  @Test(
    "Valid data returns correct log Beta function value",
    arguments: [
      (1, 1, 0),
      (2, 1, -0.6931472),
      (3, 1, -1.0986123),
      (1, 5, -1.609438),
      (1, 10, -2.302585),
      (10, 50, -27.16625743),
      (100, 100, -139.66526),
    ]
  )
  func validDataLogBeta(alphaParameter: Double, betaParameter: Double, expectation: Double) async {
    #expect(beta(alpha: alphaParameter, beta: betaParameter, logarithmic: true).isApproximatelyEqual(to: expectation, absoluteTolerance: 1e-6))
  }
}
