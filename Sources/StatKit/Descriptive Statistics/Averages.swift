extension Collection where Element: ConvertibleToDouble {
  /**
   Calculates the arithmetic mean of all contained elements.
   - returns: The mean of all items.
   Because the arithmetic mean has no meaning on an empty set, this method returns a NaN if the collection is empty.
   */
  @inlinable
  public var arithmeticMean: Double {
    !self.isEmpty ? sum.doubleValue / Double(count) : .nan
  }
}

extension Collection where Element: Comparable & ConvertibleToDouble {
  @inlinable
  public func median() -> Double {
    guard count > 0 else { return .nan }
    
    let isEvenNumberOfElements = count % 2 == 0
    let sortedElements = self.sorted()
    
    let index = (count - 1) / 2
    let median = isEvenNumberOfElements
      ? (sortedElements[index].doubleValue + sortedElements[index + 1].doubleValue) / 2
      : sortedElements[index].doubleValue
    
    return median
  }
}

extension Sequence where Element: Hashable {
  /**
   Finds the mode(s) of the sequence.
   - returns: A set containing the mode(s) sorted in ascending order.
   The mode of a sequence is the item that occurs most frequently.
   A sequence that has a single item that is most occuring is unimodal,
   as opposed to sequences that have several items that occur equally often and are called multimodal.
   The time complexity of `mode()` is O(n).
   */
  @inlinable
  public func mode() -> Set<Element> {
    let dictionary = self.reduce(into: [Element: Int]()) { (result, element) in result[element, default: 0] += 1 }
    let maximumOccurence = dictionary.values.max() ?? 0
    let result = dictionary
      .filter { elementCount in elementCount.value == maximumOccurence }
      .map { elementCount in elementCount.key }
    
    return Set(result)
  }
}
