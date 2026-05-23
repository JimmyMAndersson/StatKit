public extension Collection {
  /// Computes the k'th q-quantile of the samples in a collection.
  /// - parameter probability:
  /// The probability with which a random measurement would fall below the given quantile.
  /// This probability can favourably be specified as a rational number, `k / q`, giving the `k`'th `q`-quantile.
  /// Because it is a probability, the number needs to be in range [0, 1].
  /// - parameter variable: The variable under investigation.
  /// - parameter method: The computation method used to estimate the sample quantile.
  ///
  /// Since quantiles have no meaning on empty collections or probabilities outside of range [0, 1],
  /// this method returns a NaN for calls under any such conditions.
  ///
  /// Collections containing NaN values will also produce a NaN result.
  ///
  /// Infinite values are handled correctly as long as the chosen estimation method does not require
  /// arithmetic between conflicting infinities (e.g. `+∞ − ∞`).
  /// If such arithmetic is unavoidable for the requested probability and method, this method returns NaN.
  ///
  /// - important: This method has undefined behavior on collections containing elements that are incomparable
  /// for reasons other than NaN (e.g. custom types with a broken `Comparable` implementation).
  func quantile<T: Comparable & ConvertibleToReal>(
    probability: Double,
    of variable: KeyPath<Element, T>,
    method: QuantileEstimationMethod = .inverseEmpiricalCDF
  ) -> Double {

    guard
      probability.isFinite,
      0 <= probability,
      probability <= 1,
      !self.isEmpty,
      !self.contains(where: { $0[keyPath: variable].realValue.isNaN })
    else { return .signalingNaN }

    let ordered = self.sorted { lhs, rhs in
      lhs[keyPath: variable] < rhs[keyPath: variable]
    }

    if probability == 1 {
      guard let element = ordered.last else {
        fatalError("Could not fetch greatest element of collection.")
      }
      return element[keyPath: variable].realValue
    }

    if probability == 0 {
      guard let element = ordered.first else {
        fatalError("Could not fetch smallest element of collection.")
      }
      return element[keyPath: variable].realValue
    }

    switch method {
      case .inverseEmpiricalCDF:
        let h = Double(ordered.count - 1) * probability
        let index = Int(h.rounded(.up))
        return ordered[index][keyPath: variable].realValue

      case .averagedInverseEmpiricalCDF:
        let h = Double(ordered.count - 1) * probability
        let firstIndex = Int(h.rounded(.down))
        let secondIndex = Int(h.rounded(.up))
        let firstElement = ordered[firstIndex][keyPath: variable]
        let secondElement = ordered[secondIndex][keyPath: variable]
        return (firstElement.realValue + secondElement.realValue) / 2

      case .closest:
        let h = Double(ordered.count - 1) * probability
        let index = Int(h.rounded(.toNearestOrEven))
        return ordered[index][keyPath: variable].realValue

      case .lerpInverseEmpiricalCDF:
        let h = Double(ordered.count - 1) * probability
        let firstIndex = Int(h.rounded(.down))
        let secondIndex = Int(h.rounded(.up))
        let firstElement = ordered[firstIndex][keyPath: variable]
        let secondElement = ordered[secondIndex][keyPath: variable]
        let difference = secondElement - firstElement
        let lerpRatio = h - h.rounded(.down)
        return firstElement.realValue + difference.realValue * lerpRatio
    }
  }
}

/// A method for computing quantiles.
public enum QuantileEstimationMethod: CaseIterable, Sendable {
  /// Computes the quantile usign the inverse empirical CDF.
  case inverseEmpiricalCDF
  /// Computes the quantile usign the inverse empirical CDF, and takes the arithmetic mean at discontinuities.
  case averagedInverseEmpiricalCDF
  /// Computes the quantile by rounding to the closest observation.
  ///
  /// In case of a tie, the even index element will be chosen.
  case closest
  /// Computes the quantile usign the inverse empirical CDF, and linearly interpolates at discontinuities.
  case lerpInverseEmpiricalCDF
}
