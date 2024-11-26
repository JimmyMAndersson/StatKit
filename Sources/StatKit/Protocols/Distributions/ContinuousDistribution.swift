public protocol ContinuousDistribution: Distribution {
  /// The Probability Density Function of the distribution.
  /// - parameter x: The value for which to calculate the relative likelihood of being sampled.
  /// - parameter logarithmic: Whether to return the natural logarithm of the function.
  /// - returns: The relative likelihood that a sample from the distribution is exactly equal to x.
  func pdf(x: DomainType, logarithmic: Bool) -> Double
}
