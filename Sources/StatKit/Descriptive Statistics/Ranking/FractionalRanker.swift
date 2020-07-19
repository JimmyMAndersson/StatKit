/// A helper object for calculating the Fractional Rank of a sequence.
internal struct FractionalRanker: RankingStrategyProtocol {
  func rank<T, S>(_ X: KeyPath<S.Element, T>,
                  in sequence: S,
                  by order: (T, T) -> Bool) -> [Double]
    where T: Comparable, T: Hashable, S: Sequence {
      
      let ranks = sequence.lazy.map { element in element[keyPath: X] }
        .sorted(by: order)
        .enumerated()
        .reduce(into: [T: (rankSum: Int, occurences: Int)]()) { (result, enumeration) in
          let rankSum = enumeration.offset + 1
          let element = enumeration.element
          
          var elementInfo = result[element, default: (0, 0)]
          elementInfo.occurences += 1
          elementInfo.rankSum += rankSum
          result[element] = elementInfo
      }
      
      return sequence.map { element in
        guard
          let rankSum = ranks[element[keyPath: X]]?.rankSum,
          let occurences = ranks[element[keyPath: X]]?.occurences
          else { fatalError("Could not calculate Spearman's Rho coefficient. Some ranks were missing")}
        
        return rankSum.realValue / occurences.realValue
      }
  }
}
