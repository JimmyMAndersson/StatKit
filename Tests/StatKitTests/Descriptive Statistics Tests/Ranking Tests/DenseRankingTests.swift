#if !os(watchOS)

import XCTest
import StatKit

final class DenseRankingTests: XCTestCase {
  func testDistinctDataSetByDescendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = intArray.rank(variable: \.self, by: >, strategy: .dense)
    let expectedRank = [5.0, 3.0, 2.0, 4.0, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByDescendingOrder() {
    let intArray = [1, 3, 4, 3, 5]
    let calculatedRank = intArray.rank(variable: \.self, by: >, strategy: .dense)
    let expectedRank = [4.0, 3.0, 2.0, 3.0, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testEmptyDataSet() {
    let intArray = [Int]()
    let calculatedRank = intArray.rank(variable: \.self, by: <, strategy: .dense)
    let expectedRank = [Double]()
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testDistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = intArray.rank(variable: \.self, by: <, strategy: .dense)
    let expectedRank = [1.0, 3.0, 4.0, 2.0, 5.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 3, 5, 3, 3]
    let calculatedRank = intArray.rank(variable: \.self, by: <, strategy: .dense)
    let expectedRank = [1.0, 2.0, 3.0, 2.0, 4.0, 2.0, 2.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
}

#endif
