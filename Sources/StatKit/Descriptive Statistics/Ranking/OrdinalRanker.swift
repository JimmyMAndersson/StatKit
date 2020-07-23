/// A helper object for calculating the Ordinal Rank of a sequence.
internal struct OrdinalRanker: RankingStrategyProtocol {
  func rank<T, S>(_ X: KeyPath<S.Element, T>,
                  in sequence: S,
                  by order: (_ lhs: T, _ rhs: T) -> Bool) -> [Double]
    where T: Comparable, T: Hashable, S: Sequence {
      
      var ranks = sequence.lazy
        .map { element in element[keyPath: X] }
        .sorted(by: order)
        .enumerated()
        .reduce(into: [T: [Double]]()) { (result, enumeration) in
          let rank = Double(enumeration.offset + 1)
          let element = enumeration.element
          
          result[element, default: [Double]()].append(rank)
      }
      
      return sequence
        .reversed()
        .map { element in
          let key = element[keyPath: X]
          guard let rank = ranks[key]?.removeLast() else {
            fatalError("Could not calculate Ordinal ranking. Some ranks were missing")
          }
          return rank
      }.reversed()
  }
}
