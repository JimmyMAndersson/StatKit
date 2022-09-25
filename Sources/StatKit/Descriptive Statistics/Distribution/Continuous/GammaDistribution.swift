/// A type modelling a Gamma Distribution.
public struct GammaDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The Gamma distribution shape parameter.
  public let alpha: Double
  
  /// The Gamma distribution rate parameter.
  public let beta: Double
  
  /// Creates a Gamma Distribution with a specified alpha and beta parameters.
  /// - parameter alpha: The distribution shape parameter.
  /// - parameter beta: The distribution rate parameter.
  public init(alpha: Double, beta: Double) {
    precondition(0 < alpha, "The alpha parameter needs to be greater than 0.")
    precondition(0 < beta, "The beta parameter needs to be greater than 0.")
    
    self.alpha = alpha
    self.beta = beta
  }
  
  /// Creates a Gamma Distribution with a specified shape and rate parameters.
  /// - parameter shape: The distribution shape parameter.
  /// - parameter rate: The distribution rate parameter.
  public init(shape: Double, rate: Double) {
    precondition(0 < shape, "The shape parameter needs to be greater than 0.")
    precondition(0 < rate, "The rate parameter needs to be greater than 0.")
    
    self.alpha = shape
    self.beta = rate
  }
  
  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    guard 0 < x else {
      return logarithmic ? -.infinity : .zero
    }
    
    let logNumerator = (alpha - 1) * .log(x) - x / beta
    let logDenominator = Double.logGamma(alpha) + alpha * .log(beta)
    let logProbability = logNumerator - logDenominator
    
    return logarithmic ? logProbability : .exp(logProbability)
  }
  
  public var mean: Double {
    return alpha * beta
  }
  
  public var variance: Double {
    return alpha * .pow(beta, 2)
  }
  
  public var skewness: Double {
    return 2 / alpha.squareRoot()
  }
  
  public var kurtosis: Double {
    return 6 / alpha + 3
  }
  
  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    guard 0 < x else {
      return logarithmic ? -.infinity : .zero
    }
    return regularizedIncompleteGamma(lower: .zero, upper: beta * x, alpha: alpha, logarithmic: logarithmic)
  }
  
  public func sample() -> Double {
    var uniformGenerator = Xoroshiro256StarStar()
    
    switch alpha {
    case 0..<1:
      return kunduGuptaSampling(using: &uniformGenerator)
      
    default:
      return martinoLuengoSampling(using: &uniformGenerator)
    }
  }
  
  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    var uniformGenerator = Xoroshiro256StarStar()
    let sampleRange = 1 ... numberOfElements
    
    switch alpha {
    case 0..<1:
      return sampleRange.map { _ in kunduGuptaSampling(using: &uniformGenerator) }
      
    default:
      return sampleRange.map { _ in martinoLuengoSampling(using: &uniformGenerator) }
    }
  }
  
  /// Computes a sample of a Gamma distribution with `0 < alpha < 1`.
  /// - parameter generator: A uniform random number generator to be used in the computation.
  /// - returns: A Gamma distribution sample.
  ///
  /// `alpha` must be in range (0, 1).
  ///
  /// Inspired by and based on work by Kundu and Gupta in their paper
  /// '**A Convenient Way of Generating Gamma Random Variables Using Generalized Exponential Distribution**'.
  private func kunduGuptaSampling(using generator: inout some RandomNumberGenerator) -> Double {
    let d = 1.0334 - 0.0766 * .exp(2.2942 * alpha)
    
    let firstFactorA = Double.pow(2.0, alpha)
    let secondFactorA = Double.pow(1 - .exp(-d / 2), alpha)
    let a = firstFactorA * secondFactorA
    
    let b = alpha * .pow(d, alpha - 1) * .exp(-d)
    
    let c = a + b
    
    for _ in 1 ... 50 {
      let U = Double.random(in: Double.leastNonzeroMagnitude ..< 1, using: &generator)
      
      let X: Double
      
      if U <= a / c {
        X = -2 * .log(1 - .pow(c * U, 1 / alpha) / 2)
      } else {
        let numerator = c * (1 - U)
        let denominator = alpha * .pow(d, alpha - 1)
        X = -.log(numerator / denominator)
      }
      
      let V = Double.random(in: Double.leastNonzeroMagnitude ..< 1, using: &generator)
      let threshold: Double
      
      if X <= d {
        let thresholdNumerator = .pow(X, alpha - 1) * .exp(-X / 2)
        let thresholdDenominator = .pow(2, alpha - 1) * .pow(1 - .exp(-X / 2), alpha - 1)
        threshold = thresholdNumerator / thresholdDenominator
      } else {
        threshold = .pow(d / X, 1 - alpha)
      }
      
      if V <= threshold {
        return X
      }
    }
    
    preconditionFailure("Failed to generate Gamma variate within a reasonable amount of time.")
  }
  
  /// Computes a sample of a Gamma distribution with `alpha >= 1`.
  /// - parameter generator: A uniform random number generator to be used in the computation.
  /// - returns: A Gamma distribution sample.
  ///
  /// `alpha` must be in range [1, +infinity].
  /// This method uses rejection sampling to generate proposal samples from the Gamma distribution.
  ///
  /// Inspired by and based on work by Martino and Luengo in their paper
  /// '**Extremely Efficient Generation of Gamma Random Variables for `alpha` >= 1**'.
  private func martinoLuengoSampling(using generator: inout some RandomNumberGenerator) -> Double {
    let proposalAlpha = alpha.rounded(.down)
    
    let proposalBeta: Double
    let proposalK: Double
    
    switch alpha {
    case 1..<2:
      proposalBeta = beta / alpha
      proposalK = .exp(1 - alpha) * .pow(alpha / beta, alpha - 1)
      
    default:
      proposalBeta = beta * (proposalAlpha - 1) / (alpha - 1)
      proposalK = .exp(proposalAlpha - alpha) * .pow((alpha - 1) / beta, alpha - proposalAlpha)
    }
    
    for _ in 1 ... 50 {
      let uniformProduct = (1 ... Int(proposalAlpha))
        .map { _ in
          Double.random(in: 0 ... 1, using: &generator)
        }
        .reduce(into: 1, *=)
      
      let proposal = -.log(uniformProduct) / proposalBeta
      let random = Double.random(in: 0 ... 1, using: &generator)
      let p = .pow(proposal, alpha - 1) * .exp(-beta * proposal)
      let pi = proposalK * .pow(proposal, proposalAlpha - 1) * .exp(-proposalBeta * proposal)
      
      if random <= p / pi {
        return proposal
      }
    }
    
    preconditionFailure("Failed to generate Gamma variate within a reasonable amount of time.")
  }
}
