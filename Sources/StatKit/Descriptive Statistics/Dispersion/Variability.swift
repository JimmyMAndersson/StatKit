import RealModule

/// Calculates the variance of some selected variable in a collection.
/// - parameter collection: The collection to investigate.
/// - parameter variable: The variable over which to calculate the variance.
/// - parameter composition: The composition of the collection.
/// - returns: The variance of the collection.
/// The time complexity of this method is O(n).
@inlinable
public func variance<C: Collection, T: ConvertibleToReal>(
  of collection: C,
  variable: KeyPath<C.Element, T>,
  from composition: DataSetComposition
) -> Double {
  
  guard !collection.isEmpty else { return .signalingNaN }
  guard collection.count > 1 else { return 0 }
  
  let mean = mean(of: collection, variable: variable)
  
  let squareDiff = collection.lazy.reduce(into: 0) { (squareSum, element) in
    squareSum += .pow(element[keyPath: variable].realValue - mean, 2)
  }
  
  switch composition {
    case .sample:
      return squareDiff / (collection.count.realValue - 1)
    case .population:
      return squareDiff / collection.count.realValue
  }
}

/// Calculates the standard deviation of the selected variable.
/// - parameter collection: The collection to investigate.
/// - parameter variable: The variable over which to calculate the standard deviation.
/// - parameter composition: The composition of the collection.
/// - returns: The standard deviation of the collection, rounded to a representable value.
/// The time complexity of this method is O(n).
@inlinable
public func standardDeviation<C: Collection, T: ConvertibleToReal>(
  of collection: C,
  variable: KeyPath<C.Element, T>,
  from composition: DataSetComposition
) -> Double {
  variance(of: collection, variable: variable, from: composition).squareRoot()
}

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
