#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// A type modelling a Normal Distribution.
public struct NormalDistribution: ContinuousDistribution {
  public let mean: Double
  public let variance: Double
  
  /// Create a Normal DIstribution with a specified mean and variance.
  /// - parameter mean: The mean value of this distribution.
  /// - parameter variance: The variance for this distribution.
  public init(mean: Double, variance: Double) {
    precondition(
      0 < variance,
      "The variance of a normal distribution must be positive (\(variance) was used)."
    )
    
    self.mean = mean
    self.variance = variance
  }
  
  public init(mean: Double, standardDeviation: Double) {
    precondition(
      0 < standardDeviation,
      "The standard deviation of a normal distribution must be positive (\(standardDeviation) was used)."
    )
    
    self.mean = mean
    self.variance = pow(standardDeviation, 2)
  }
  
  public var skewness: Double {
    return 0
  }
  
  public var kurtosis: Double {
    return 3
  }
  
  public func cdf(x: Double) -> Double {
    let erfParameter = (x - mean) / sqrt(2 * variance)
    switch erfParameter {
      case 0:
        return 0.5
        
      case ...0:
        return 0.5 - 0.5 * GaussErrorFunction.erf(-erfParameter)
        
      default:
        return 0.5 + 0.5 * GaussErrorFunction.erf(erfParameter)
    }
  }
  
  public func pdf(x: Double) -> Double {
    let exponent = -0.5 * pow((x - mean) / sqrt(variance), 2)
    return exp(exponent) / sqrt(variance * 2 * .pi)
  }
  
  public func sample() -> Double {
    let u1 = Double.random(in: 0 ... 1)
    let u2 = Double.random(in: 0 ... 1)
    return mean + sqrt(-2 * variance * log(u1)) * sin(2 * .pi * u2)
  }
  
  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    
    var uniformGenerator = Xoroshiro256StarStar()
    return (1 ... numberOfElements).map { _ in
      let u1 = Double.random(in: 0 ... 1, using: &uniformGenerator)
      let u2 = Double.random(in: 0 ... 1, using: &uniformGenerator)
      return mean + sqrt(-2 * variance * log(u1)) * sin(2 * .pi * u2)
    }
  }
}
