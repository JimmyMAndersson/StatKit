import RealModule

/// A type modelling a Normal Distribution.
public struct NormalDistribution: ContinuousDistribution, UnivariateDistribution {
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
    self.variance = .pow(standardDeviation, 2)
  }
  
  public var skewness: Double {
    return .zero
  }
  
  public var excessKurtosis: Double {
    return .zero
  }
  
  public func cdf(x: Double, logarithmic: Bool = false) -> Double {
    let erfParameter = (x - mean) / (2 * variance).squareRoot()
    let result = 0.5 + 0.5 * .erf(erfParameter)
    
    switch result {
      case ...0:
        return logarithmic ? -.infinity : 0
      
      case 1...:
        return logarithmic ? 0 : 1
        
      default:
        return logarithmic ? .log(result) : result
    }
  }
  
  public func pdf(x: Double, logarithmic: Bool = false) -> Double {
    let exponent = -0.5 * .pow((x - mean) / variance.squareRoot(), 2)
    return logarithmic
    ? exponent - .log((variance * 2 * .pi).squareRoot())
    : .exp(exponent) / (variance * 2 * .pi).squareRoot()
  }
  
  public func sample() -> Double {
    let u1 = Double.random(in: 0 ... 1)
    let u2 = Double.random(in: 0 ... 1)
    return mean + (-2 * variance * .log(u1)).squareRoot() * .sin(2 * .pi * u2)
  }
  
  public func sample(_ numberOfElements: Int) -> [Double] {
    precondition(0 < numberOfElements, "The requested number of samples need to be greater than 0.")
    
    var uniformGenerator = Xoroshiro256StarStar()
    return (1 ... numberOfElements).map { _ in
      let u1 = Double.random(in: 0 ... 1, using: &uniformGenerator)
      let u2 = Double.random(in: 0 ... 1, using: &uniformGenerator)
      return mean + (-2 * variance * .log(u1)).squareRoot() * .sin(2 * .pi * u2)
    }
  }
}
