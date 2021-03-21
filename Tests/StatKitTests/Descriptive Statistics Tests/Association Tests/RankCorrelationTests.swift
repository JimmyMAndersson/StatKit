#if !os(watchOS)

import XCTest
import StatKit

final class RankCorrelationTests: XCTestCase {
  func testPopulationSpearmanAssociation() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let calculatedAssociation = simd2Array.correlation(.spearmansRho,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .population)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testSampleSpearmanAssociation() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 2, y: 2),
                      SIMD2(x: 3, y: 6),
                      SIMD2(x: 4, y: 2),
                      SIMD2(x: 5, y: 7),
                      SIMD2(x: 6, y: 45),
                      SIMD2(x: 7, y: 3),
                      SIMD2(x: 8, y: 1),
                      SIMD2(x: 9, y: 7),
                      SIMD2(x: 10, y: 1)]
    
    let calculatedAssociation = simd2Array.correlation(.spearmansRho,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    let expectedAssociation = -0.16514
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testPearsonCorrelationWithSingleVariable() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let calculatedAssociation = simd2Array.correlation(.spearmansRho,
                                                       of: \.x,
                                                       and: \.x,
                                                       for: .population)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testPearsonCorrelationWithEmptyCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.correlation(.spearmansRho,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testPearsonCorrelationWithSingleEntryCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.correlation(.spearmansRho,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testPopulationKendallsTau() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 5),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30)]
    
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .population)
    let expectedAssociation = 0.66666
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testSampleKendallsTau() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 2, y: 2),
                      SIMD2(x: 3, y: 6),
                      SIMD2(x: 4, y: 3),
                      SIMD2(x: 5, y: 7),
                      SIMD2(x: 6, y: 45),
                      SIMD2(x: 7, y: 8),
                      SIMD2(x: 8, y: 1),
                      SIMD2(x: 9, y: -2),
                      SIMD2(x: 10, y: -6)]
    
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    let expectedAssociation = -0.24444
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testSampleKendallsTauWithTies() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 1, y: 6),
                      SIMD2(x: 1, y: 3),
                      SIMD2(x: 2, y: 2),
                      SIMD2(x: 5, y: 7)]
    
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    let expectedAssociation = 0.11952
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testPopulationKendallsTauWithTies() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 1, y: 6),
                      SIMD2(x: 1, y: 3),
                      SIMD2(x: 2, y: 2),
                      SIMD2(x: 5, y: 7)]
    
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .population)
    let expectedAssociation = 0.1
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testSampleKendallsTauWithAllTies() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 1, y: 6),
                      SIMD2(x: 1, y: 3),
                      SIMD2(x: 1, y: 2),
                      SIMD2(x: 1, y: 7)]
    
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testKendallsTauWithSingleVariable() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 20),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30),
                      SIMD2(x: 5, y: 35),
                      SIMD2(x: 6, y: 38),
                      SIMD2(x: 7, y: 49),
                      SIMD2(x: 8, y: 56),
                      SIMD2(x: 9, y: 62),
                      SIMD2(x: 10, y: 69)]
    
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.x,
                                                       for: .sample)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-5)
  }
  
  func testKendallsTauWithEmptyCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testKendallsTauBWithSingleEntryCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.correlation(.kendallsTau,
                                                       of: \.x,
                                                       and: \.y,
                                                       for: .sample)
    
    XCTAssertTrue(calculatedAssociation.isNaN)
  }
}

#endif
