import Testing
import StatKit

@Suite("Summation Tests", .tags(.summation))
struct SummationTests {
  @Test(
    "Valid integer data returns correct sum",
    arguments: [
      ([1, 2, 3, 4, 5], 15),
      ([-1, -2, -3, -4, -5], -15),
      ([], 0),
    ] as [([Int], Int)]
  )
  func validIntegerData(data: [Int], expectedSum: Int) {
    #expect(data.sum(over: \.self) == expectedSum)
  }

  @Test(
    "Valid floating point data returns correct sum",
    arguments: [
      ([1, 2, 3, 4, 5], 15),
      ([-1, -2, -3, -4, -5], -15),
      ([], 0),
      ([1, 2, 3, 4, .infinity], .infinity),
    ] as [([Double], Double)]
  )
  func validIntegerData(data: [Double], expectedSum: Double) {
    #expect(data.sum(over: \.self) == expectedSum)
  }

  @Test(
    "Invalid floating point data returns NaN",
    arguments: [
      ([1, 2, 3, 4, .nan], .nan),
    ] as [([Double], Double)]
  )
  func invalidData(data: [Double], expectedSum: Double) {
    #expect(data.sum(over: \.self).isNaN)
  }
}
