/// A type modelling a Gamma Distribution.
public struct GammaDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The Gamma distribution shape parameter.
  public let shape: Double

  /// The Gamma distribution scale parameter.
  public let scale: Double

  /// The Gamma distribution rate parameter.
  public var rate: Double {
    return 1 / self.scale
  }

  /// Creates a Gamma Distribution with a specified alpha and beta parameters.
  /// - parameter alpha: The distribution alpha parameter.
  /// - parameter beta: The distribution beta parameter.
  @available(*, deprecated, renamed: "init(shape:scale:)")
  public init(alpha: Double, beta: Double) {
    precondition(0 < alpha, "The shape parameter needs to be greater than 0.")
    precondition(0 < beta, "The scale parameter needs to be greater than 0.")

    self.shape = alpha
    self.scale = beta
  }

  /// Creates a Gamma Distribution with a specified shape and scale parameters.
  /// - parameter shape: The distribution shape parameter.
  /// - parameter scale: The distribution scale parameter.
  public init(shape: Double, scale: Double) {
    precondition(0 < shape, "The shape parameter needs to be greater than 0.")
    precondition(0 < scale, "The scale parameter needs to be greater than 0.")

    self.shape = shape
    self.scale = scale
  }

  /// Creates a Gamma Distribution with a specified shape and rate parameters.
  /// - parameter shape: The distribution shape parameter.
  /// - parameter rate: The distribution rate parameter.
  public init(shape: Double, rate: Double) {
    precondition(0 < shape, "The shape parameter needs to be greater than 0.")
    precondition(0 < rate, "The rate parameter needs to be greater than 0.")

    self.shape = shape
    self.scale = 1 / rate
  }

  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    guard 0 <= x else {
      return logarithmic ? -.infinity : .zero
    }

    let epsilon = x == .zero ? 0.ulp : 0
    let logNumerator = (self.shape - 1) * .log(x + epsilon) - x / self.scale
    let logDenominator = Double.logGamma(self.shape) + self.shape * .log(self.scale)
    let logProbability = logNumerator - logDenominator
    
    return logarithmic ? logProbability : .exp(logProbability)
  }
  
  public var mean: Double {
    return self.shape * self.scale
  }
  
  public var variance: Double {
    return self.shape * .pow(self.scale, 2)
  }
  
  public var skewness: Double {
    return 2 / self.shape.squareRoot()
  }
  
  public var kurtosis: Double {
    return 6 / self.shape + 3
  }
  
  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    guard 0 < x else {
      return logarithmic ? -.infinity : .zero
    }
    return regularizedIncompleteGamma(lower: .zero, upper: self.rate * x, alpha: self.shape, logarithmic: logarithmic)
  }
  
  public func sample() -> Double {
    var uniformGenerator = Xoroshiro256StarStar()
    
    switch self.shape {
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
    
    switch self.shape {
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
    let d = 1.0334 - 0.0766 * .exp(2.2942 * self.shape)
    
    let firstFactorA = Double.pow(2.0, self.shape)
    let secondFactorA = Double.pow(1 - .exp(-d / 2), self.shape)
    let a = firstFactorA * secondFactorA
    
    let b = self.shape * .pow(d, self.shape - 1) * .exp(-d)
    
    let c = a + b
    
    for _ in 1 ... 50 {
      let U = Double.random(in: Double.leastNonzeroMagnitude ..< 1, using: &generator)
      
      let X: Double
      
      if U <= a / c {
        X = -2 * .log(1 - .pow(c * U, 1 / self.shape) / 2)
      } else {
        let numerator = c * (1 - U)
        let denominator = self.shape * .pow(d, self.shape - 1)
        X = -.log(numerator / denominator)
      }
      
      let V = Double.random(in: Double.leastNonzeroMagnitude ..< 1, using: &generator)
      let threshold: Double
      
      if X <= d {
        let thresholdNumerator = .pow(X, self.shape - 1) * .exp(-X / 2)
        let thresholdDenominator = .pow(2, self.shape - 1) * .pow(1 - .exp(-X / 2), self.shape - 1)
        threshold = thresholdNumerator / thresholdDenominator
      } else {
        threshold = .pow(d / X, 1 - self.shape)
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
    let proposalAlpha = self.shape.rounded(.down)

    let proposalBeta: Double
    let proposalK: Double
    
    switch self.shape {
    case 1..<2:
      proposalBeta = self.rate / self.shape
      proposalK = .exp(1 - self.shape) * .pow(self.shape / self.rate, self.shape - 1)

    default:
      proposalBeta = self.rate * (proposalAlpha - 1) / (self.shape - 1)
      proposalK = .exp(proposalAlpha - self.shape) * .pow((self.shape - 1) / self.rate, self.shape - proposalAlpha)
    }
    
    for _ in 1 ... 50 {
      let uniformProduct = (1 ... Int(proposalAlpha))
        .map { _ in
          Double.random(in: 0 ... 1, using: &generator)
        }
        .reduce(into: 1, *=)
      
      let proposal = -.log(uniformProduct) / proposalBeta
      let random = Double.random(in: 0 ... 1, using: &generator)
      let p = .pow(proposal, self.shape - 1) * .exp(-self.rate * proposal)
      let pi = proposalK * .pow(proposal, proposalAlpha - 1) * .exp(-proposalBeta * proposal)
      
      if random <= p / pi {
        return proposal
      }
    }
    
    preconditionFailure("Failed to generate Gamma variate within a reasonable amount of time.")
  }
}
