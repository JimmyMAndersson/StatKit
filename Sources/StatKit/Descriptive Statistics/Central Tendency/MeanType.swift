#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

/// An enumeration specififying a type of mean value calculation..
public enum MeanType {
  /// A case specifying the arithmetic mean.
  case arithmetic
  
  #if canImport(Darwin) || canImport(Glibc)
  /// A case specifying the geometric mean.
  case geometric
  #endif
}

extension MeanType {
  /// Computes the specified mean value of a collection.
  /// - parameter variable: The random variable for which to calculate the mean.
  /// - parameter collection: The collection of values.
  /// - returns: The specified mean value.
  /// The time complexity of this method is O(n).
  internal func compute<T: ConvertibleToReal, U: Collection>(for variable: KeyPath<U.Element, T>,
                                                             in collection: U) -> Double {
    switch self {
      case .arithmetic:
        return collection.average(over: variable)
      
      #if canImport(Darwin) || canImport(Glibc)
      case .geometric:
        let product = collection.lazy.reduce(into: 1) { product, term in
          product *= term[keyPath: variable]
        }.realValue
        
        let power = 1 / Double(collection.count)
        return pow(product, power)
      
      #endif
    }
  }
}
