#if os(Linux)
import Glibc
#else
import Darwin
#endif

public struct ExponentialDistribution: ContinuousDistribution {
  public let rate: Double
  
  public init(rate: Double) {
    guard 0 < rate else {
      fatalError("The rate of an Exponential Distribution must be strictly greater than 0 (\(rate) was used).")
    }
    self.rate = rate
  }
  
  public func pdf(x: Double) -> Double {
    switch x {
      case ..<0:
        return 0
      
      default:
        return rate * exp(-rate * x)
    }
  }
  
  public var mean: Double {
    return 1 / rate
  }
  
  public var variance: Double {
    return 1 / pow(rate, 2)
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
        return 1 - exp(-rate * x)
    }
  }
  
  public func sample() -> Double {
    let uniformSample = Double.random(in: 0 ..< 1)
    return log(1 - uniformSample) / -rate
  }
  
  public func sample(_ numberOfElements: Int) -> [Double] {
    (0 ..< numberOfElements).map { _ in
      sample()
    }
  }
}
