import RealModule

/// A type modelling an Exponential Distribution.
public struct BetaDistribution: ContinuousDistribution, UnivariateDistribution {
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
    let denominator = .pow(alpha + beta, 2) * (alpha + beta + 1)
    return numerator / denominator
  }
  
  public var skewness: Double {
    let numerator = 2 * (beta - alpha) * .sqrt(alpha + beta + 1)
    let denominator = (alpha + beta + 2) * .sqrt(alpha * beta)
    return numerator / denominator
  }
  
  public var kurtosis: Double {
    let numerator = 6 * (.pow(alpha - beta, 2) * (alpha + beta + 1) - alpha * beta * (alpha + beta + 2))
    let denominator = alpha * beta * (alpha + beta + 2) * (alpha + beta + 3)
    return 3 + (numerator / denominator)
  }
  
  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    switch x {
      case ...0, 1...:
        return logarithmic ? -.infinity : 0
      
      default:
        let logBeta = .logGamma(alpha + beta) - .logGamma(alpha) - .logGamma(beta)
        let logX = (alpha - 1) * .log(x) + (beta - 1) * .log(1 - x)
        return logarithmic ? logBeta + logX : .exp(logBeta + logX)
    }
  }
  
  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    if x <= 0 { return logarithmic ? -.infinity : 0 }
    if 1 <= x { return logarithmic ? 0 : 1 }
    
    let result = regularizedIncompleteBeta(x: x, alpha: alpha, beta: beta)
    
    switch result {
      case ...0:
        return logarithmic ? -.infinity : 0
      
      case 1...:
        return logarithmic ? 0 : 1
        
      default:
        return logarithmic ? .log(result) : result
    }
  }
  
  /// Samples a single value from the distribution.
  /// - returns: A sample from the distribution.
  ///
  /// Sampling is performed according to the work of R.C.H. Cheng in
  /// "Generating Beta Variates with Nonintegral Shape Parameters".
  public func sample() -> Double {
    
    var uniformRNG = Xoroshiro256StarStar()
    let a = alpha + beta
    let b: Double
    
    if Swift.min(alpha, beta) <= 1 {
      b = Swift.max(1 / alpha, 1 / beta)
    } else {
      b = .sqrt((a - 2) / (2 * alpha * beta - a))
    }
    
    let gamma = alpha + 1 / b
    var V = 0.0
    var W = 0.0
    var test = Double.infinity
    var acceptance = Double.infinity
    let sampleRange = Double.leastNonzeroMagnitude ..< 1
    
    repeat {
      let u1 = Double.random(in: sampleRange, using: &uniformRNG)
      let u2 = Double.random(in: sampleRange, using: &uniformRNG)
      
      V = b * .log(u1 / (1 - u1))
      W = alpha * .exp(V)
      
      test = a * .log(a / (beta + W)) + gamma * V - .log(4)
      acceptance = .log(.pow(u1, 2) * u2)
      
    } while test < acceptance
    
    return W / (beta + W)
  }
  
  /// Samples a specified number of values from the distribution.
  /// - parameter numberOfElements: The number of samples to generate.
  /// - returns: An array of sampled values.
  ///
  /// Sampling is performed according to the work of R.C.H. Cheng in
  /// "Generating Beta Variates with Nonintegral Shape Parameters".
  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")

    var uniformRNG = Xoroshiro256StarStar()
    let a = alpha + beta
    let b: Double
    
    if Swift.min(alpha, beta) <= 1 {
      b = Swift.max(1 / alpha, 1 / beta)
    } else {
      b = .sqrt((a - 2) / (2 * alpha * beta - a))
    }
    
    return (1 ... numberOfElements).map { _ in
      let gamma = alpha + 1 / b
      var V = 0.0
      var W = 0.0
      var test = Double.infinity
      var acceptance = Double.infinity
      let sampleRange = Double.leastNonzeroMagnitude ..< 1
      
      repeat {
        let u1 = Double.random(in: sampleRange, using: &uniformRNG)
        let u2 = Double.random(in: sampleRange, using: &uniformRNG)
        
        V = b * .log(u1 / (1 - u1))
        W = alpha * .exp(V)
        
        test = a * .log(a / (beta + W)) + gamma * V - .log(4)
        acceptance = .log(.pow(u1, 2) * u2)
        
      } while test < acceptance
      
      return W / (beta + W)
    }
  }
}
