/// A type modelling an Erlang Distribution.
public struct ErlangDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The Erlang distribution shape parameter.
  public var shape: Int {
    return Int(self.gamma.shape)
  }

  /// The Erlang distribution scale parameter.
  public var scale: Double {
    return self.gamma.scale
  }

  /// The Erlang distribution rate parameter.
  public var rate: Double {
    return self.gamma.rate
  }

  /// A Gamma distribution helper for sampling purposes.
  /// Since The Erlang Distribution is a special case of the Gamma Distribution,
  /// we can use the already implemented methods.
  private let gamma: GammaDistribution

  /// Creates an Erlang Distribution with a specified shape and scale parameters.
  /// - parameter shape: The distribution shape parameter.
  /// - parameter scale: The distribution scale parameter.
  public init(shape: Int, scale: Double) {
    precondition(0 < shape, "The shape parameter needs to be greater than 0.")
    precondition(0 < scale, "The scale parameter needs to be greater than 0.")

    self.gamma = GammaDistribution(shape: shape.realValue, scale: scale)
  }

  /// Creates an Erlang Distribution with a specified shape and rate parameters.
  /// - parameter shape: The distribution shape parameter.
  /// - parameter rate: The distribution rate parameter.
  public init(shape: Int, rate: Double) {
    precondition(0 < shape, "The shape parameter needs to be greater than 0.")
    precondition(0 < rate, "The rate parameter needs to be greater than 0.")

    self.gamma = GammaDistribution(shape: shape.realValue, rate: rate)
  }

  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    return self.gamma.pdf(x: x, logarithmic: logarithmic)
  }

  public var mean: Double {
    return self.gamma.mean
  }

  public var variance: Double {
    return self.gamma.variance
  }

  public var skewness: Double {
    return self.gamma.skewness
  }

  public var kurtosis: Double {
    return self.gamma.kurtosis
  }

  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    return self.gamma.cdf(x: x, logarithmic: logarithmic)
  }

  public func sample() -> Double {
    return self.gamma.sample()
  }

  public func sample(_ numberOfElements: Int) -> [Double] {
    return self.gamma.sample(numberOfElements)
  }
}
