import RealModule

/// A protocol outlining the functionality that a continued fraction generator must provide.
internal protocol ContinuedFractionGenerator {
  associatedtype NumericType: Real
  /// A function generating parameters `alpha_n` for iterations in [1, +.infinity].
  func alpha(for iteration: Int) -> NumericType
  /// A function generating parameters `beta_n` for iterations in [1, +.infinity].
  func beta(for iteration: Int) -> NumericType
}

/// Computes an estimate of a continued fraction, using the modified Lentz' algorithm.
/// - parameter generator: A generator for the sequences of alpha's and beta's used in the computation.
/// - returns: An estimate of the provided continued fraction.
internal func continuedFraction<RealType, Generator>(generator: Generator) -> RealType
where RealType: BinaryFloatingPoint,
      Generator: ContinuedFractionGenerator,
      Generator.NumericType == RealType
{
  
  let machineError = RealType.ulpOfOne
  let ulpMultiplier = RealType(10)
  let tiny = RealType.leastNonzeroMagnitude + .leastNonzeroMagnitude.ulp * ulpMultiplier
  
  let a1 = generator.alpha(for: 1)
  let b1 = generator.beta(for: 1)
  let one = RealType(1)
  
  var f = a1 / b1
  var C = a1 / tiny
  var D = one / b1
  var iteration = 2
  var delta = RealType.zero
  
  repeat {
    let an = generator.alpha(for: iteration)
    let bn = generator.beta(for: iteration)
    
    D = D * an + bn
    
    if D == 0 {
      D = tiny
    }
    
    C = bn + an / C
    
    if C == 0 {
      C = tiny
    }
    
    D = 1 / D
    delta = C * D
    f *= delta
    
    iteration += 1
    
  } while abs(delta - one) >= machineError
  
  return f
}
