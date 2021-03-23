#if os(Linux)
import Glibc
#else
import Darwin
#endif

/// Computes the Beta function.
/// - parameter alpha: The first argument.
/// - parameter beta: The second argument.
/// - parameter log: Whether to return the natural log of the function.
///
/// The Beta function only supports positive numbers `alpha` and `beta`.
@inlinable
public func betaFunction<RealType: BinaryFloatingPoint>(
  alpha: RealType,
  beta: RealType,
  log: Bool = false
) -> RealType {
  
  precondition(0 < alpha && 0 < beta, "The beta function is only defined for positive real numbers.")
  let maximum = Double(Swift.max(alpha, beta))
  let minimum = Double(Swift.min(alpha, beta))
  
  let logMinTerm = gammaFunction(x: minimum, log: true)
  let logMaxTerm = gammaFunction(x: maximum, log: true)
  let logSumTerm = gammaFunction(x: minimum + maximum, log: true)
  let logBeta = logMaxTerm + logMinTerm - logSumTerm
  
  return RealType(log ? logBeta : exp(logBeta))
}
