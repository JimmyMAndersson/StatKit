public extension Collection {
  /// Calculate the mean of the selected variable.
  /// - parameter variable: The variable over which to calculate the mean.
  /// - parameter strategy: The strategy used to compute the mean.
  /// - returns: The mean of all items.
  ///
  /// Since the arithmetic mean has no meaning on an empty set, this method returns a NaN if the collection is empty.
  /// The time complexity of this method is O(n).
  @inlinable
  func mean<T: ConvertibleToReal>(
    variable: KeyPath<Element, T>,
    strategy: MeanStrategy = .arithmetic
  ) -> Double {
    guard !self.isEmpty else { return .signalingNaN }
    return strategy.compute(for: variable, in: self)
  }

  /// Calculate the median of the selected variable.
  /// - parameter variable: The variable over which to calculate the median.
  /// - parameter strategy: The strategy used to compute the median.
  /// - returns: The median of all items.
  ///
  /// Since the median has no meaning on an empty set, this method returns a NaN if the collection is empty.
  /// The time complexity of this method is O(n).
  @inlinable
  func median<T: Comparable & ConvertibleToReal>(
    variable: KeyPath<Element, T>,
    strategy: MedianStrategy = .mean
  ) -> Double {

    guard !self.isEmpty else {
      return .signalingNaN
    }

    return strategy.compute(for: variable, in: self)
  }

  /// Find the mode(s) of the collection.
  /// - parameter variable: The variable over which to calculate the mode(s).
  /// - returns: A set containing the mode(s) sorted in ascending order.
  ///
  /// The mode of a sequence is the item that occurs most frequently.
  /// A collection that has a single item that is most occuring is unimodal,
  /// as opposed to collections that have several items that occur equally often and are called multimodal.
  /// The time complexity of this method is O(n).
  @inlinable
  func mode<T: Hashable>(
    variable: KeyPath<Element, T>
  ) -> Set<T> {

    let dictionary = self.reduce(into: [T: Int]()) { result, element in
      result[element[keyPath: variable], default: 0] += 1
    }
    let maximumOccurence = dictionary.values.max() ?? 0

    let result = dictionary.compactMap { (key, count) in
      count == maximumOccurence ? key : .none
    }

    return Set(result)
  }
}
