import RealModule

/// A type modelling a Binomial Distribution.
public struct BinomialDistribution: DiscreteDistribution, UnivariateDistribution {
  /// The probability of a successful trial.
  ///
  /// This property models what is commonly referred to as `p`.
  public let probability: Double
  
  /// The number of trials under study.
  ///
  /// This property models what is commonly referred to as `n`.
  public let trials: Int
  
  public var mean: Double {
    Double(trials) * probability
  }
  
  public var variance: Double {
    Double(trials) * probability * (1 - probability)
  }
  
  public var skewness: Double {
    (1 - 2 * probability) / (variance).squareRoot()
  }
  
  public var kurtosis: Double {
    3 + (1 - 6 * probability * (1 - probability)) / variance
  }
  
  /// Creates a Binomial Distribution for a specified number of trials and a probability.
  /// - parameter probability: The probability of a successful trial.
  /// - parameter trials: The number of trials under investigation.
  ///
  /// The `probability` and `trials` are also commonly known as `p` and `n`, respectively.
  public init(probability: Double, trials: Int) {
    precondition(
      0 < probability && probability < 1,
      "The probability needs to be in (0, 1) (\(probability) provided)."
    )
    precondition(
      0 <= trials,
      "Possibilities need to non-negative (\(trials) provided)."
    )
    
    self.probability = probability
    self.trials = trials
  }
  
  public func pmf(x: Int) -> Double {
    let coefficient = Double(choose(n: trials, k: x))
    let successes: Double = .pow(probability, Double(x))
    let failures: Double = .pow(1 - probability, Double(trials - x))
    return coefficient * successes * failures
  }
  
  public func cdf(x: Int) -> Double {
    return (0 ... x).reduce(into: 0) { (result, successes) in
      result += pmf(x: successes)
    }
  }
  
  public func sample() -> Int {
    let probability = Double.random(in: 0 ... 1)
    var cumulativeProbability = 0.0
    
    for successes in 0 ... trials {
      cumulativeProbability += pmf(x: successes)
      if probability <= cumulativeProbability {
        return successes
      }
    }
    
    return trials
  }
  
  public func sample(_ numberOfElements: Int) -> [Int] {
    var uniformGenerator = Xoroshiro256StarStar()
    let probabilities = (1 ... numberOfElements).map { _ in Double.random(in: 0 ... 1, using: &uniformGenerator) }
    var cumulativeProbs = [Double](repeating: 0, count: trials + 1)
    cumulativeProbs[0] = pmf(x: 0)
    
    for x in 1 ... trials {
      cumulativeProbs[x] = cumulativeProbs[x - 1] + pmf(x: x)
    }
    
    let successes: [Int] = probabilities.map { probability in
      guard let index = cumulativeProbs.firstIndex(where: { cumulativeProb in
          return probability <= cumulativeProb
        })
      else {
        fatalError("The produced probability was not in range [0, 1]. Please file a bug report.")
      }
      
      return index
    }
    
    return successes
  }
}
