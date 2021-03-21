#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Computes Bernoulli's Gamma function.
/// - parameter x: The number for which to compute the Gamma function.
/// - parameter log: Whether to return the natural log of the function.
///
/// The Gamma function only supports positive numbers `x`.
@inlinable
public func gammaFunction<RealType: BinaryFloatingPoint>(
  x: RealType,
  log: Bool = false
) -> RealType {
  
  precondition(0 < x, "The Gamma function is only defined for positive real numbers.")
  let gamma = log ? lgamma(Double(x)) : tgamma(Double(x))
  return RealType(gamma)
}
