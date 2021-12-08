/// Computes the k'th q-quantile of the samples in a collection.
/// - parameter collection: The collection of which to compute the quantile.
/// - parameter probability:
/// The probability with which a random measurement would fall below the given quantile.
/// This probability can favourably be specified as a rational number, `k / q`, giving the `k`'th `q`-quantile.
/// Because it is a probability, the number needs to be in range [0, 1].
/// - parameter variable: The variable under investigation.
/// - parameter method: The computation method used to estimate the sample quantile.
///
/// The time complexity of this method is O(n * log(n)).
/// Since quantiles have no meaning on empty collections or probabilities outside of range [0, 1],
/// this method returns a NaN for calls under any such conditions.
public func quantile<C: Sequence, T: Comparable & ConvertibleToReal>(
  _ collection: C,
  probability: Double,
  of variable: KeyPath<C.Element, T>,
  method: QuantileEstimationMethod = .inverseEmpiricalCDF) -> Double {
    
    guard
      probability.isFinite,
      0 <= probability,
      probability <= 1
    else { return .signalingNaN }
    
    let ordered = collection.sorted { lhs, rhs in
      lhs[keyPath: variable] < rhs[keyPath: variable]
    }
    
    guard !ordered.isEmpty else { return .signalingNaN }
    
    if probability == 1 {
      guard let element = ordered.last else {
        fatalError("Could not fetch last element of Sequence.")
      }
      return element[keyPath: variable].realValue
    }
    
    if probability == 0 {
      guard let element = ordered.first else {
        fatalError("Could not fetch first element of Sequence.")
      }
      return element[keyPath: variable].realValue
    }
    
    switch method {
      case .inverseEmpiricalCDF:
        let h = Double(ordered.count) * probability + 0.5
        let index = Int((h - 0.5).rounded(.up)) - 1
        return ordered[index][keyPath: variable].realValue
        
      case .averagedInverseEmpiricalCDF:
        let h = Double(ordered.count) * probability + 0.5
        let firstIndex = Int((h - 0.5).rounded(.up)) - 1
        let secondIndex = Int((h + 0.5).rounded(.down)) - 1
        return mean(of: ordered[firstIndex...secondIndex], variable: variable)
        
      case .closestOrOddIndexed:
        let h = Double(ordered.count) * probability
        let index = Int(h.rounded(.toNearestOrEven)) - 1
        return ordered[index][keyPath: variable].realValue
        
      case .lerpInverseEmpiricalCDF:
        let h = Double(ordered.count) * probability
        let firstIndex = Int(h.rounded(.down)) - 1
        let secondIndex = Int(h.rounded(.up)) - 1
        let firstElement = ordered[firstIndex][keyPath: variable].realValue
        let secondElement = ordered[secondIndex][keyPath: variable].realValue
        let difference = secondElement - firstElement
        let lerpRatio = h - h.rounded(.down)
        return firstElement + difference * lerpRatio
    }
  }

/// A method for computing quantiles.
public enum QuantileEstimationMethod {
  /// Computes the quantile usign the inverse empirical CDF.
  case inverseEmpiricalCDF
  /// Computes the quantile usign the inverse empirical CDF, and takes the arithmetic mean at discontinuities.
  case averagedInverseEmpiricalCDF
  /// Computes the quantile by rounding to the closest observation.
  ///
  /// In case of a tie, the odd index element will be chosen.
  case closestOrOddIndexed
  /// Computes the quantile usign the inverse empirical CDF, and linearly interpolates at discontinuities.
  case lerpInverseEmpiricalCDF
}
