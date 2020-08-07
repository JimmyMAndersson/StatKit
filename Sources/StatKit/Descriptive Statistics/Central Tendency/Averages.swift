extension Collection {
  
  /// Calculates the selected mean of the selected variable.
  /// - parameter strategy: The strategy used to compute the mean.
  /// - parameter variable: The variable over which to calculate the mean.
  /// - returns: The mean of all items.
  /// Since the arithmetic mean has no meaning on an empty set, this method returns a NaN if the collection is empty.
  /// The time complexity of this method is O(n).
  @inlinable
  public func mean<T>(
    _ strategy: MeanStrategy = .arithmetic,
    of variable: KeyPath<Element, T>) -> Double
    where T: ConvertibleToReal {
      
      guard !isEmpty else {
        return .nan
      }
      return strategy.compute(for: variable, in: self)
  }
  
  /// Calculates the median of the selected variable.
  /// - parameter variable: The variable over which to calculate the median.
  /// - returns: The median of all items.
  /// Since the median has no meaning on an empty set, this method returns a NaN if the collection is empty.
  /// The time complexity of this method is O(n).
  @inlinable
  public func median<T>(
    _ strategy: MedianStrategy = .mean,
    of variable: KeyPath<Element, T>) -> Double
    where T: Comparable & ConvertibleToReal {
      
      guard !isEmpty else {
        return .nan
      }
      
      return strategy.compute(for: variable, in: self)
  }
}

extension Sequence {
  
  /// Finds the mode(s) of the sequence.
  /// - parameter variable: The variable over which to calculate the mode(s).
  /// - returns: A set containing the mode(s) sorted in ascending order.
  /// The mode of a sequence is the item that occurs most frequently.
  /// A sequence that has a single item that is most occuring is unimodal,
  /// as opposed to sequences that have several items that occur equally often and are called multimodal.
  /// The time complexity of this method is O(n).
  @inlinable
  public func mode<T: Hashable>(of variable: KeyPath<Element, T>) -> Set<T> {
    
    let dictionary = lazy.reduce(into: [T: Int]()) { result, element in
      result[element[keyPath: variable], default: 0] += 1
    }
    let maximumOccurence = dictionary.values.max() ?? 0
    
    let result = dictionary.lazy
      .compactMap { (key, count) in
        count == maximumOccurence ? key : .none
    }
    
    return Set(result)
  }
}
