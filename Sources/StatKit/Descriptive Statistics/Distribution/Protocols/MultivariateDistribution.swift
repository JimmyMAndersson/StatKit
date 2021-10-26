public protocol MultivariateDistribution: Distribution {
  /// The type used to describe a distributions covariance (for example reals, integers, or some vector of numerals).
  associatedtype CovarianceType
  
  /// The distributions covariance matrix.
  var covariance: CovarianceType { get }
}
