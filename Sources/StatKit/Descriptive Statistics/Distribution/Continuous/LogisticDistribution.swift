import RealModule

/// A type modelling a Logistic Distribution.
public struct LogisticDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The location parameter.
  public let mu: Double

  /// The scale parameter.
  public let scale: Double

  /// Creates a Logistic Distribution with a specified location and scale.
  /// - parameter mu: The location parameter for this distribution.
  /// - parameter scale: The scale parameter for this distribution.
  public init(mu: Double, scale: Double) {
    precondition(
      0 < scale,
      "The scale parameter must be strictly greater than 0 (\(scale) was used)."
    )

    self.mu = mu
    self.scale = scale
  }

  public var mean: Double {
    return mu
  }

  public var variance: Double {
    return .pow(.pi, 2) / 3 * .pow(scale, 2)
  }

  public var skewness: Double {
    return 0
  }

  public var excessKurtosis: Double {
    return 6 / 5
  }

  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    let z = (x - mu) / scale
    let logPDF = logCDF(z: z) + logCDF(z: -z) - .log(scale)
    return logarithmic ? logPDF : .exp(logPDF)
  }

  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    let value = logCDF(z: (x - mu) / scale)
    return logarithmic ? value : .exp(value)
  }

  public func sample() -> Double {
    quantile(Double.random(in: Double.leastNonzeroMagnitude ..< 1))
  }

  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    var rng = Xoroshiro256StarStar()
    return (1 ... numberOfElements).map { _ in
      quantile(Double.random(in: Double.leastNonzeroMagnitude ..< 1, using: &rng))
    }
  }

  private func quantile(_ p: Double) -> Double {
    mu + scale * (.log(p) - .log(onePlus: -p))
  }

  private func logCDF(z: Double) -> Double {
    if z >= 0 {
      return -Double.log(onePlus: Double.exp(-z))
    } else {
      return z - Double.log(onePlus: Double.exp(z))
    }
  }
}
