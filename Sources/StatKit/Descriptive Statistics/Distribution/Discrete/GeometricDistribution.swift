#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// A type modelling a Geometric Distribution.
public struct GeometricDistribution: DiscreteDistribution {
  /// The probability of a successful trial.
  ///
  /// This property models what is commonly referred to as `p`.
  public let probability: Double
  
  public var mean: Double {
    1 / probability
  }
  
  public var variance: Double {
    (1 - probability) / pow(probability, 2)
  }
  
  public var skewness: Double {
    (2 - probability) / sqrt(1 - probability)
  }
  
  public var kurtosis: Double {
    9 + pow(probability, 2) / (1 - probability)
  }
  
  /// Creates a Geometric Distribution for a specified probability.
  /// - parameter probability: The probability of a successful trial.
  public init(probability: Double) {
    precondition(
      0 < probability && probability < 1,
      "The probability needs to be in (0, 1) (\(probability) provided)."
    )
    
    self.probability = probability
  }
  
  public func pmf(x: Int) -> Double {
    switch x {
      case ...0:
        return 0
      default:
        return pow(1 - probability, (x - 1).realValue) * probability
    }
  }
  
  public func cdf(x: Int) -> Double {
    switch x {
      case ...0:
        return 0
      default:
        return 1 - pow(1 - probability, x.realValue)
    }
  }
  
  public func sample() -> Int {
    let inverseMapping = log(1 - .random(in: 0 ..< 1)) / log(1 - probability)
    let sample = inverseMapping.rounded(.up)
    return Swift.min(Int(sample), Int.max)
  }
  
  public func sample(_ numberOfElements: Int) -> [Int] {
    var uniformGenerator = Xoroshiro256StarStar()
    let samples: [Int] = (1 ... numberOfElements).lazy
      .map { _ -> Int in
        let inverseMapping = log(1 - .random(in: 0 ..< 1, using: &uniformGenerator)) / log(1 - probability)
        let sample = inverseMapping.rounded(.up)
        return Swift.min(Int(sample), Int.max)
      }
    
    return samples
  }
}
