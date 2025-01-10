public extension Collection {
  /// Calculates the sum of all contained elements.
  /// - parameter variable: The variable over which to calculate the sum.
  /// - returns: The sum of the variable in the collection.
  ///
  /// - complexity: O(n), where n is the length of the collection.
  @inlinable
  func sum<T: AdditiveArithmetic>(
    over variable: KeyPath<Element, T>
  ) -> T {
    self.reduce(into: .zero) { result, element in
      result += element[keyPath: variable]
    }
  }
}
