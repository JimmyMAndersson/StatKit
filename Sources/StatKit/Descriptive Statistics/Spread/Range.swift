/// Computes the range of a variable in a sequence.
/// - parameter sequence: The sequence to inverstigate.
/// - parameter variable: The variable under investigation.
/// - returns: The range of the selected variable.
///
/// The range is the difference between the lowest and highest number in the sequence.
/// The time complexity of this method is O(n).
public func range<S: Sequence, T: Comparable & ConvertibleToReal>(
  in sequence: S,
  of variable: KeyPath<S.Element, T>
) -> Double {
  
  var low: Double = .infinity
  var high: Double = -.infinity
  
  for element in sequence {
    low = Swift.min(element[keyPath: variable].realValue, low)
    high = Swift.max(element[keyPath: variable].realValue, high)
  }
  
  guard low.isFinite, high.isFinite else { return .signalingNaN }
  
  return high - low
}
