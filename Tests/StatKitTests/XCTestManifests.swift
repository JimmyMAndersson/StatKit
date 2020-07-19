#if !canImport(ObjectiveC)
import XCTest

extension AveragesTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__AveragesTests = [
        ("testDoubleSetMode", testDoubleSetMode),
        ("testEmptySetArithmeticMean", testEmptySetArithmeticMean),
        ("testEmptySetGeometricMean", testEmptySetGeometricMean),
        ("testEmptySetMedian", testEmptySetMedian),
        ("testEmptyStringMode", testEmptyStringMode),
        ("testFloatingPointArithmeticMean", testFloatingPointArithmeticMean),
        ("testFloatingPointGeometricMean", testFloatingPointGeometricMean),
        ("testFloatingPointMedian", testFloatingPointMedian),
        ("testIntArrayMode", testIntArrayMode),
        ("testIntegerArithmeticMean", testIntegerArithmeticMean),
        ("testIntegerGeometricMean", testIntegerGeometricMean),
        ("testIntMedian", testIntMedian),
        ("testObjectArithmeticMean", testObjectArithmeticMean),
        ("testObjectGeometricMean", testObjectGeometricMean),
        ("testStringMode", testStringMode),
    ]
}

extension CovarianceTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CovarianceTests = [
        ("testCGPointNegativePopulationCovariance", testCGPointNegativePopulationCovariance),
        ("testCGPointNegativeSampleCovariance", testCGPointNegativeSampleCovariance),
        ("testCGPointPopulationCovariancePerformance", testCGPointPopulationCovariancePerformance),
        ("testCGPointPositivePopulationCovariance", testCGPointPositivePopulationCovariance),
        ("testCGPointPositiveSampleCovariance", testCGPointPositiveSampleCovariance),
        ("testCGPointSampleCovariancePerformance", testCGPointSampleCovariancePerformance),
        ("testPopulationCovarianceCommutativity", testPopulationCovarianceCommutativity),
        ("testPopulationCovarianceWithSingleVariable", testPopulationCovarianceWithSingleVariable),
        ("testSampleCovariancecommutativity", testSampleCovariancecommutativity),
        ("testSampleCovarianceWithSingleVariable", testSampleCovarianceWithSingleVariable),
    ]
}

extension FractionalRankingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FractionalRankingTests = [
        ("testDistinctDataSetByAscendingOrder", testDistinctDataSetByAscendingOrder),
        ("testDistinctDataSetByDescendingOrder", testDistinctDataSetByDescendingOrder),
        ("testEmptyDataSet", testEmptyDataSet),
        ("testIndistinctDataSetByAscendingOrder", testIndistinctDataSetByAscendingOrder),
        ("testIndistinctDataSetByDescendingOrder", testIndistinctDataSetByDescendingOrder),
    ]
}

extension LinearCorrelationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__LinearCorrelationTests = [
        ("testPearsonConstantValueArray", testPearsonConstantValueArray),
        ("testPearsonCorrelationWithEmptyCollection", testPearsonCorrelationWithEmptyCollection),
        ("testPearsonCorrelationWithSingleVariable", testPearsonCorrelationWithSingleVariable),
        ("testPopulationPearsonCorrelation", testPopulationPearsonCorrelation),
        ("testSamplePearsonCorrelation", testSamplePearsonCorrelation),
    ]
}

extension RankCorrelationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RankCorrelationTests = [
        ("testPearsonCorrelationWithEmptyCollection", testPearsonCorrelationWithEmptyCollection),
        ("testPearsonCorrelationWithSingleVariable", testPearsonCorrelationWithSingleVariable),
        ("testPopulationSpearmanAssociation", testPopulationSpearmanAssociation),
        ("testSampleSpearmanAssociation", testSampleSpearmanAssociation),
    ]
}

extension SummationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SummationTests = [
        ("testNegativeSum", testNegativeSum),
        ("testPositiveSum", testPositiveSum),
    ]
}

extension VariabilityTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__VariabilityTests = [
        ("testFloatingPointPopulationStandardDeviation", testFloatingPointPopulationStandardDeviation),
        ("testFloatingPointPopulationVariance", testFloatingPointPopulationVariance),
        ("testFloatingPointSampleStandardDeviation", testFloatingPointSampleStandardDeviation),
        ("testFloatingPointSampleVariance", testFloatingPointSampleVariance),
        ("testIntegerPopulationStandardDeviation", testIntegerPopulationStandardDeviation),
        ("testIntegerPopulationVariance", testIntegerPopulationVariance),
        ("testIntegerSampleStandardDeviation", testIntegerSampleStandardDeviation),
        ("testIntegerSampleVariance", testIntegerSampleVariance),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AveragesTests.__allTests__AveragesTests),
        testCase(CovarianceTests.__allTests__CovarianceTests),
        testCase(FractionalRankingTests.__allTests__FractionalRankingTests),
        testCase(LinearCorrelationTests.__allTests__LinearCorrelationTests),
        testCase(RankCorrelationTests.__allTests__RankCorrelationTests),
        testCase(SummationTests.__allTests__SummationTests),
        testCase(VariabilityTests.__allTests__VariabilityTests),
    ]
}
#endif
