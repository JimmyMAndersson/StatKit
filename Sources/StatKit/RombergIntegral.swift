import RealModule

/// A container type holding the necessary information to approximate
/// some definite integral `∫ f(x) dx` using Romberg's method.
internal struct RombergIntegral<RealType: Real & BinaryFloatingPoint> {
  /// The minimum range value of the integral.
  let lower: RealType
  /// The maximum range value of the integral.
  let upper: RealType
  /// A scaling factor determining an error tolerance in terms of the machine error.
  let tolerance: RealType
  /// The integrand function `f(x)`.
  let integrand: (RealType) -> RealType
  
  /// Creates an instance of a RombergIntegral, containing information to approximate a definite integral.
  /// - parameter lower: The minimum range value of the integral.
  /// - parameter upper: The maximum range value of the integral.
  /// - parameter tolerance: The error tolerance specified as a scaling factor of the machine error.
  ///   The default value is 10.
  /// - parameter integrand: The integrand function.
  init(lower: RealType, upper: RealType, tolerance: RealType = 10, integrand: @escaping (RealType) -> RealType) {
    self.lower = lower
    self.upper = upper
    self.tolerance = tolerance
    self.integrand = integrand
  }
  
  /// Approximates the specified integral.
  /// - returns: The estimated value of the integral `∫ f(x) dx`.
  func evaluate() -> RealType {
    var resultCache = [RombergsMethodInput: RealType]()
    let maxN = 12
    let machineError = RealType.ulpOfOne
    
    let firstFactor = h(n: 1, a: lower, b: upper)
    let secondFactor = integrand(lower) + integrand(upper)
    resultCache[.init(n: 0, m: 0)] = firstFactor * secondFactor
    
    for n in 1 ... maxN {
      guard let previousStartResult = resultCache[.init(n: n - 1, m: .zero)] else {
        preconditionFailure(
          "Failed to perform evaluation. Could not find initial result of last iteration."
        )
      }
      
      let firstTerm = 0.5 * previousStartResult
      let hn = h(n: n, a: lower, b: upper)
      
      let upper = Int(Double.pow(2, n - 1))
      let summationRange = (1 ... upper).lazy
      
      let summation = summationRange
        .map { iteration -> RealType in
          let term = (2 * RealType(iteration) - 1)
          return integrand(lower + term * hn)
        }
        .reduce(into: .zero, +=)
      
      let initialResult = firstTerm + hn * summation
      resultCache[.init(n: n, m: .zero)] = initialResult
      
      var lastResult = initialResult
      var secondToLastResult = initialResult
      
      for m in 1 ... n {
        guard let previousResult = resultCache[.init(n: n, m: m - 1)] else {
          preconditionFailure("Failed to perform evaluation. Could not find previous result of current iteration.")
        }
        
        guard let previousIterationResult = resultCache[.init(n: n - 1, m: m - 1)] else {
          preconditionFailure("Failed to perform evaluation. Could not find previous result of last iteration.")
        }
        
        let difference = previousResult - previousIterationResult
        let scaledDifference = difference / (.pow(4, m) - 1)
        let result = previousResult + scaledDifference
        resultCache[.init(n: n, m: m)] = result
        
        secondToLastResult = lastResult
        lastResult = result
      }
      
      if abs(lastResult - secondToLastResult) / lastResult <= tolerance * machineError {
        return lastResult
      }
    }
    
    guard let fallbackResult = resultCache[.init(n: maxN, m: maxN)] else {
      preconditionFailure("Failed to perform evaluation. Could not find result of final iteration.")
    }
    
    return fallbackResult
  }
  
  private func h(n: Int, a: RealType, b: RealType) -> RealType {
    return (b - a) / .pow(2, n)
  }
}

internal struct RombergsMethodInput: Hashable, Equatable {
  let n: Int
  let m: Int
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(n)
    hasher.combine(m)
  }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.n == rhs.n && lhs.m == rhs.m
  }
}
