/// Calculates the covariance of two random variables in a collection.
/// - parameter X: The first random variable.
/// - parameter Y: The second random varaible.
/// - parameter composition: The composition of the collection.
/// - returns: The covariance of the two variables.
/// Since there is no notion of covariance in collections with less than two elements,
/// this method returns NaN if the array count is less than two.
/// The time complexity of this method is O(n).
@inlinable
public func covariance<T, U, C>(
  _ collection: C,
  of X: KeyPath<C.Element, T>,
  and Y: KeyPath<C.Element, U>,
  from composition: DataSetComposition) -> Double
where T: Comparable & Hashable & ConvertibleToReal,
      U: Comparable & Hashable & ConvertibleToReal,
      C: Collection
{
  
  guard collection.count > 1 else { return .signalingNaN }
  
  let meanX = mean(of: collection, variable: X)
  let meanY = mean(of: collection, variable: Y)
  let varXY = collection.reduce(into: 0) { result, element in
    result += (element[keyPath: X].realValue - meanX) * (element[keyPath: Y].realValue - meanY)
  }
  
  switch composition {
    case .population:
      return varXY / collection.count.realValue
    case .sample:
      return varXY / (collection.count.realValue - 1)
  }
}

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
