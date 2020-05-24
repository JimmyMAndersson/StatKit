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
