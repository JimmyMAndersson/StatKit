#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// 
public enum GaussErrorFunction {
  /// Constant used to compute the approximation of `erf(_:)`.
  private static let p = 0.3275911
  
  /// Coefficients used to compute the approximation of `erf(_:)`.
  private static let coefficients = [0.254829592, -0.284496736, 1.421413741, -1.453152027, 1.061405429]
  
  /// Exponents used to compute the approximation of `erf(_:)`.
  private static let exponents = (1 ... coefficients.count).map(Double.init)
  
  /// Approximates the Gauss Error Function for real numbers according to Abramovitz and Stegrun's work.
  /// - parameter z: The parameter for which to approximate the error function.
  /// - returns: A sample from the distribution.
  public static func erf(_ z: Double) -> Double {
    let sign = (z.sign == .plus) ? 1.0 : -1.0
    let absZ = abs(z)
    let t = 1 / (1 + p * absZ)
    
    let powerSeries = zip(coefficients, exponents)
      .reduce(into: 0.0) { (result, zipped) in
        let (coefficient, exponent) = zipped
        result += coefficient * pow(t, exponent)
      }
    return sign * (1 - powerSeries * exp(-pow(absZ, 2)))
  }
}
