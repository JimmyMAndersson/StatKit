/// Computes the Beta function.
/// - parameter alpha: The first argument.
/// - parameter beta: The second argument.
///
/// The Beta function only supports positive numbers `alpha` and `beta`.
@inlinable
public func betaFunction<Integer: BinaryInteger>(alpha: Integer, beta: Integer) -> Double {
  precondition(0 < alpha && 0 < beta, "The beta function is only defined for positive integers.")
  let numerator = Double(gammaFunction(x: alpha) * gammaFunction(x: beta))
  let denominator = Double(gammaFunction(x: alpha + beta))
  return numerator / denominator
}
