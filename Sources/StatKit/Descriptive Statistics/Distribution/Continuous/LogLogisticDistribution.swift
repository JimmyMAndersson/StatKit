import RealModule

/// A type alias for ``LogLogisticDistribution``.
public typealias FiskDistribution = LogLogisticDistribution

/// A type modelling a Log-Logistic Distribution.
public struct LogLogisticDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The scale parameter.
  public let alpha: Double

  /// The shape parameter.
  public let beta: Double

  /// The location parameter.
  public let mu: Double

  /// Creates a Log-Logistic Distribution with a specified scale, shape, and location.
  /// - parameter alpha: The scale parameter. Must be strictly greater than 0.
  /// - parameter beta: The shape parameter. Must be strictly greater than 0.
  /// - parameter mu: The location parameter. Defaults to 0.
  public init(alpha: Double, beta: Double, mu: Double = 0) {
    precondition(
      0 < alpha,
      "The scale parameter alpha must be strictly greater than 0 (\(alpha) was used)."
    )
    precondition(
      0 < beta,
      "The shape parameter beta must be strictly greater than 0 (\(beta) was used)."
    )

    self.alpha = alpha
    self.beta = beta
    self.mu = mu
  }

  /// Creates a Log-Logistic Distribution with a specified scale, shape, and location.
  /// - parameter scale: The scale parameter. Must be strictly greater than 0.
  /// - parameter shape: The shape parameter. Must be strictly greater than 0.
  /// - parameter location: The location parameter. Defaults to 0.
  public init(scale: Double, shape: Double, location: Double = 0) {
    self.init(alpha: scale, beta: shape, mu: location)
  }

  public var mean: Double {
    guard 1 < beta else { return .nan }
    let t: Double = .pi / beta
    return mu + alpha * t / .sin(t)
  }

  public var variance: Double {
    guard 2 < beta else { return .nan }
    let t: Double = .pi / beta
    let m1: Double = t / .sin(t)
    let m2: Double = 2 * t / .sin(2 * t)
    return .pow(alpha, 2) * (m2 - .pow(m1, 2))
  }

  public var skewness: Double {
    guard 3 < beta else { return .nan }
    let t: Double = .pi / beta
    let m1: Double = alpha * t / .sin(t)
    let m2: Double = .pow(alpha, 2) * 2 * t / .sin(2 * t)
    let m3: Double = .pow(alpha, 3) * 3 * t / .sin(3 * t)
    let variance: Double = m2 - m1 * m1
    let centralM3: Double = m3 - 3 * m1 * m2 + 2 * .pow(m1, 3)
    return centralM3 / .pow(variance, 1.5)
  }

  public var excessKurtosis: Double {
    guard 4 < beta else { return .nan }
    let t: Double = .pi / beta
    let m1: Double = alpha * t / .sin(t)
    let m2: Double = .pow(alpha, 2) * 2 * t / .sin(2 * t)
    let m3: Double = .pow(alpha, 3) * 3 * t / .sin(3 * t)
    let m4: Double = .pow(alpha, 4) * 4 * t / .sin(4 * t)
    let variance: Double = m2 - m1 * m1
    let centralM4: Double = m4 - 4 * m1 * m3 + 6 * .pow(m1, 2) * m2 - 3 * .pow(m1, 4)
    return centralM4 / .pow(variance, 2) - 3
  }

  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    guard !x.isNaN else { return .nan }
    guard mu < x else { return logarithmic ? -.infinity : 0 }
    guard x.isFinite else { return logarithmic ? -.infinity : 0 }
    let logZ: Double = .log(x - mu) - .log(alpha)
    let logPDF: Double = .log(beta) - .log(alpha) + (beta - 1) * logZ - 2 * .log(onePlus: .exp(beta * logZ))
    return logarithmic ? logPDF : .exp(logPDF)
  }

  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    guard !x.isNaN else { return .nan }
    guard mu < x else { return logarithmic ? -.infinity : 0 }
    guard x.isFinite else { return logarithmic ? 0 : 1 }
    let logZ: Double = .log(x - mu) - .log(alpha)
    let logCDF: Double = -.log(onePlus: .exp(-beta * logZ))
    return logarithmic ? logCDF : .exp(logCDF)
  }

  public func sample() -> Double {
    let u: Double = .random(in: .leastNonzeroMagnitude ..< 1)
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
    return mu + alpha * .pow(p / (1 - p), 1 / beta)
  }
}
