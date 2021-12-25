#if !os(watchOS)

import XCTest
import StatKit

final class StandardCompetitionRankingTests: XCTestCase {
  func testDistinctDataSetByDescendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = rank(intArray, variable: \.self, by: >, strategy: .standardCompetition)
    let expectedRank = [5.0, 3.0, 2.0, 4.0, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByDescendingOrder() {
    let intArray = [1, 3, 4, 3, 5]
    let calculatedRank = rank(intArray, variable: \.self, by: >, strategy: .standardCompetition)
    let expectedRank = [5.0, 3.0, 2.0, 3.0, 1.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testEmptyDataSet() {
    let intArray = [Int]()
    let calculatedRank = rank(intArray, variable: \.self, by: <, strategy: .standardCompetition)
    let expectedRank = [Double]()
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testDistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 2, 5]
    let calculatedRank = rank(intArray, variable: \.self, by: <, strategy: .standardCompetition)
    let expectedRank = [1.0, 3.0, 4.0, 2.0, 5.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
  
  func testIndistinctDataSetByAscendingOrder() {
    let intArray = [1, 3, 4, 3, 5, 3, 3]
    let calculatedRank = rank(intArray, variable: \.self, by: <, strategy: .standardCompetition)
    let expectedRank = [1.0, 2.0, 6.0, 2.0, 7.0, 2.0, 2.0]
    XCTAssertEqual(calculatedRank, expectedRank)
  }
}

#endif
