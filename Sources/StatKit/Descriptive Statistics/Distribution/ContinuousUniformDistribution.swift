public struct ContinuousUniformDistribution: ContinuousDistribution {
  public let lowerBound: Double
  public let upperBound: Double
  
  public init(_ lowerBound: Double, _ upperBound: Double) {
    precondition(
      lowerBound < upperBound,
      "The lower bound needs to be strictly less than the upper bound."
    )
    
    self.lowerBound = lowerBound
    self.upperBound = upperBound
  }
  
  public func pdf(x: Double) -> Double {
    guard lowerBound <= x && x <= upperBound else { return 0 }
    return 1 / (upperBound - lowerBound)
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
  
  public var kurtosis: Double {
    return 9 / 5
  }
  
  public func cdf(x: Double) -> Double {
    switch x {
      case ..<lowerBound:
        return 0
      case lowerBound...upperBound:
        return (x - lowerBound) / (upperBound - lowerBound)
      default:
        return 1
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
