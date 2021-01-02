/// A helper object for calculating the Dense Rank of a sequence.
internal struct DenseRanker: RankingStrategyProtocol {
  func rank<T, S>(_ X: KeyPath<S.Element, T>,
                  in sequence: S,
                  by order: (_ lhs: T, _ rhs: T) -> Bool) -> [Double]
  where T: Comparable, T: Hashable, S: Sequence {
    
    var rank: Double = .zero
    let ranks = sequence.lazy
      .map { element in element[keyPath: X] }
      .sorted(by: order)
      .reduce(into: [T: Double]()) { (result, element) in
        if !result.keys.contains(element) {
          rank += 1
          result[element] = rank
        }
      }
    
    return sequence
      .map { element in
        let key = element[keyPath: X]
        guard let rank = ranks[key] else {
          fatalError("Could not calculate Ordinal ranking. Some ranks were missing")
        }
        return rank
      }
  }
}
