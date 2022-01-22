/// A protocol specifying requirements for probability distributions.
public protocol Distribution {
  /// The domain of this distribution (for example reals, integers, or some vector of numerals).
  associatedtype DomainType
  /// The type used to describe a distributions mean (for example reals, integers, or some vector of numerals).
  associatedtype MeanType
  
  /// The distributions expected value.
  var mean: MeanType { get }
  
  /// Calculates the cumulative density for a value in the distribution.
  /// - parameter x: The value used to compute the cumulative density.
  /// - returns: A number in [0, 1] specifying the proportion of values that are less than or equal to x.
  func cdf(x: DomainType, logarithmic: Bool) -> Double
  
  /// Samples a single value from the distribution.
  /// - returns: A sample from the distribution.
  func sample() -> DomainType
  
  /// Samples a specified number of values from the distribution.
  /// - parameter numberOfElements: The number of samples to generate.
  /// - returns: An array of sampled values.
  func sample(_ numberOfElements: Int) -> [DomainType]
}
