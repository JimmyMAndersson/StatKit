import Testing
import StatKit

@Suite("Median Tests", .tags(.averages))
struct MedianTests {
  @Test(
    "Valid data returns correct median",
    arguments: [
      ([-1, 4, 2, 20, 3, 6], 3.5, .mean),
      ([-1, 4, 2, 20, 3], 3, .mean),
      ([-1, 4, 2, 20, 3, 6], 3, .low),
      ([-1, 4, 2, 20, 3], 3, .low),
      ([-1, 4, 2, 20, 3, 6], 4, .high),
      ([-1, 4, 2, 20, 3], 3, .high),
    ] as [([Double], Double, MedianStrategy)]
  )
  func validData(data: [Double], expectedMedian: Double, strategy: MedianStrategy) async {
    #expect(data.median(variable: \.self, strategy: strategy).isApproximatelyEqual(to: expectedMedian, absoluteTolerance: 1e-6))
  }

  @Test(
    "Invalid data return NaN",
    arguments: [
      ([], .mean),
      ([], .low),
      ([], .high),
    ] as [([Double], MedianStrategy)]
  )
  func invalidData(data: [Double], strategy: MedianStrategy) async {
    #expect(data.median(variable: \.self, strategy: strategy).isNaN)
  }
}
