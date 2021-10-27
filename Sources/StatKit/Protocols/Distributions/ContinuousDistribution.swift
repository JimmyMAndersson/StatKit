public protocol ContinuousDistribution: Distribution {
  /// The Probability Density Function of the distribution.
  /// - parameter x: The value for which to calculate the relative likelihood of being sampled.
  /// - returns: The relative likelihood that a sample from the distribution is exactly equal to x.
  func pdf(x: DomainType) -> Double
}
