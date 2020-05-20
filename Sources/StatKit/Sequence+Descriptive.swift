extension Sequence where Element: Hashable {
  /**
   Finds the mode(s) of the sequence.
   - returns: A set containing the mode(s) sorted in ascending order.
   The mode of a sequence is the item that occurs most frequently. A sequence that has a single item that is most occuring is unimodal, as opposed to sequences that have several items that occur equally often and are called multimodal.
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

extension Sequence where Element: Numeric {
  /**
   Calculates the sum of all contained elements.
   
   The time complexity of `sum` is O(n).
   */
  @inlinable
  public var sum: Element {
    self.reduce(into: 0) { (result, element) in result += element }
  }
}
