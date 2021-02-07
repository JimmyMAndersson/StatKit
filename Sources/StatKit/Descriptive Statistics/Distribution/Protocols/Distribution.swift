/// A protocol specifying requirements for probability distributions.
public protocol Distribution {
  /// The type of value that the distribution deals with (for example, reals or integers).
  associatedtype Value
  
  /// The distributions expected value.
  var mean: Double { get }
  /// The distributions variance.
  var variance: Double { get }
  /// The distributions skewness.
  var skewness: Double { get }
  /// The kurtosis of the distribution.
  var kurtosis: Double { get }
  
  /// Calculates the cumulative density for a value in the distribution.
  /// - parameter x: The value used to compute the cumulative density.
  /// - returns: A number in [0, 1] specifying the proportion of values that are less than or equal to x.
  func cdf(x: Value) -> Double
  
  /// Samples a single value from the distribution.
  /// - returns: A sample from the distribution.
  func sample() -> Value
  
  /// Samples a specified number of values from the distribution.
  /// - parameter numberOfElements: The number of samples to generate.
  /// - returns: An array of sampled values.
  func sample(_ numberOfElements: Int) -> [Value]
}

public extension Distribution {
  /// The excess kurtosis of the distribution.
  var excessKurtosis: Double {
    return kurtosis - 3
  }
}
