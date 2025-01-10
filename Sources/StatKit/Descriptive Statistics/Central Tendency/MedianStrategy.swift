/// Determines which value to pick in cases where the number of elements in a collection are even.
public enum MedianStrategy {
  /// Returns the higher of the two middle values if there is an even number of elements in the collection.
  case high
  /// Returns the lower of the two middle values if there is an even number of elements in the collection.
  case low
  /// Returns the arithmetic mean of the two middle values if there is an even number of elements in the collection.
  case mean
}

extension MedianStrategy {
  /// Computes the specified median value of a collection.
  /// - parameter variable: The random variable for which to calculate the mean.
  /// - parameter collection: The collection of values.
  /// - returns: The specified mean value.
  ///
  /// - complexity: O(n log n), where n is the length of the collection.
  @usableFromInline
  internal func compute<T, C>(
    for variable: KeyPath<C.Element, T>,
    in collection: C) -> Double
    where
    T: Comparable & ConvertibleToReal,
    C: Collection {
      
      let isEvenNumberOfElements = collection.count.isMultiple(of: 2)
      let sortedElements = collection.sorted(by: { lhs, rhs in
        lhs[keyPath: variable] < rhs[keyPath: variable]
      })

      let midPoint = (collection.count - 1) / 2
      
      switch (self, isEvenNumberOfElements) {
        case (.mean, true):
          let firstValue = sortedElements[midPoint][keyPath: variable].realValue
          let secondValue = sortedElements[midPoint + 1][keyPath: variable].realValue
          return (firstValue + secondValue) / 2
        
        case (.high, true):
          return sortedElements[midPoint + 1][keyPath: variable].realValue
        
        default:
          return sortedElements[midPoint][keyPath: variable].realValue
      }
  }
}
