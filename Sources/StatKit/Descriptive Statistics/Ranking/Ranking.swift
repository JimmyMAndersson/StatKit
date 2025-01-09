public extension Collection {
  /// Ranks the specified variable according to a specified strategy.
  /// - parameter variable: The variable to investigate.
  /// - parameter order: The order by which the variables should be ranked.
  /// - parameter strategy: The calculation method to use.
  /// - returns: An array with the rank of each original element,
  /// where the index of a rank corresponds to the index of the element in the original array.
  ///
  /// - important: This method triggers a precondition failure if attempting to rank a collection
  /// of instances that do not compare equal to themselves. For example, attempting to rank a collection
  /// of floating point numbers that contain NaN's will fail, since `Double.nan == Double.nan` is false.
  ///
  /// The time complexity of this method is O(n).
  func rank<T: Comparable & Hashable>(
    variable: KeyPath<Element, T>,
    by order: @escaping (_ lhs: T, _ rhs: T) -> Bool,
    strategy: RankingStrategy
  ) -> [Double] {
    return strategy.ranker.rank(variable, in: self, by: order)
  }
}
