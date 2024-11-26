public extension Collection {
  /// Ranks the specified variable according to a specified strategy.
  /// - parameter variable: The variable to investigate.
  /// - parameter order: The order by which the variables should be ranked.
  /// - parameter strategy: The calculation method to use.
  /// - returns: An array with the rank of each original element,
  /// where the index of a rank corresponds to the index of the element in the original array.
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
