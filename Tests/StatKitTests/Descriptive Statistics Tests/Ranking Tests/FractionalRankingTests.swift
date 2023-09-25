#if !os(watchOS)

import XCTest
import StatKit

final class FractionalRankingTests: XCTestCase {
  func testDistinctDataSetByDescendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = intArray.rank(variable: \.self, by: >, strategy: .fractional)
    let expectedRank = [5.0, 3.0, 2.0, 4.0, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByDescendingOrder() {
    let intArray = [1, 3, 4, 3, 5]
    let calculatedRank = intArray.rank(variable: \.self, by: >, strategy: .fractional)
    let expectedRank = [5.0, 3.5, 2.0, 3.5, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testEmptyDataSet() {
    let intArray = [Int]()
    let calculatedRank = intArray.rank(variable: \.self, by: >, strategy: .fractional)
    let expectedRank = [Double]()
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testDistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = intArray.rank(variable: \.self, by: <, strategy: .fractional)
    let expectedRank = [1.0, 3.0, 4.0, 2.0, 5.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 3, 5]
    let calculatedRank = intArray.rank(variable: \.self, by: <, strategy: .fractional)
    let expectedRank = [1.0, 2.5, 4.0, 2.5, 5.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
}

#endif
