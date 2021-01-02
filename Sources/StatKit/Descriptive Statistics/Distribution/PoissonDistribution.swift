#if os(Linux)
import Glibc
#else
import Darwin
#endif

public struct PoissonDistribution: DiscreteDistribution {
  public let rate: Double
  
  public init(rate: Double) {
    guard 0 < rate else {
      fatalError("The rate of an Exponential Distribution must be strictly greater than 0 (\(rate) was used).")
    }
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
    guard 0 < x else {
      fatalError("Poisson distributions only support non-negative integers (\(x) provided).")
    }
    
    let nominator = pow(rate, Double(x)) * exp(-rate)
    let denominator = Double(factorial(x))
    return nominator / denominator
  }
  
  public func cdf(x: Int) -> Double {
    switch x {
      case ..<0:
        return 0
        
      default:
        let sum = (0 ... x).reduce(into: 0) { result, number in
          result += pow(rate, Double(number)) / Double(factorial(number))
        }
        return exp(-rate) * sum
    }
  }
  
  public func sample() -> Int {
    let limit = exp(-rate)
    var arrivals = 0
    var uniformProduct = Double.random(in: 0 ... 1)
    
    while limit <= uniformProduct {
      arrivals += 1
      uniformProduct *= Double.random(in: 0 ... 1)
    }
    
    return arrivals
  }
}