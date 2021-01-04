/// A protocol specifying requirements for discrete probability distributions.
public protocol DiscreteDistribution: Distribution {
  /// The Probability Mass Function of the distribution.
  /// - parameter x: The value for which to calculate the probability.
  /// - returns: The probability that a sample from the distribution is exactly equal to x.
  func pmf(x: Value) -> Double
}
