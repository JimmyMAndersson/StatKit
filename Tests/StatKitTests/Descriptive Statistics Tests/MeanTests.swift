import Testing
import StatKit

@Suite("Mean Tests", .tags(.averages))
struct MeanTests {
  @Test(
    "Valid input returns correct mean",
    arguments: [
      ([1, 2, 3, 4, 5], 3, .arithmetic),
      ([Int.max.realValue, Int.max.realValue / 3 * 2, Int.max.realValue / 3], Int.max.realValue / 3 * 2, .arithmetic),
      ([1], 1, .arithmetic),

      ([1, 2, 3, 4, 5], 2.6051710847, .geometric),
      ([500, 2, 5, 2, 6], 9.02880451447434, .geometric),
      ([-50, 12, 6, -25, 2], 11.247461131, .geometric),
      ([-50, 12, -6, -25, 2], -11.247461131, .geometric),
      ([0, 1, 2, 3, 4], 0, .geometric),
      ([.infinity, .infinity], .infinity, .geometric),
      ([1], 1, .geometric),

      ([1, 2, 3, 4, 5], 2.18978102, .harmonic),
      ([500, 2, 5, 2, 6], 3.65319045, .harmonic),
      ([-50, 12, 6, -25, 2], 7.24637681, .harmonic),
      ([-50, 12, -6, -25, 2], 14.018691588785, .harmonic),
      ([0, 1, 2, 3, 4], 0, .harmonic),
      ([.infinity, .infinity], .infinity, .harmonic),
      ([1], 1, .harmonic),
    ] as [([Double], Double, MeanStrategy)]
  )
  func validInput(data: [Double], expectedMean: Double, strategy: MeanStrategy) async {
    #expect(data.mean(variable: \.self, strategy: strategy).isApproximatelyEqual(to: expectedMean, absoluteTolerance: 1e-6))
  }

  @Test(
    "Invalid input returns NaN",
    arguments: [
      ([], .arithmetic),
      ([], .geometric),
      ([], .harmonic),
      ([1, 2, 3, -4], .geometric),
    ] as [([Int], MeanStrategy)]
  )
  func invalidInput(data: [Int], strategy: MeanStrategy) async {
    #expect(data.mean(variable: \.self, strategy: strategy).isNaN)
  }
}
