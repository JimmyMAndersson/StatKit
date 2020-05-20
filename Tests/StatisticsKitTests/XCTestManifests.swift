import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
      testCase(SequenceDescriptiveTests.allTests),
      testCase(CollectionVariabilityTests.allTests),
    ]
}
#endif
