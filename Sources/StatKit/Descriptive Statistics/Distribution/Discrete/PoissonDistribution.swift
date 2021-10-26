#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// A type modelling a Poisson Distribution.
public struct PoissonDistribution: DiscreteDistribution, UnivariateDistribution {
  /// The rate of events.
  public let rate: Double
  
  /// Creates a Poisson Distribution with a specified rate of events.
  /// - parameter rate: The rate of events for this distribution.
  public init(rate: Double) {
    precondition(
      0 < rate,
      "The rate of a Poisson Distribution must be strictly greater than 0 (\(rate) was used)."
    )
    
    self.rate = rate
  }
  
  public var mean: Double {
    return rate
  }
  
  public var variance: Double {
    return rate
  }
  
  public var skewness: Double {
    return 1 / sqrt(rate)
  }
  
  public var kurtosis: Double {
    return 3 + 1 / rate
  }
  
  public func pmf(x: Int) -> Double {
    guard 0 <= x else { return 0 }
    
    let logPMF = log(pow(rate, x.realValue)) - rate - gammaFunction(x: x.realValue + 1, log: true)
    return exp(logPMF)
  }
  
  public func cdf(x: Int) -> Double {
    switch x {
      case ..<0:
        return 0
        
      default:
        let sum = (0 ... x).reduce(into: 0) { result, number in
          result += pmf(x: number)
        }
        return sum
    }
  }
  
  public func sample() -> Int {
    var uniformGenerator = Xoroshiro256StarStar()
    let limit = exp(-rate)
    
    var arrivals = 0
    var uniformProduct = Double.random(in: 0 ... 1, using: &uniformGenerator)
    
    while limit < uniformProduct {
      arrivals += 1
      uniformProduct *= Double.random(in: 0 ... 1, using: &uniformGenerator)
    }
    
    return arrivals
  }
  
  public func sample(_ numberOfElements: Int) -> [Int] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    
    var uniformGenerator = Xoroshiro256StarStar()
    let limit = exp(-rate)
    
    return (1 ... numberOfElements).map { _ in
      var arrivals = 0
      var uniformProduct = Double.random(in: 0 ... 1, using: &uniformGenerator)
      
      while limit < uniformProduct {
        arrivals += 1
        uniformProduct *= Double.random(in: 0 ... 1, using: &uniformGenerator)
      }
      
      return arrivals
    }
  }
}
