extension Sequence {
  /// Calculates the sum of all contained elements.
  /// - parameter variable: The variable over which to calculate the sum.
  /// - returns: The sum of the variable in the sequence.
  /// The time complexity of this method is O(n).
  @inlinable
  public func sum<Variable: AdditiveArithmetic>(over variable: KeyPath<Element, Variable>) -> Variable {
    self.reduce(into: .zero) { (result, element) in result += element[keyPath: variable] }
  }
}
