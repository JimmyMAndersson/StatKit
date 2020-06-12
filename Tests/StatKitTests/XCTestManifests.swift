import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(AveragesTests.allTests),
    testCase(VariabilityTests.allTests),
    testCase(SummationTests.allTests),
    testCase(CorrelationTests.allTests)
  ]
}
#endif
