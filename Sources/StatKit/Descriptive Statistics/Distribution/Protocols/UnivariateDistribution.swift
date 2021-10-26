public protocol UnivariateDistribution: Distribution {
  /// The type used to describe a distributions variance (for example reals, integers, or some vector of numerals).
  associatedtype VarianceType
  
  /// The distributions variance.
  var variance: VarianceType { get }
}

extension UnivariateDistribution where Self.KurtosisType == Double {
  /// The excess kurtosis of the distribution.
  public var excessKurtosis: KurtosisType {
    return kurtosis - 3
  }
}
