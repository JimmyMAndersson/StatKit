extension Collection {
  
  /// Calculates the variance of the selected variable.
  /// - parameter variable: The variable over which to calculate the variance.
  /// - parameter composition: The composition of the collection.
  /// - returns: The variance of the collection.
  /// The time complexity of this method is O(n).
  @inlinable
  public func variance<T: ConvertibleToReal>(of variable: KeyPath<Element, T>,
                                             composition: DataSetComposition) -> Double {
    let mean = arithmeticMean(of: variable)
    func square(of number: Double) -> Double { number * number }
    
    let squareSum = lazy.reduce(into: 0) { (squareSum, element) in
      squareSum += square(of: element[keyPath: variable].realValue - mean)
    }
    
    switch composition {
      case .sample:
        return squareSum / (Double(count) - 1)
      case .population:
        return squareSum / Double(count)
    }
  }
  
  /// Calculates the standard deviation of the selected variable.
  /// - parameter variable: The variable over which to calculate the standard deviation.
  /// - parameter composition: The composition of the collection.
  /// - returns: The standard deviation of the collection, rounded to a representable value.
  /// The time complexity of this method is O(n).
  @inlinable
  public func standardDeviation<T: ConvertibleToReal>(of variable: KeyPath<Element, T>,
                                                      composition: DataSetComposition) -> Double {
    
    variance(of: variable, composition: composition).squareRoot()
  }
}
