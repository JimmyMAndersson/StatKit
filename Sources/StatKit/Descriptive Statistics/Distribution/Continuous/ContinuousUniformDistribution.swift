/// A type modelling a continuous Uniform Distribution.
public struct ContinuousUniformDistribution: ContinuousDistribution, UnivariateDistribution {
  /// The lower inclusive bound.
  public let lowerBound: Double
  
  /// The upper inclusive bound.
  public let upperBound: Double
  
  /// Creates a continuous Uniform Distribution with a specified lower and upper bound.
  /// - parameter lowerBound: The lower bound of the distribution (inclusive).
  /// - parameter upperBound: The upper bound of the distribution (inclusive).
  public init(_ lowerBound: Double, _ upperBound: Double) {
    precondition(
      lowerBound < upperBound,
      "The lower bound needs to be strictly less than the upper bound."
    )
    
    self.lowerBound = lowerBound
    self.upperBound = upperBound
  }
  
  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    guard lowerBound <= x && x <= upperBound else {
      return logarithmic ? -.infinity : 0
    }
    
    return logarithmic
    ? -.log(upperBound - lowerBound)
    : 1 / (upperBound - lowerBound)
  }
  
  public var mean: Double {
    return (lowerBound + upperBound) / 2
  }
  
  public var variance: Double {
    let difference = upperBound - lowerBound
    let differenceSquared = difference * difference
    return differenceSquared / 12
  }
  
  public var skewness: Double {
    return 0
  }
  
  public var excessKurtosis: Double {
    return -6 / 5
  }
  
  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    switch x {
      case ..<lowerBound:
        return logarithmic ? -.infinity : 0
      
      case lowerBound ..< upperBound:
        return logarithmic
        ? .log(x - lowerBound) - .log(upperBound - lowerBound)
        : (x - lowerBound) / (upperBound - lowerBound)
        
      default:
        return logarithmic ? 0 : 1
    }
  }
  
  public func sample() -> Double {
    return Double.random(in: lowerBound ... upperBound)
  }
  
  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    
    var uniformGenerator = Xoroshiro256StarStar()
    
    return (1 ... numberOfElements).map { _ in
      Double.random(in: lowerBound ... upperBound, using: &uniformGenerator)
    }
  }
}
