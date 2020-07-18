extension Sequence {
  /// Ranks the specified variable according to the Fractional Ranking strategy.
  /// - parameter X: The variable to investigate.
  /// - parameter order: The order by which the variables should be ranked.
  /// - parameter lhs: The left hand element.
  /// - parameter rhs: The right hand element.
  /// - returns: An array with the rank of each original element,
  /// where the index of a rank corresponds to the index of the element in the original array.
  /// The time complexity of this method is O(n).
  public func rank<T>(
    _ X: KeyPath<Element, T>,
    by order: @escaping (_ lhs: T, _ rhs: T) -> Bool) -> [Double]
    where T: Comparable & Hashable {
      
      let ranks = lazy.map { element in element[keyPath: X] }
        .sorted(by: order)
        .enumerated()
        .reduce(into: [T: (rankSum: Int, occurences: Int)]()) { (result, enumeration) in
          let rankSum = enumeration.offset + 1
          let element = enumeration.element
          
          result[element, default: (0, 0)].occurences += 1
          result[element, default: (0, 0)].rankSum += rankSum
      }
      
      return map { element in
        guard
          let rankSum = ranks[element[keyPath: X]]?.rankSum,
          let occurences = ranks[element[keyPath: X]]?.occurences
          else { fatalError("Could not calculate Spearman's Rho coefficient. Some ranks we're missing")}
        
        return rankSum.realValue / occurences.realValue
      }
  }
}
