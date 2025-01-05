/// A type modelling a Chi-Squared Distribution.
public struct ChiSquaredDistribution: ContinuousDistribution, UnivariateDistribution {
  /// A Gamma distribution helper for sampling purposes.
  /// Since The Chi-Squared Distribution is a special case of the Gamma Distribution,
  /// we can use the already implemented sampling from that type.
  private let gamma: GammaDistribution

  /// The distributions degrees of freedom parameter.
  public let degreesOfFreedom: Int

  /// Creates a Chi-Squared Distribution with a specified degrees of freedom.
  /// - parameter degreesOfFreedom: The distributions degrees of freedom parameter.
  public init(degreesOfFreedom: Int) {
    precondition(0 <= degreesOfFreedom, "The degreesOfFreedom parameter needs to be greater than 0.")

    self.degreesOfFreedom = degreesOfFreedom
    self.gamma = GammaDistribution(shape: degreesOfFreedom.realValue / 2, scale: 2)
  }

  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    guard 0 <= x else {
      return logarithmic ? -.infinity : .zero
    }

    let epsilon = x == 0 ? 0.ulp : 0
    let numerator = (self.degreesOfFreedom.realValue / 2 - 1) * .log(x + epsilon) - x / 2
    let denominator = (self.degreesOfFreedom.realValue / 2) * .log(2) + .logGamma(self.degreesOfFreedom.realValue / 2)
    let logValue = numerator - denominator

    return logarithmic ? logValue : .exp(logValue)
  }

  public var mean: Double {
    return self.degreesOfFreedom.realValue
  }

  public var variance: Double {
    return 2 * self.degreesOfFreedom.realValue
  }

  public var skewness: Double {
    return (8 / self.degreesOfFreedom.realValue).squareRoot()
  }

  public var kurtosis: Double {
    return 3 + (12 / self.degreesOfFreedom.realValue)
  }

  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    return regularizedIncompleteGamma(
      lower: 0,
      upper: x / 2,
      alpha: self.degreesOfFreedom.realValue / 2,
      logarithmic: logarithmic
    )
  }

  public func sample() -> Double {
    return self.gamma.sample()
  }

  public func sample(_ numberOfElements: Int) -> [Double] {
    return self.gamma.sample(numberOfElements)
  }
}
