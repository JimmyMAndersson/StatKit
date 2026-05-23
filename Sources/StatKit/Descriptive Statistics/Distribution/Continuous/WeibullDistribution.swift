import RealModule

/// A type modelling a Weibull Distribution.
public struct WeibullDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The scale parameter.
  public let scale: Double

  /// The shape parameter.
  public let shape: Double

  /// The location parameter.
  public let location: Double

  /// Creates a Weibull Distribution with a specified scale, shape, and location.
  /// - parameter scale: The scale parameter. Must be strictly greater than 0.
  /// - parameter shape: The shape parameter. Must be strictly greater than 0.
  /// - parameter location: The location parameter. Defaults to 0.
  public init(scale: Double, shape: Double, location: Double = 0) {
    precondition(
      0 < scale,
      "The scale parameter must be strictly greater than 0 (\(scale) was used)."
    )
    precondition(
      0 < shape,
      "The shape parameter must be strictly greater than 0 (\(shape) was used)."
    )

    self.scale = scale
    self.shape = shape
    self.location = location
  }

  public var mean: Double {
    return location + scale * .gamma(1 + 1 / shape)
  }

  public var variance: Double {
    let m1: Double = .gamma(1 + 1 / shape)
    let m2: Double = .gamma(1 + 2 / shape)
    return .pow(scale, 2) * (m2 - .pow(m1, 2))
  }

  public var skewness: Double {
    let m1: Double = .gamma(1 + 1 / shape)
    let m2: Double = .gamma(1 + 2 / shape)
    let m3: Double = .gamma(1 + 3 / shape)
    let variance: Double = m2 - .pow(m1, 2)
    let centralM3: Double = m3 - 3 * m1 * m2 + 2 * .pow(m1, 3)
    return centralM3 / .pow(variance, 1.5)
  }

  public var excessKurtosis: Double {
    let m1: Double = .gamma(1 + 1 / shape)
    let m2: Double = .gamma(1 + 2 / shape)
    let m3: Double = .gamma(1 + 3 / shape)
    let m4: Double = .gamma(1 + 4 / shape)
    let variance: Double = m2 - .pow(m1, 2)
    let centralM4: Double = m4 - 4 * m1 * m3 + 6 * .pow(m1, 2) * m2 - 3 * .pow(m1, 4)
    return centralM4 / .pow(variance, 2) - 3
  }

  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    guard !x.isNaN else { return .nan }
    guard location <= x else { return logarithmic ? -.infinity : 0 }
    guard x.isFinite else { return logarithmic ? -.infinity : 0 }
    if x == location {
      if shape < 1 { return .infinity }
      if shape == 1 { return logarithmic ? -.log(scale) : 1 / scale }
      return logarithmic ? -.infinity : 0
    }
    let z: Double = (x - location) / scale
    let logPDF: Double = .log(shape) - .log(scale) + (shape - 1) * .log(z) - .pow(z, shape)
    return logarithmic ? logPDF : .exp(logPDF)
  }

  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    guard !x.isNaN else { return .nan }
    guard location < x else { return logarithmic ? -.infinity : 0 }
    guard x.isFinite else { return logarithmic ? 0 : 1 }
    let z: Double = .pow((x - location) / scale, shape)
    let logCDF: Double = .log(onePlus: -.exp(-z))
    return logarithmic ? logCDF : .exp(logCDF)
  }

  public func sample() -> Double {
    let u: Double = .random(in: Double.leastNonzeroMagnitude ..< 1)
    return quantile(u)
  }

  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    var rng = Xoroshiro256StarStar()
    return (1 ... numberOfElements).map { _ in
      quantile(Double.random(in: Double.leastNonzeroMagnitude ..< 1, using: &rng))
    }
  }

  private func quantile(_ p: Double) -> Double {
    return location + scale * .pow(-.log(p), 1 / shape)
  }
}
