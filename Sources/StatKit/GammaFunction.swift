#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Computes Bernoulli's Gamma function.
/// - parameter x: The number for which to compute the Gamma function.
///
/// The Gamma function only supports positive numbers `x`.
@inlinable
public func gammaFunction<Integer: BinaryInteger>(x: Integer) -> Integer {
  precondition(0 < x, "The Gamma function is only defined for positive integers.")
  let gamma = tgamma(Double(x)).rounded()
  return Integer(gamma)
}
