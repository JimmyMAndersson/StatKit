#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// A type modelling a discrete Uniform Distribution.
public struct DiscreteUniformDistribution: DiscreteDistribution {
  /// The lower inclusive bound.
  public let lowerBound: Int
  
  /// The upper inclusive bound.
  public let upperBound: Int
  
  /// The number of included integers.
  private let integerCount: Int
  
  /// Creates a discrete Uniform Distribution with a specified lower and upper bound.
  /// - parameter lowerBound: The lower bound of the distribution (inclusive).
  /// - parameter upperBound: The upper bound of the distribution (inclusive).
  public init(_ lowerBound: Int, _ upperBound: Int) {
    precondition(
      lowerBound <= upperBound,
      "The lower bound needs to be less than or equal to the upper bound."
    )
    
    self.lowerBound = lowerBound
    self.upperBound = upperBound
    self.integerCount = upperBound - lowerBound + 1
  }
  
  public func pmf(x: Int) -> Double {
    return 1 / Double(integerCount)
  }
  
  public var mean: Double {
    return Double(lowerBound + upperBound) / 2
  }
  
  public var variance: Double {
    return (pow(Double(integerCount), 2) - 1) / 12
  }
  
  public var skewness: Double {
    return 0
  }
  
  public var kurtosis: Double {
    let numerator = 6 * pow(Double(integerCount), 2) + 6
    let denominator = 5 * pow(Double(integerCount), 2) - 5
    return 3 - numerator / denominator
  }
  
  public func cdf(x: Int) -> Double {
    switch x {
      case ..<lowerBound:
        return 0
      
      case upperBound...:
        return 1
        
      default:
        return Double(x - lowerBound + 1) / Double(integerCount)
    }
  }
  
  public func sample() -> Int {
    return Int.random(in: lowerBound ... upperBound)
  }
  
  public func sample(_ numberOfElements: Int) -> [Int] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    
    var uniformGenerator = Xoroshiro256StarStar()
    
    return (1 ... numberOfElements).map { _ in
      Int.random(in: lowerBound ... upperBound, using: &uniformGenerator)
    }
  }
}
