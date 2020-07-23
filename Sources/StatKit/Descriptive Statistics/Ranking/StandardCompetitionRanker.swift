/// A helper object for calculating the Standard Competition Rank of a sequence.
internal struct StandardCompetitionRanker: RankingStrategyProtocol {
  func rank<T, S>(_ X: KeyPath<S.Element, T>,
                  in sequence: S,
                  by order: (_ lhs: T, _ rhs: T) -> Bool) -> [Double]
    where T: Comparable, T: Hashable, S: Sequence {
      
      let ranks = sequence.lazy.map { element in element[keyPath: X] }
        .sorted(by: order)
        .enumerated()
        .reduce(into: [T: Double]()) { (result, enumeration) in
          let rank = enumeration.offset + 1
          let element = enumeration.element
          
          let currentRank = result[element, default: .infinity]
          result[element] = Swift.min(rank.realValue, currentRank)
      }
      
      return sequence.map { element in
        let key = element[keyPath: X]
        guard let rank = ranks[key] else {
          fatalError("Could not calculate Standard Competition ranking. Some ranks were missing")
        }
        return rank
      }
  }
}
