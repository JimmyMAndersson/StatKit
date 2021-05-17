#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// A type modelling an Exponential Distribution.
public struct BetaDistribution: ContinuousDistribution {
  /// The alpha shape of the distribution.
  public let alpha: Double
  
  /// The beta shape of the distribution.
  public let beta: Double
  
  /// Creates a Beta Distribution with a specified alpha and beta shape.
  /// - parameter alpha: The alpha shape for this distribution.
  /// - parameter beta: The beta shape for this distribution.
  public init(alpha: Double, beta: Double) {
    precondition(
      0 < alpha,
      "The alphaparameter must be strictly greater than 0 (\(alpha) was used)."
    )
    precondition(
      0 < beta,
      "The alphaparameter must be strictly greater than 0 (\(beta) was used)."
    )
    
    self.alpha = alpha
    self.beta = beta
  }
  
  public var mean: Double {
    alpha / (alpha + beta)
  }
  
  public var variance: Double {
    let numerator = alpha * beta
    let denominator = pow(alpha + beta, 2) * (alpha + beta + 1)
    return numerator / denominator
  }
  
  public var skewness: Double {
    let numerator = 2 * (beta - alpha) * sqrt(alpha + beta + 1)
    let denominator = (alpha + beta + 2) * sqrt(alpha * beta)
    return numerator / denominator
  }
  
  public var kurtosis: Double {
    let numerator = 6 * (pow(alpha - beta, 2) * (alpha + beta + 1) - alpha * beta * (alpha + beta + 2))
    let denominator = alpha * beta * (alpha + beta + 2) * (alpha + beta + 3)
    return 3 + (numerator / denominator)
  }
  
  public func pdf(x: Double) -> Double {
    switch x {
      case ...0:
        return 0
      case 1...:
        return 0
      default:
        let logBeta = lgamma(alpha + beta) - lgamma(alpha) - lgamma(beta)
        let logX = (alpha - 1) * log(x) + (beta - 1) * log(1 - x)
        return exp(logBeta + logX)
    }
  }
  
  public func cdf(x: Double) -> Double {
    if x <= 0 { return 0 }
    if 1 <= x { return 1 }
    
    return 0
  }
  
  public func sample() -> Double {
    0
  }
  
  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")

    var _ = Xoroshiro256StarStar()

    return []
  }
}
