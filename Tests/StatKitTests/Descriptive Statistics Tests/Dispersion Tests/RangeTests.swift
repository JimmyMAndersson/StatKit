import Testing
import StatKit

@Suite("Range Tests", .tags(.dispersion))
struct RangeTests {
  @Test("Valid data produces valid range", arguments: [
    ([1, 2, 3, 4, 5], 4.0),
    ([1.5, 22.8, 3.1, 4.0, 5.3], 21.3),
  ])
  func validData(data: [Double], expectedRange: Double) async {
    #expect(data.range(of: \.self).isApproximatelyEqual(to: expectedRange, absoluteTolerance: 1e-6))
  }

  @Test("Range for empty collection is undefined")
  func emptyCollection() async {
    let data = [Int]()

    #expect(data.range(of: \.self).isNaN)
  }

  @Test("Range for single element collection is 0")
  func singleElementCollection() async {
    let data: [Double] = [1]
    
    #expect(data.range(of: \.self) == 0)
  }
}
