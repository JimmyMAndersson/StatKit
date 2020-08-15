extension Sequence {
  /// Computes the range of a variable in a sequence.
  /// - parameter X: The variable under investigation.
  /// - returns: The range of the variable.
  ///
  /// The range is the difference between the lowest and highest number in the sequence.
  /// The time complexity of this method is O(n).
  public func range<T>(of X: KeyPath<Element, T>) -> Double
    where T: Comparable & ConvertibleToReal {
      
      var low: Double = .infinity
      var high: Double = -.infinity
      
      for element in self {
        low = Swift.min(element[keyPath: X].realValue, low)
        high = Swift.max(element[keyPath: X].realValue, high)
      }
      
      guard low.isFinite, high.isFinite else { return .signalingNaN }
      
      return high - low
  }
}
