public extension Collection {
  /// Computes the range of a variable in a collection.
  /// - parameter variable: The variable under investigation.
  /// - returns: The range of the selected variable.
  ///
  /// The range is the difference between the lowest and highest number in a collection.
  /// The time complexity of this method is O(n).
  func range<T: Comparable & ConvertibleToReal>(
    of variable: KeyPath<Element, T>
  ) -> Double {
    
    var low: Double = .infinity
    var high: Double = -.infinity
    
    for element in self {
      low = Swift.min(element[keyPath: variable].realValue, low)
      high = Swift.max(element[keyPath: variable].realValue, high)
    }
    
    guard low.isFinite, high.isFinite else { return .signalingNaN }
    
    return high - low
  }
}
