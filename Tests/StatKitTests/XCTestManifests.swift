import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CollectionVariabilityTests.allTests),
        testCase(SequenceDescriptiveTests.allTests)
    ]
}
#endif
