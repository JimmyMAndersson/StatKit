import RealModule

/// A type modelling an Arcsine Distribution.
public struct ArcSineDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The lower inclusive bound.
  public let lowerBound: Double

  /// The upper inclusive bound.
  public let upperBound: Double

  /// The underlying Beta distribution used to compute the PDF, CDF, and samples.
  private let betaDistribution = BetaDistribution(alpha: 0.5, beta: 0.5)

  /// Creates an Arcsine Distribution with a specified lower and upper bound.
  /// - parameter lowerBound: The lower bound of the distribution's support.
  /// - parameter upperBound: The upper bound of the distribution's support.
  public init(lowerBound: Double = 0, upperBound: Double = 1) {
    precondition(
      lowerBound.isFinite,
      "The lower bound must be finite (\(lowerBound) was used)."
    )
    precondition(
      upperBound.isFinite,
      "The upper bound must be finite (\(upperBound) was used)."
    )
    precondition(
      lowerBound < upperBound,
      "The lower bound needs to be strictly less than the upper bound."
    )
    self.lowerBound = lowerBound
    self.upperBound = upperBound
  }

  public var mean: Double {
    (lowerBound + upperBound) / 2
  }

  public var variance: Double {
    .pow(upperBound - lowerBound, 2) / 8
  }

  public var skewness: Double { 0 }

  public var excessKurtosis: Double { -1.5 }

  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    if x < lowerBound || x > upperBound { return logarithmic ? -.infinity : 0 }
    if x == lowerBound || x == upperBound { return .infinity }
    let y = (x - lowerBound) / (upperBound - lowerBound)
    return logarithmic
      ? betaDistribution.pdf(x: y, logarithmic: true) - .log(upperBound - lowerBound)
      : betaDistribution.pdf(x: y, logarithmic: false) / (upperBound - lowerBound)
  }

  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    if x <= lowerBound { return logarithmic ? -.infinity : 0 }
    if upperBound <= x { return logarithmic ? 0 : 1 }
    let y = (x - lowerBound) / (upperBound - lowerBound)
    return betaDistribution.cdf(x: y, logarithmic: logarithmic)
  }

  public func sample() -> Double {
    lowerBound + (upperBound - lowerBound) * betaDistribution.sample()
  }

  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    let range = upperBound - lowerBound
    return betaDistribution.sample(numberOfElements).map { lowerBound + range * $0 }
  }
}
