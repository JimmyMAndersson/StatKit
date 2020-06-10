extension Collection {
  
  /// Calculates the variance of the selected variable.
  /// - parameter variable: The variable over which to calculate the variance.
  /// - parameter composition: The composition of the collection.
  /// - returns: The variance of the collection.
  /// The time complexity of this method is O(n).
  @inlinable
  public func variance<T: ConvertibleToDouble>(over variable: KeyPath<Element, T>,
                                               assuming composition: DataSetComposition) -> Double
  {
    let mean = arithmeticMean(over: variable)
    func square(of number: Double) -> Double { number * number }
    
    let squareSum = self.reduce(into: 0) { (squareSum, element) in
      squareSum += square(of: element[keyPath: variable].doubleValue - mean)
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
  public func standardDeviation<T: ConvertibleToDouble>(over variable: KeyPath<Element, T>,
                                                        assuming composition: DataSetComposition) -> Double
  {
    variance(over: variable, assuming: composition).squareRoot()
  }
}
