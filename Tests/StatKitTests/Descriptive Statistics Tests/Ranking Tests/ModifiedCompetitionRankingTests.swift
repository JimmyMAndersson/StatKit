#if !os(watchOS)

import XCTest
import StatKit

final class ModifiedCompetitionRankingTests: XCTestCase {
  func testDistinctDataSetByDescendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = intArray.rank(\.self, by: >, strategy: .modifiedCompetition)
    let expectedRank = [5.0, 3.0, 2.0, 4.0, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByDescendingOrder() {
    let fpArray = [1.0, 3.0, 4.0, 3.0, 5.0]
    let calculatedRank = fpArray.rank(\.self, by: >, strategy: .modifiedCompetition)
    let expectedRank = [5.0, 4.0, 2.0, 4.0, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testEmptyDataSet() {
    let intArray = [Int]()
    let calculatedRank = intArray.rank(\.self, by: <, strategy: .modifiedCompetition)
    let expectedRank = [Double]()
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testDistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = intArray.rank(\.self, by: <, strategy: .modifiedCompetition)
    let expectedRank = [1.0, 3.0, 4.0, 2.0, 5.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 3, 5, 3, 3]
    let calculatedRank = intArray.rank(\.self, by: <, strategy: .modifiedCompetition)
    let expectedRank = [1.0, 5.0, 6.0, 5.0, 7.0, 5.0, 5.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
}

#endif
