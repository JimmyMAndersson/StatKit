/// A protocol specifying requirements for discrete probability distributions.
public protocol DiscreteDistribution: Distribution {
  /// The Probability Mass Function of the distribution.
  /// - parameter x: The value for which to calculate the probability.
  /// - parameter logarithmic: Whether to return the natural logarithm of the function.
  /// - returns: The probability that a sample from the distribution is exactly equal to x.
  func pmf(x: DomainType, logarithmic: Bool) -> Double
}
