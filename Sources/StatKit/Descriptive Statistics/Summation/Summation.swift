/// Calculates the sum of all contained elements.
/// - parameter sequence: The sequence to sum over.
/// - parameter variable: The variable over which to calculate the sum.
/// - returns: The sum of the variable in the sequence.
/// The time complexity of this method is O(n).
@inlinable
public func sum<S: Sequence, T: AdditiveArithmetic>(
  of sequence: S,
  over variable: KeyPath<S.Element, T>
) -> T {
  sequence.reduce(into: .zero) { result, element in
    result += element[keyPath: variable]
  }
}
