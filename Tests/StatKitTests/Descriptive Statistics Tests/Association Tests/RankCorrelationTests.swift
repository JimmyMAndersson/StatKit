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
    
    let calculatedAssociation = simd2Array.spearmanR(of: \.x, and: \.y)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
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
    
    let calculatedAssociation = simd2Array.spearmanR(of: \.x, and: \.y)
    let expectedAssociation = -0.165144564768954
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
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
    
    let calculatedAssociation = simd2Array.spearmanR(of: \.x, and: \.y)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
  }
  
  func testPearsonCorrelationWithEmptyCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.spearmanR(of: \.x, and: \.y)

    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testPearsonCorrelationWithSingleEntryCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.spearmanR(of: \.x, and: \.y)

    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testPopulationKendallsTau() {
    let simd2Array = [SIMD2(x: 1, y: 10),
                      SIMD2(x: 2, y: 5),
                      SIMD2(x: 3, y: 27),
                      SIMD2(x: 4, y: 30)]
    
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .a)
    let expectedAssociation = 0.666666666
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
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
    
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .a)
    let expectedAssociation = -0.244444444
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
  }
  
  func testSampleKendallsTauWithTies() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 1, y: 6),
                      SIMD2(x: 1, y: 3),
                      SIMD2(x: 2, y: 2),
                      SIMD2(x: 5, y: 7)]
    
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .b)
    let expectedAssociation = 0.119522861
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
  }
  
  func testPopulationKendallsTauWithTies() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 1, y: 6),
                      SIMD2(x: 1, y: 3),
                      SIMD2(x: 2, y: 2),
                      SIMD2(x: 5, y: 7)]
    
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .a)
    let expectedAssociation = 0.1
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
  }
  
  func testSampleKendallsTauWithAllTies() {
    let simd2Array = [SIMD2(x: 1, y: 5),
                      SIMD2(x: 1, y: 6),
                      SIMD2(x: 1, y: 3),
                      SIMD2(x: 1, y: 2),
                      SIMD2(x: 1, y: 7)]
    
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .b)

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
    
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .b)
    let expectedAssociation = 1.0
    
    XCTAssertEqual(calculatedAssociation, expectedAssociation, accuracy: 1e-6)
  }
  
  func testKendallsTauWithEmptyCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .b)

    XCTAssertTrue(calculatedAssociation.isNaN)
  }
  
  func testKendallsTauBWithSingleEntryCollection() {
    let simd2Array = [SIMD2<Double>]()
    let calculatedAssociation = simd2Array.kendallTau(of: \.x, and: \.y, variant: .b)

    XCTAssertTrue(calculatedAssociation.isNaN)
  }
}

#endif
