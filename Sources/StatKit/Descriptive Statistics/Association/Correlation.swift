/// Calculates the specified correlation coefficient for a collection.
/// - parameter collection: The collection under investigation.
/// - parameter X: The first variable.
/// - parameter Y: The second variable.
/// - parameter composition: The composition of the collection.
/// - parameter method: The calculation method to use.
/// - returns: The correlation coefficient for the specified variables in the collection.
/// Since there is no notion of correlation in collections with less than two elements,
/// this method returns NaN if the array count is less than two.
/// The time complexity of this method is O(n).
@inlinable
public func correlation<T, U, C>(
  _ collection: C,
  of X: KeyPath<C.Element, T>,
  and Y: KeyPath<C.Element, U>,
  for composition: DataSetComposition,
  method: CorrelationMethod = .pearsonsProductMoment
) -> Double
where T: Comparable & Hashable & ConvertibleToReal,
      U: Comparable & Hashable & ConvertibleToReal,
      C: Collection
{
  guard collection.count > 1 else { return .signalingNaN }
  return method.calculator.compute(for: X, and: Y, in: collection, as: composition)
}
