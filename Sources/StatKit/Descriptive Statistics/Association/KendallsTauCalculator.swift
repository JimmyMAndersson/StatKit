import RealModule

/// A helper object for calculating Kendall's Tau Coefficient.
internal struct KendallsTauCalculator: CorrelationCalculator {
  internal func compute<
    T: Comparable & Hashable & ConvertibleToReal,
    U: Comparable & Hashable & ConvertibleToReal,
    C: Collection
  >(
    for X: KeyPath<C.Element, T>,
    and Y: KeyPath<C.Element, U>,
    in collection: C,
    as composition: DataSetComposition
  ) -> Double {
    
    guard X != Y else { return 1 }
    
    let tiesX = collection.countTieRanks(of: X)
    let tiesY = collection.countTieRanks(of: Y)
    
    let count = collection.count
    let discordant = collection.discordantPairs(of: X, and: Y)
    let combinations = count * (count - 1) / 2
    let concordant = combinations - discordant - tiesX - tiesY
    
    switch composition {
      case .population:
        return (concordant - discordant).realValue / combinations.realValue
      case .sample:
        let numerator = (concordant - discordant).realValue
        let tieProduct = (combinations - tiesX) * (combinations - tiesY)
        let denominator = tieProduct.realValue.squareRoot()
        guard !denominator.isZero else { return .signalingNaN }
        
        return numerator / denominator
    }
  }
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
