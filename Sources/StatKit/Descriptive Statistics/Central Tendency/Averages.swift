/// Calculates the selected mean of the selected variable.
/// - parameter collection: The collection under investigation.
/// - parameter variable: The variable over which to calculate the mean.
/// - parameter strategy: The strategy used to compute the mean.
/// - returns: The mean of all items.
/// Since the arithmetic mean has no meaning on an empty set, this method returns a NaN if the collection is empty.
/// The time complexity of this method is O(n).
@inlinable
public func mean<C: Collection, T: ConvertibleToReal>(
  of collection: C,
  variable: KeyPath<C.Element, T>,
  strategy: MeanStrategy = .arithmetic
) -> Double {
  guard !collection.isEmpty else { return .signalingNaN }
  return strategy.compute(for: variable, in: collection)
}

/// Calculates the median of the selected variable.
/// - parameter collection: The collection under investigation.
/// - parameter variable: The variable over which to calculate the median.
/// - parameter strategy: The strategy used to compute the median.
/// - returns: The median of all items.
/// Since the median has no meaning on an empty set, this method returns a NaN if the collection is empty.
/// The time complexity of this method is O(n).
@inlinable
public func median<C: Collection, T: Comparable & ConvertibleToReal>(
  of collection: C,
  variable: KeyPath<C.Element, T>,
  strategy: MedianStrategy = .mean
) -> Double {
  
  guard !collection.isEmpty else {
    return .signalingNaN
  }
  
  return strategy.compute(for: variable, in: collection)
}

/// Finds the mode(s) of the sequence.
/// - parameter sequence: The sequence under investigation.
/// - parameter variable: The variable over which to calculate the mode(s).
/// - returns: A set containing the mode(s) sorted in ascending order.
/// The mode of a sequence is the item that occurs most frequently.
/// A sequence that has a single item that is most occuring is unimodal,
/// as opposed to sequences that have several items that occur equally often and are called multimodal.
/// The time complexity of this method is O(n).
@inlinable
public func mode<S: Sequence, T: Hashable>(
  of sequence: S,
  variable: KeyPath<S.Element, T>
) -> Set<T> {
  
  let dictionary = sequence.reduce(into: [T: Int]()) { result, element in
    result[element[keyPath: variable], default: 0] += 1
  }
  let maximumOccurence = dictionary.values.max() ?? 0
  
  let result = dictionary.compactMap { (key, count) in
    count == maximumOccurence ? key : .none
  }
  
  return Set(result)
}
