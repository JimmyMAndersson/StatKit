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
  let maximum = Swift.max(alpha, beta)
  let minimum = Swift.min(alpha, beta)
  
  let minTerm = gammaFunction(x: minimum, log: log)
  let maxTerm = gammaFunction(x: maximum, log: log)
  let sumTerm = gammaFunction(x: alpha + beta, log: log)
  
  return log ? maxTerm + minTerm - sumTerm : minTerm / (sumTerm / maxTerm)
}
