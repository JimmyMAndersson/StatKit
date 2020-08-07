extension Collection {
  
  /// Calculates the variance of the selected variable.
  /// - parameter variable: The variable over which to calculate the variance.
  /// - parameter composition: The composition of the collection.
  /// - returns: The variance of the collection.
  /// The time complexity of this method is O(n).
  @inlinable
  public func variance<T: ConvertibleToReal>(of variable: KeyPath<Element, T>,
                                             from composition: DataSetComposition) -> Double {
    guard !isEmpty else { return .nan }
    guard count > 1 else { return 0 }
    
    let mean = self.mean(of: variable)
    func square(of number: Double) -> Double {
      number * number
    }
    
    let squareDiff = lazy.reduce(into: 0) { (squareSum, element) in
      squareSum += square(of: element[keyPath: variable].realValue - mean)
    }
    
    switch composition {
      case .sample:
        return squareDiff / (count.realValue - 1)
      case .population:
        return squareDiff / count.realValue
    }
  }
  
  /// Calculates the standard deviation of the selected variable.
  /// - parameter variable: The variable over which to calculate the standard deviation.
  /// - parameter composition: The composition of the collection.
  /// - returns: The standard deviation of the collection, rounded to a representable value.
  /// The time complexity of this method is O(n).
  @inlinable
  public func standardDeviation<T: ConvertibleToReal>(of variable: KeyPath<Element, T>,
                                                      from composition: DataSetComposition) -> Double {
    
    variance(of: variable, from: composition).squareRoot()
  }
}
