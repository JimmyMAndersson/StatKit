/// An internal protocol defining the methods required by a ranking strategy types.
@usableFromInline
protocol RankingStrategyProtocol {
  /// Ranks a sequence of variables according to the specified order and strategy.
  /// - parameter X: The variable under investigation.
  /// - parameter sequence: The sequence containing the measurements.
  /// - parameter order: The order by which the variables should be ranked.
  /// - parameter lhs: The left hand element.
  /// - parameter rhs: The right hand element.
  /// - parameter strategy: The calculation method to use.
  /// - returns: An array with the rank of each original element,
  /// where the index of a rank corresponds to the index of the element in the original array.
  func rank<T, S>(
    _ X: KeyPath<S.Element, T>,
    in sequence: S,
    by order: (_ lhs: T, _ rhs: T) -> Bool) -> [Double]
    where T: Comparable & Hashable, S: Sequence
}

/// A calculation strategy for ranking comparable variables.
public enum RankingStrategy: CaseIterable, Sendable {
  /// Tied elements receive the average of the ranks they would otherwise occupy.
  ///
  /// For example, two elements tied for 2nd place both receive rank 2.5, and the next element receives rank 4.
  case fractional

  /// Tied elements share the lowest rank in their group, and the next rank skips over the tie count.
  ///
  /// For example, two elements tied for 2nd place both receive rank 2, and the next element receives rank 4.
  case standardCompetition

  /// Tied elements share the highest rank in their group.
  ///
  /// For example, two elements tied for 2nd place both receive rank 3, and the next element receives rank 4.
  case modifiedCompetition

  /// Tied elements are assigned consecutive ranks based on their order in the collection, with no averaging.
  ///
  /// For example, two elements tied for 2nd place receive ranks 2 and 3 respectively,
  /// and the next element receives rank 4.
  case ordinal

  /// Tied elements share the same rank, and the next distinct rank is always incremented by one
  /// regardless of tie count.
  ///
  /// For example, two elements tied for 2nd place both receive rank 2, and the next element receives rank 3.
  case dense
  
  /// A calculator object that can be used to compute the specified rank.
  @usableFromInline
  internal var ranker: RankingStrategyProtocol {
    switch self {
      case .fractional:
        return FractionalRanker()
      case .standardCompetition:
        return StandardCompetitionRanker()
      case .modifiedCompetition:
        return ModifiedCompetitionRanker()
      case .ordinal:
        return OrdinalRanker()
      case .dense:
        return DenseRanker()
    }
  }
}
