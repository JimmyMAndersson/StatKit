public protocol UnivariateDistribution: Distribution {
  /// The type used to describe a distributions variance.
  associatedtype VarianceType
  /// The type used to describe a distributions skewness.
  associatedtype SkewnessType
  /// The type used to describe a distributions kurtosis.
  associatedtype KurtosisType
  
  /// The distributions variance.
  var variance: VarianceType { get }
  /// The distributions skewness.
  var skewness: SkewnessType { get }
  /// The kurtosis of the distribution.
  var kurtosis: KurtosisType { get }
}
