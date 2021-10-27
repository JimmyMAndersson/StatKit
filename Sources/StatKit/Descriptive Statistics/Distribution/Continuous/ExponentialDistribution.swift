import RealModule

/// A type modelling an Exponential Distribution.
public struct ExponentialDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The rate of events.
  public let rate: Double
  
  /// Creates an Exponential Distribution with a specified rate of events.
  /// - parameter rate: The rate of events for this distribution.
  public init(rate: Double) {
    precondition(
      0 < rate,
      "The rate of an Exponential Distribution must be strictly greater than 0 (\(rate) was used)."
    )
    
    self.rate = rate
  }
  
  public func pdf(x: Double) -> Double {
    switch x {
      case ..<0:
        return 0
        
      default:
        return rate * .exp(-rate * x)
    }
  }
  
  public var mean: Double {
    return 1 / rate
  }
  
  public var variance: Double {
    return 1 / .pow(rate, 2)
  }
  
  public var skewness: Double {
    return 2
  }
  
  public var kurtosis: Double {
    return 9
  }
  
  public func cdf(x: Double) -> Double {
    switch x {
      case ...0:
        return 0
        
      default:
        return 1 - .exp(-rate * x)
    }
  }
  
  public func sample() -> Double {
    return .log(1 - Double.random(in: 0 ..< 1)) / -rate
  }
  
  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    
    var uniformGenerator = Xoroshiro256StarStar()
    
    return (1 ... numberOfElements).map { _ in
        .log(1 - Double.random(in: 0 ..< 1, using: &uniformGenerator)) / -rate
    }
  }
}
