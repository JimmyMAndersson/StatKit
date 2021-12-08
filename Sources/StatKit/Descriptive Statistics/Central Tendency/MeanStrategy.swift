/// An enumeration specififying a type of mean value calculation.
public enum MeanStrategy {
  /// A case specifying the arithmetic mean.
  case arithmetic
  
  /// A case specifying the geometric mean.
  case geometric
  
  /// A case specifying the harmonic mean.
  case harmonic
}

extension MeanStrategy {
  /// Computes the specified mean value of a collection.
  /// - parameter variable: The random variable for which to calculate the mean.
  /// - parameter collection: The collection of values.
  /// - returns: The specified mean value.
  /// The time complexity of this method is O(n).
  @usableFromInline
  internal func compute<T, C>(
    for variable: KeyPath<C.Element, T>,
    in collection: C) -> Double
    where
    T: ConvertibleToReal,
    C: Collection {
      
      switch self {
        case .arithmetic:
          return zip(collection, 1...collection.count)
            .reduce(into: 0.0) { result, zip in
              let (element, count) = zip
              result += (element[keyPath: variable].realValue - result) / count.realValue
        }
        
        case .geometric:
          let product = collection.reduce(into: 1) { product, term in
            product *= term[keyPath: variable].realValue
          }.realValue
          
          let power = 1 / Double(collection.count)
          return .pow(product, power)
        
        case .harmonic:
          let reciprocalSum = collection.reduce(into: 0) { sum, element in
            sum += 1 / element[keyPath: variable].realValue
          }
        
          guard reciprocalSum.isNormal else { return .signalingNaN }
          return collection.count.realValue / reciprocalSum
      }
  }
}
