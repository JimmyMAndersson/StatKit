import Testing
import StatKit

@Suite("Mode Tests", .tags(.averages))
struct ModeTests {
  @Test("Valid string data returns correct mode")
  func validStringData() async {
    let data = "Protocol Oriented Programming is amazing!"
    let expectedMode = Set<Character>(["i", "o", " ", "r"])
    #expect(data.mode(variable: \.self) == expectedMode)
  }

  @Test(
    "Valid integer data returns correct mode",
    arguments: [
      ([1, 2, 3, 4, 5, 6, 4], [4]),
      ([1, 2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7]),
      ([], Set<Int>()),
    ] as [([Int], Set<Int>)]
  )
  func validIntegerData(data: [Int], expectedMode: Set<Int>) async {
    #expect(data.mode(variable: \.self) == expectedMode)
  }
}
