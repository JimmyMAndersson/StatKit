/// Ranks the specified variable according to the Fractional Ranking strategy.
/// - parameter sequence: The sequence under investigation.
/// - parameter variable: The variable to investigate.
/// - parameter order: The order by which the variables should be ranked.
/// - parameter lhs: The left hand element.
/// - parameter rhs: The right hand element.
/// - parameter strategy: The calculation method to use.
/// - returns: An array with the rank of each original element,
/// where the index of a rank corresponds to the index of the element in the original array.
/// The time complexity of this method is O(n).
public func rank<S: Sequence, T: Comparable & Hashable>(
  _ sequence: S,
  variable: KeyPath<S.Element, T>,
  by order: @escaping (_ lhs: T, _ rhs: T) -> Bool,
  strategy: RankingStrategy
) -> [Double] {
  return strategy.ranker.rank(variable, in: sequence, by: order)
}
