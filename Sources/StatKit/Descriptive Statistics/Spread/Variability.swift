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
