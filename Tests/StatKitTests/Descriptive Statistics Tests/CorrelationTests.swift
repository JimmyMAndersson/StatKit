import XCTest
@testable import StatKit

final class CorrelationTests: XCTestCase {
  func testPopulationPearsonCorrelation() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let calculatedCorrelation = cgPointArray.correlation(of: \.x, and: \.y, for: .population)
    let expectedCorrelation = 0.9933
    
    XCTAssertEqual(calculatedCorrelation, expectedCorrelation, accuracy: 0.00001)
  }
  
  func testSamplePearsonCorrelation() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let calculatedCorrelation = cgPointArray.correlation(of: \.x, and: \.y, for: .sample)
    let expectedCorrelation = 0.99329
    
    XCTAssertEqual(calculatedCorrelation, expectedCorrelation, accuracy: 0.00001)
  }
  
  func testPearsonCorrelationWithSingleVariable() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 20),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30),
                        CGPoint(x: 5, y: 35),
                        CGPoint(x: 6, y: 38),
                        CGPoint(x: 7, y: 49),
                        CGPoint(x: 8, y: 56),
                        CGPoint(x: 9, y: 62),
                        CGPoint(x: 10, y: 69)]
    
    let calculatedCorrelation = cgPointArray.correlation(of: \.x, and: \.x, for: .population)
    XCTAssert(calculatedCorrelation == 1)
  }
  
  func testPearsonCorrelationWithEmptyCollection() {
    let cgPointArray = [CGPoint]()
    let calculatedCorrelation = cgPointArray.correlation(of: \.x, and: \.y, for: .sample)
    
    XCTAssert(calculatedCorrelation.isNaN)
  }
}
