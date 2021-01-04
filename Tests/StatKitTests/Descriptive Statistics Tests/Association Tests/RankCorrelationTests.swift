#if !os(watchOS)

import XCTest
@testable import StatKit

final class RankCorrelationTests: XCTestCase {
  func testPopulationSpearmanAssociation() {
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
    
    let calculatedAssociation = cgPointArray.correlation(.spearmansRho,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .population)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
  }
  
  func testSampleSpearmanAssociation() {
    let cgPointArray = [CGPoint(x: 1, y: 5),
                        CGPoint(x: 2, y: 2),
                        CGPoint(x: 3, y: 6),
                        CGPoint(x: 4, y: 2),
                        CGPoint(x: 5, y: 7),
                        CGPoint(x: 6, y: 45),
                        CGPoint(x: 7, y: 3),
                        CGPoint(x: 8, y: 1),
                        CGPoint(x: 9, y: 7),
                        CGPoint(x: 10, y: 1)]
    
    let calculatedAssociation = cgPointArray.correlation(.spearmansRho,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    let expectedAssociation = -0.16514
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
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
    
    let calculatedAssociation = cgPointArray.correlation(.spearmansRho,
                                                         of: \.x,
                                                         and: \.x,
                                                         for: .population)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
  }
  
  func testPearsonCorrelationWithEmptyCollection() {
    let cgPointArray = [CGPoint]()
    let calculatedAssociation = cgPointArray.correlation(.spearmansRho,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testPearsonCorrelationWithSingleEntryCollection() {
    let cgPointArray = [CGPoint]()
    let calculatedAssociation = cgPointArray.correlation(.spearmansRho,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testPopulationKendallsTau() {
    let cgPointArray = [CGPoint(x: 1, y: 10),
                        CGPoint(x: 2, y: 5),
                        CGPoint(x: 3, y: 27),
                        CGPoint(x: 4, y: 30)]
    
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .population)
    let expectedAssociation = 0.66666
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
  }
  
  func testSampleKendallsTau() {
    let cgPointArray = [CGPoint(x: 1, y: 5),
                        CGPoint(x: 2, y: 2),
                        CGPoint(x: 3, y: 6),
                        CGPoint(x: 4, y: 3),
                        CGPoint(x: 5, y: 7),
                        CGPoint(x: 6, y: 45),
                        CGPoint(x: 7, y: 8),
                        CGPoint(x: 8, y: 1),
                        CGPoint(x: 9, y: -2),
                        CGPoint(x: 10, y: -6)]
    
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    let expectedAssociation = -0.24444
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
  }
  
  func testSampleKendallsTauWithTies() {
    let cgPointArray = [CGPoint(x: 1, y: 5),
                        CGPoint(x: 1, y: 6),
                        CGPoint(x: 1, y: 3),
                        CGPoint(x: 2, y: 2),
                        CGPoint(x: 5, y: 7)]
    
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    let expectedAssociation = 0.11952
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
  }
  
  func testPopulationKendallsTauWithTies() {
    let cgPointArray = [CGPoint(x: 1, y: 5),
                        CGPoint(x: 1, y: 6),
                        CGPoint(x: 1, y: 3),
                        CGPoint(x: 2, y: 2),
                        CGPoint(x: 5, y: 7)]
    
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .population)
    let expectedAssociation = 0.1
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
  }
  
  func testSampleKendallsTauWithAllTies() {
    let cgPointArray = [CGPoint(x: 1, y: 5),
                        CGPoint(x: 1, y: 6),
                        CGPoint(x: 1, y: 3),
                        CGPoint(x: 1, y: 2),
                        CGPoint(x: 1, y: 7)]
    
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testKendallsTauWithSingleVariable() {
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
    
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.x,
                                                         for: .sample)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 0.00001)
  }
  
  func testKendallsTauWithEmptyCollection() {
    let cgPointArray = [CGPoint]()
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testKendallsTauBWithSingleEntryCollection() {
    let cgPointArray = [CGPoint]()
    let calculatedAssociation = cgPointArray.correlation(.kendallsTau,
                                                         of: \.x,
                                                         and: \.y,
                                                         for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
}

#endif
