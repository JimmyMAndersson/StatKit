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
  func rank<T, S>(_ X: KeyPath<S.Element, T>,
                  in sequence: S,
                  by order: (_ lhs: T, _ rhs: T) -> Bool) -> [Double]
    where T: Comparable & Hashable, S: Sequence
}

public enum RankingStrategy {
  /// The Fractional ranking strategy.
  case fractional
  /// The Standard Competition ranking strategy.
  case standardCompetition
  /// The Modified Competition ranking strategy.
  case modifiedCompetition
  /// The Ordinal ranking strategy.
  case ordinal
  /// The Dense ranking strategy.
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
