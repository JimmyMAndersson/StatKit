public extension Collection {
  /// Calculates the sum of all contained elements.
  /// - parameter variable: The variable over which to calculate the sum.
  /// - returns: The sum of the variable in the collection.
  ///
  /// The time complexity of this method is O(n).
  @inlinable
  func sum<T: AdditiveArithmetic>(
    over variable: KeyPath<Element, T>
  ) -> T {
    self.reduce(into: .zero) { result, element in
      result += element[keyPath: variable]
    }
  }
}
