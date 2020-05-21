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

extension Sequence where Element: AdditiveArithmetic {
  /**
   Calculates the sum of all contained elements.
   
   The time complexity of `sum` is O(n).
   */
  @inlinable
  public var sum: Element {
    self.reduce(into: .zero) { (result, element) in result += element }
  }
}

extension Collection where Element: BinaryInteger {
  @inlinable
  public func median() -> Double? {
    guard count > 0 else { return .none }
    
    let evenNumberOfElements = count % 2 == 0
    let sortedElements = self.sorted()
    
    if evenNumberOfElements {
      let lowerElement = (count - 1) / 2
      let upperElement = lowerElement + 1
      return Double(sortedElements[lowerElement] + sortedElements[upperElement]) / 2
    } else {
      let medianElement = (count - 1) / 2
      return Double(sortedElements[medianElement])
    }
  }
}

extension Collection where Element: BinaryFloatingPoint {
  @inlinable
  public func median() -> Double? {
    guard count > 0 else { return .none }
    
    let evenNumberOfElements = count % 2 == 0
    let sortedElements = self.sorted()
    
    if evenNumberOfElements {
      let lowerElement = (count - 1) / 2
      let upperElement = lowerElement + 1
      return Double(sortedElements[lowerElement] + sortedElements[upperElement]) / 2
    } else {
      let medianElement = (count - 1) / 2
      return Double(sortedElements[medianElement])
    }
  }
}
