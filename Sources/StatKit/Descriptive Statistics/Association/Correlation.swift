import RealModule

public extension Collection {
  /// Calculates Pearsons correlation coefficient for a collection.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - returns: Pearsons correlation coefficient.
  ///
  /// Since there is no notion of correlation in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  @inlinable
  func pearsonR<T, U>(
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>
  ) -> Double
  where T: Comparable & Hashable & ConvertibleToReal,
        U: Comparable & Hashable & ConvertibleToReal
  {
  typealias RComponents = (xSum: Double, ySum: Double, xySum: Double, xSquareSum: Double, ySquareSum: Double)
  guard self.count > 1 else { return .signalingNaN }

  guard X != Y else { return 1 }

  let n = self.count.realValue

  let rComponents: RComponents = self.reduce(into: (0, 0, 0, 0, 0)) { partialResult, element in
    let x = element[keyPath: X].realValue
    let y = element[keyPath: Y].realValue

    partialResult.xSum += x
    partialResult.ySum += y
    partialResult.xySum += x * y
    partialResult.xSquareSum += x * x
    partialResult.ySquareSum += y * y
  }

  let numerator = n * rComponents.xySum - rComponents.xSum * rComponents.ySum
  let denominator = (
    (n * rComponents.xSquareSum - rComponents.xSum * rComponents.xSum) *
    (n * rComponents.ySquareSum - rComponents.ySum * rComponents.ySum)
  ).squareRoot()

  guard denominator != 0 else { return .signalingNaN }

  return numerator / denominator
  }

  /// Calculates Spearmans rank-order correlction coefficient for a collection.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - returns: Spearmans rank-order correlation coefficient.
  ///
  /// Since there is no notion of correlation in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  @inlinable
  func spearmanR<T, U>(
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>
  ) -> Double
  where T: Comparable & Hashable & ConvertibleToReal,
        U: Comparable & Hashable & ConvertibleToReal
  {
  guard X != Y else { return 1 }

  let XRanks = self.rank(
    variable: X,
    by: >,
    strategy: .fractional
  )
  let YRanks = self.rank(
    variable: Y,
    by: >,
    strategy: .fractional
  )
  let ranks: [(X: Double, Y: Double)] = Array(zip(XRanks, YRanks))

  return ranks.pearsonR(of: \.X, and: \.Y)
  }

  /// Calculates Kendalls rank correlction coefficient for a collection.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - parameter variant: Which variant of the Tau coefficient to compute.
  /// - returns: Kendalls rank correlation coefficient.
  ///
  /// Since there is no notion of correlation in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  func kendallTau<T, U>(
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>,
    variant: KendallTauVariant = .b
  ) -> Double
  where T: Comparable & Hashable & ConvertibleToReal,
        U: Comparable & Hashable & ConvertibleToReal
  {
  guard X != Y else { return 1 }

  let tiesX = self.countTieRanks(of: X)
  let tiesY = self.countTieRanks(of: Y)

  let count = self.count
  let discordant = self.discordantPairs(of: X, and: Y)
  let combinations = count * (count - 1) / 2
  let concordant = combinations - discordant - tiesX - tiesY

  switch variant {
    case .a:
      let numerator = (concordant - discordant).realValue
      let denominator = combinations.realValue
      return numerator / denominator
    case .b:
      let numerator = (concordant - discordant).realValue
      let tieProduct = (combinations - tiesX) * (combinations - tiesY)
      let denominator = tieProduct.realValue.squareRoot()
      guard !denominator.isZero else { return .signalingNaN }

      return numerator / denominator
  }
  }
}

/// The different supported variants of the Kendall Tau coefficient.
public enum KendallTauVariant {
  /// The original Tau statistic defined in 1938.
  /// Tau-a does not make adjustments for rank ties.
  case a

  /// The Tau-b statistic (originally named Tau-w) is an extension of Tau-a which makes adjustments for tie rank pairs.
  case b
}

private extension Collection {
  /// Counts the number of tied variables within a collection of measurements.
  /// - parameter X : The variable under investigation.
  /// - returns: The number of tied measurements.
  func countTieRanks<T: Hashable>(of X: KeyPath<Element, T>) -> Int {

    let elementCount = reduce(into: [T: Int]()) { dictionary, element in
      let x = element[keyPath: X]
      dictionary[x, default: 0] += 1
    }

    return elementCount.values.reduce(into: 0) { tiesX, count in
      guard count > 1 else { return }

      tiesX += count * (count - 1) / 2
    }
  }

  /// Counts the number of discordant pairs inside a collection.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - returns: The number of discordant pairs contained in the collection.
  func discordantPairs<T: Comparable, U: Comparable>(
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Self.Element, U>
  ) -> Int {

    var sortedCopy = self.sorted { lhs, rhs in
      if lhs[keyPath: X] == rhs[keyPath: X] {
        return lhs[keyPath: Y] < rhs[keyPath: Y]
      } else {
        return lhs[keyPath: X] < rhs[keyPath: X]
      }
    }
    return sortedCopy[...].computeDiscordance(sorting: Y)
  }
}

private extension ArraySlice {
  /// Sorts the measurements and counts the number of discordant pairs contained in it.
  /// - parameter X: The first variable under investigation.
  /// - parameter Y: The second variable under investigation.
  /// - returns: The number of discordant pairs found in the collection.
  ///
  /// This method assumes that the collection is sorted, in ascending order,
  /// by the variable that acts as the basis of discordance measurements against `Y`.
  mutating func computeDiscordance<T: Comparable>(
    sorting Y: KeyPath<Element, T>
  ) -> Int {

    if count < 2 {
      return 0
    } else {
      let midPoint = (endIndex + startIndex) / 2

      var discordants = self[startIndex ..< midPoint].computeDiscordance(sorting: Y)
      discordants += self[midPoint ..< endIndex].computeDiscordance(sorting: Y)

      return discordants + self.countDiscordantPairs(sorting: Y)
    }
  }

  /// Sorts the collection and counts the number of discordant pairs.
  /// - parameter Y: The variable to sort by.
  /// - returns: The number of discordant pairs found in the collection.
  private mutating func countDiscordantPairs<T: Comparable>(
    sorting Y: KeyPath<Self.Element, T>
  ) -> Int {

    let pivot = (startIndex + endIndex) / 2
    var sorted = self
    var discordant = 0
    var mergeIndex = startIndex
    var lhsIndex = startIndex
    var rhsIndex = pivot

    while lhsIndex < pivot && rhsIndex < endIndex {

      if self[lhsIndex][keyPath: Y] <= self[rhsIndex][keyPath: Y] {
        discordant += Swift.max(0, mergeIndex - lhsIndex)
        sorted[mergeIndex] = self[lhsIndex]
        lhsIndex += 1
      } else {
        discordant += Swift.max(0, mergeIndex - rhsIndex)
        sorted[mergeIndex] = self[rhsIndex]
        rhsIndex += 1
      }

      mergeIndex += 1
    }

    for index in lhsIndex ..< pivot {
      discordant += Swift.max(0, mergeIndex - index)
      sorted[mergeIndex] = self[index]
      mergeIndex += 1
    }

    for index in rhsIndex ..< endIndex {
      discordant += Swift.max(0, mergeIndex - index)
      sorted[mergeIndex] = self[index]
      mergeIndex += 1
    }

    for index in startIndex ..< endIndex {
      self[index] = sorted[index]
    }

    return discordant
  }
}
