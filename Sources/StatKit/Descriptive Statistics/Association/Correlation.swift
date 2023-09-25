public extension Collection {
  /// Calculates the specified correlation coefficient for a collection.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - parameter composition: The composition of the collection.
  /// - parameter method: The calculation method to use.
  /// - returns: The correlation coefficient for the specified variables in the collection.
  ///
  /// Since there is no notion of correlation in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  @inlinable
  func correlation<T, U>(
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>,
    for composition: DataSetComposition,
    method: CorrelationMethod = .pearsonsProductMoment
  ) -> Double
  where T: Comparable & Hashable & ConvertibleToReal,
        U: Comparable & Hashable & ConvertibleToReal
  {
  guard self.count > 1 else { return .signalingNaN }
  return method.calculator.compute(
    for: X,
    and: Y,
    in: self,
    as: composition
  )
  }
}
