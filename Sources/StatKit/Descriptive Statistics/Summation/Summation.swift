extension Sequence {
  
  /// Calculates the sum of all contained elements.
  /// - parameter variable: The variable over which to calculate the sum.
  /// - returns: The sum of the variable in the sequence.
  /// The time complexity of this method is O(n).
  @inlinable
  public func sum<T: AdditiveArithmetic>(over variable: KeyPath<Element, T>) -> T {
    lazy.reduce(into: .zero) { result, element in
      result += element[keyPath: variable]
    }
  }
    /// Calculates the average of all contained elements.
    /// - parameter variable: The variable over which to calculate the average.
    /// - returns: The average of the variable in the sequence.
    /// The time complexity of this method is O(n).
    @inlinable
    public func average<T>(over variable: KeyPath<Element, T>) -> Double
    where T: ConvertibleToReal
    {
        var avg = 0.0
        var t = 1.0
          for x in self {
            let value = x[keyPath: variable]
            avg += (value.realValue - avg) / t
            t += 1
          }
          return avg
    }
}
