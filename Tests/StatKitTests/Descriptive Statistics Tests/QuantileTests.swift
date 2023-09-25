#if !os(watchOS)

import XCTest
import StatKit

final class QuantileTests: XCTestCase {
  func testEmptySequenceQuantile() {
    let data = [Int]()
    let calculatedQuantile = data.quantile(probability: 1, of: \.self, method: .inverseEmpiricalCDF)
    
    XCTAssertTrue(calculatedQuantile.isNaN)
  }
  
  func testMaxQuantile() {
    let data = [1, 4, 2, 6, 4, 3]
    let calculatedQuantile = data.quantile(probability: 1, of: \.self, method: .inverseEmpiricalCDF)
    let expectedQuantile = 6.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testMinQuantile() {
    let data = [1, 4, 2, 6, 4, 3]
    let calculatedQuantile = data.quantile(probability: 0, of: \.self, method: .inverseEmpiricalCDF)
    let expectedQuantile = 1.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testEvenCountInverseEmpiricalCDF() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .inverseEmpiricalCDF)
    let expectedQuantile = 5.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testOddCountInverseEmpiricalCDF() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .inverseEmpiricalCDF)
    let expectedQuantile = 5.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testEvenCountAveragedInverseEmpiricalCDF() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .averagedInverseEmpiricalCDF)
    let expectedQuantile = 5.5
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testOddCountAveragedInverseEmpiricalCDF() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .averagedInverseEmpiricalCDF)
    let expectedQuantile = 5.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testEvenCountClosestOrOddIndexed() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .closestOrOddIndexed)
    let expectedQuantile = 5.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testOddCountClosestOrOddIndexed() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .closestOrOddIndexed)
    let expectedQuantile = 4.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testEvenCountLerpInverseEmpiricalCDF() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .lerpInverseEmpiricalCDF)
    let expectedQuantile = 5.0
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
  
  func testOddCountLerpInverseEmpiricalCDF() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let calculatedQuantile = data.quantile(probability: 0.5, of: \.self, method: .lerpInverseEmpiricalCDF)
    let expectedQuantile = 4.5
    
    XCTAssertEqual(calculatedQuantile, expectedQuantile, accuracy: 1e-6)
  }
}

#endif
