import RealModule

/// Evaluates the Regularized Incomplete Gamma function.
/// - parameter lower: The lower bound of the integral.
/// - parameter upper: The upper bound of the integral.
/// - parameter alpha: The parameter alpha, also used in the complete Gamma function.
/// - parameter logarithmic: Whether to return the natural logarithm of the function.
/// - returns: An approximation of the Regularized Incomplete Gamma function.
///
/// `lower` and `upper` must be in range [0, +infinity], with `lower <= upper`.
/// `alpha` needs to be a positive real number.
///
/// Inspired by and based on algorithm 1006 by Abergel and Moisan in their paper
/// '**Algorithm 1006: Fast and Accurate Evaluation of a Generalized Incomplete Gamma Function**',
/// *ACM Transactions on Mathematical Software* (2020).
public func regularizedIncompleteGamma<RealType: Real & BinaryFloatingPoint>(
  lower: RealType,
  upper: RealType,
  alpha: RealType,
  logarithmic: Bool = false
) -> RealType {
  
  let logGamma = RealType.logGamma(alpha)
  let (rho, sigma) = incompleteGamma(lower: lower, upper: upper, alpha: alpha)
  
  if logarithmic {
    return .log(rho) + sigma - logGamma
  } else {
    return rho * .exp(sigma - logGamma)
  }
}

/// Evaluates the Incomplete Gamma function.
/// - parameter lower: The lower bound of the integral.
/// - parameter upper: The upper bound of the integral.
/// - parameter alpha: The parameter alpha, also used in the complete Gamma function.
/// - parameter logarithmic: Whether to return the natural logarithm of the function.
/// - returns: An approximation of the Incomplete Gamma function.
///
/// `lower` and `upper` must be in range [0, +infinity], with `lower <= upper`.
/// `alpha` needs to be a positive real number.
///
/// Inspired by and based on algorithm 1006 by Abergel and Moisan in their paper
/// '**Algorithm 1006: Fast and Accurate Evaluation of a Generalized Incomplete Gamma Function**',
/// *ACM Transactions on Mathematical Software* (2020).
public func incompleteGamma<RealType: Real & BinaryFloatingPoint>(
  lower: RealType,
  upper: RealType,
  alpha: RealType,
  logarithmic: Bool = false
) -> RealType {
  let (rho, sigma) = incompleteGamma(lower: lower, upper: upper, alpha: alpha)
  return logarithmic ? .log(rho) + sigma : rho * .exp(sigma)
}

/// Computes the Incomplete Gamma function under a mantissa-exponent representation.
/// - parameter lower: The lower bound of the integral.
/// - parameter upper: The upper bound of the integral.
/// - parameter alpha: The parameter alpha, also used in the complete Gamma function.
/// - returns: Two numbers (rho and sigma) such that `rho * exp(sigma)` gives an
///   approximation of the Incomplete Gamma function.
///
/// `lower` and `upper` must be in range [0, +infinity], with `lower <= upper`.
/// `alpha` needs to be a positive real number.
///
/// Inspired by and based on algorithm 1006 by Abergel and Moisan in their paper
/// '**Algorithm 1006: Fast and Accurate Evaluation of a Generalized Incomplete Gamma Function**',
/// *ACM Transactions on Mathematical Software* (2020).
public func incompleteGamma<RealType: Real & BinaryFloatingPoint>(
  lower: RealType,
  upper: RealType,
  alpha: RealType
) -> (rho: RealType, sigma: RealType) {
  precondition(0 <= lower, "Parameter lower must be a non-negative real number.")
  precondition(lower <= upper, "Parameter lower must be less than or equal to upper.")
  precondition(0 < alpha, "Parameter alpha must be a positive real number.")
  
  guard lower != upper else { return (.zero, -.infinity) }
  
  let mx = G(alpha: alpha, x: lower)
  let my = G(alpha: alpha, x: upper)
  let nx = -lower + alpha * .log(lower)
  let ny = (upper < .infinity) ? -upper + alpha * .log(upper) : -.infinity
  
  let ma, mb, na, nb: RealType
  
  if alpha < lower {
    ma = mx
    na = nx
    mb = my
    nb = ny
  } else if lower <= alpha && alpha < upper {
    ma = 1
    na = .logGamma(alpha)
    nb = Swift.max(nx, ny)
    
    if nb == -.infinity {
      mb = 0
    } else {
      mb = mx * .exp(nx - nb) + my * .exp(ny - nb)
    }
  } else {
    ma = my
    na = ny
    mb = mx
    nb = nx
  }
  
  let rhoDiff = ma - mb * .exp(nb - na)
  let sigmaDiff = na
  let rho: RealType
  let sigma: RealType
  
  if upper < .infinity && rhoDiff / ma < 0.2 {
    rho = -upper + alpha * .log(upper)
    
    let integrand: (RealType) -> RealType = { input in
      let firstFactor = RealType.pow(input, alpha - 1)
      let exponent = -input + upper - alpha * .log(upper)
      let secondFactor = RealType.exp(exponent)
      return firstFactor * secondFactor
    }
    
    let rombergIntegral = RombergIntegral(lower: lower, upper: upper, integrand: integrand)
    sigma = rombergIntegral.evaluate()
  } else {
    rho = rhoDiff
    sigma = sigmaDiff
  }
  
  return (rho, sigma)
}

/// An estimate of the function `G(alpha, x)`.
/// This estimate is used for normalization purposes in the evaluation of the generalized Incomplete Gamma function.
/// - parameter alpha: The Gamma function parameter alpha.
/// - parameter x: The value to which the lower or upper Incomplete Gamma function is being evaluated.
/// - returns: An approximation of the function `G(alpha, x)`.
private func G<RealType: Real & BinaryFloatingPoint>(alpha: RealType, x: RealType) -> RealType {
  precondition(0 <= x, "x must be a non-negative real number.")
  precondition(0 < alpha, "alpha must be a positive real number.")
  
  if x <= alpha {
    let generator = JTContinuedFractionGenerator(p: alpha, x: x)
    return continuedFraction(generator: generator)
  } else {
    let generator = ASContinuedFractionGenerator(p: alpha, x: x)
    return continuedFraction(generator: generator)
  }
}

/// A continued fraction generator for the estimation of the function G when `x <= p` and `0 <= x`, as outlined by
/// by Abergel and Moisan in their paper '**Algorithm 1006: Fast and Accurate Evaluation of a Generalized
/// Incomplete Gamma Function**', *ACM Transactions on Mathematical Software* (2020).
private struct JTContinuedFractionGenerator<RealType: Real & BinaryFloatingPoint>: ContinuedFractionGenerator {
  let p: RealType
  let x: RealType
  
  func alpha(for iteration: Int) -> RealType {
    guard 1 < iteration else { return 1 }
    
    switch iteration.isMultiple(of: 2) {
    case true:
      let n = RealType(iteration) / 2
      return -(p - 1 + n) * x
      
    case false:
      let n = (RealType(iteration) - 1) / 2
      return n * x
    }
  }
  
  func beta(for iteration: Int) -> RealType {
    return p - 1 + RealType(iteration)
  }
}

/// A continued fraction generator for the estimation of the function G when `p < x`, as outlined by
/// by Abergel and Moisan in their paper '**Algorithm 1006: Fast and Accurate Evaluation of a Generalized
/// Incomplete Gamma Function**', *ACM Transactions on Mathematical Software* (2020).
private struct ASContinuedFractionGenerator<RealType: Real & BinaryFloatingPoint>: ContinuedFractionGenerator {
  let p: RealType
  let x: RealType
  
  func alpha(for iteration: Int) -> RealType {
    switch iteration {
    case ...1:
      return 1
      
    default:
      let n = RealType(iteration)
      let firstFactor = -(n - 1)
      let secondFactor = (n - p - 1)
      return firstFactor * secondFactor
    }
  }
  
  func beta(for iteration: Int) -> RealType {
    let n = RealType(iteration)
    return x + 2 * n - 1 - p
  }
}
