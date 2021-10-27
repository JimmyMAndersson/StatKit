public protocol MultivariateDistribution: Distribution {
  /// The type used to describe a distributions covariance.
  associatedtype CovarianceType
  /// The type used to describe a distributions cokurtosis.
  associatedtype CokurtosisType
  /// The type used to describe a distributions coskewness.
  associatedtype CoskewnessType
  
  /// The distributions covariance.
  var covariance: CovarianceType { get }
  /// The distributions coskewness.
  var coskewness: CoskewnessType { get }
  /// The distributions cokurtosis.
  var cokurtosis: CokurtosisType { get }
}
