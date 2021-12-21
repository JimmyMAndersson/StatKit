import RealModule

/// Computes the complete Beta function.
/// - parameter alpha: The first shape argument.
/// - parameter beta: The second shape argument.
/// - parameter logarithmic: Whether to return the natural logarithm of the function.
///
/// The Beta function only supports positive numbers `alpha` and `beta`.
@inlinable
public func beta<RealType: Real & BinaryFloatingPoint>(
  alpha: RealType,
  beta: RealType,
  logarithmic: Bool = false
) -> RealType {
  
  precondition(0 < alpha, "Parameter alpha needs to be a positive real number.")
  precondition(0 < beta, "Parameter beta needs to be a positive real number.")
  
  let maximum = Swift.max(alpha, beta)
  let minimum = Swift.min(alpha, beta)
  
  let logMinTerm = RealType.logGamma(minimum)
  let logMaxTerm = RealType.logGamma(maximum)
  let logSumTerm = RealType.logGamma(minimum + maximum)
  let logBeta = logMaxTerm + logMinTerm - logSumTerm
  
  return logarithmic ? logBeta : .exp(logBeta)
}

/// The Incomplete Beta function.
/// - parameter x: The value for which to evaluate the incomplete Beta function.
/// - parameter alpha: The first shape argument.
/// - parameter beta: The second shape argument.
/// - parameter logarithmic: Whether to return the natural logarithm of the function.
///
/// The Beta function only supports positive numbers `alpha` and `beta`.
/// `x` is a value in the range [0, 1].
@inlinable
public func regularizedIncompleteBeta<RealType: Real & BinaryFloatingPoint>(
  x: RealType,
  alpha: RealType,
  beta: RealType
) -> RealType {
  
  precondition(0 < alpha, "Parameter alpha needs to be a positive real number.")
  precondition(0 < beta, "Parameter beta needs to be a positive real number.")
  precondition(0 < x && x < 1, "Parameter x needs to be in the range (0, 1).")
  
  let numerator = alpha * .log(x) + beta * .log(1 - x)
  let denominator = StatKit.beta(alpha: alpha, beta: beta, logarithmic: true)
  let scalar = RealType.exp(numerator - denominator)
  
  if x < alpha / (alpha + beta) {
    return scalar * incompleteBetaContinuedFraction(x: x, alpha: alpha, beta: beta)
  } else {
    return 1 - scalar * incompleteBetaContinuedFraction(x: 1 - x, alpha: beta, beta: alpha)
  }
}

/// Evaluates a continued fraction for the Incomplete Beta function by the modified Lentz's algorithm.
/// - parameter x: The value for which to evaluate the incomplete Beta function.
/// - parameter alpha: The first shape argument.
/// - parameter beta: The second shape argument.
///
/// `alpha` and `beta` need to be positive real numbers.
/// `x` is a real valued number in the range [0, 1].
/// Inspired by and based upon the TOMS708 algorithm by Didonato and Morris in their paper
/// '**Algorithm 708: Significant digit computation of the incomplete beta function ratios**',
/// *ACM Transactions on Mathematical Software* (1992).
@usableFromInline
internal func incompleteBetaContinuedFraction<RealType: Real & BinaryFloatingPoint>(
  x: RealType,
  alpha: RealType,
  beta: RealType
) -> RealType {
  
  if x == 0 || x == 1 {
    return 0
  }
  
  let maxIterations = 50
  let epsilon = RealType(1e-30)
  
  let lambda = alpha - (alpha + beta) * x
  
  let c = 1 + lambda
  let c0 = beta / alpha
  let c1 = 1 + 1 / alpha
  
  var p = RealType(1)
  var s = alpha + 1
  var aN = RealType(0)
  var bN = RealType(1)
  var aNPlus1 = RealType(1)
  var bNPlus1 = c / c1
  var estimate = c1 / c
  
  for iteration in 1 ... maxIterations {
    let n = RealType(iteration)
    let e = alpha / s
    let t = (n * (beta - n) * x)
    let a = p * (p + c0) * .pow(e, 2) * t * x
    let fNumerator = (1 + n / alpha)
    let fDenominator = (c1 + 2 * n / alpha)
    let f = fNumerator / fDenominator
    let b = n + t / s + f * (c + n * (2 - x))
    p = 1 + n / alpha
    s += 2
    
    let tmpANPlus1 = a * aN + b * aNPlus1
    aN = aNPlus1
    aNPlus1 = tmpANPlus1
    
    let tmpBNPlus1 = a * bN + b * bNPlus1
    bN = bNPlus1
    bNPlus1 = tmpBNPlus1
    
    let oldEstimate = estimate
    estimate = aNPlus1 / bNPlus1
    
    if abs(estimate - oldEstimate) <= epsilon * estimate { break }
    
    aN /= bNPlus1
    bN /= bNPlus1
    aNPlus1 = estimate
    bNPlus1 = 1
  }
  
  return estimate
}
