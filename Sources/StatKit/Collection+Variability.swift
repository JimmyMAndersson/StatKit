extension Collection where Self.Element: BinaryInteger {
  /**
  Calculates the mean of all contained elements.
  - returns: The mean of all items.
  */
  @inlinable
  public var mean: Double { Double(sum) / Double(count) }
  
  /**
   Calculates the variance of all contained items.
   - parameter composition: The composition of the collection.
   */
  @inlinable
  public func variance(assuming composition: DataSetComposition) -> Double {
    let mean = self.mean
    func square(of number: Double) -> Double { number * number }
    
    let squareSum = self.reduce(into: 0) { (squareSum, element) in squareSum += square(of: Double(element) - mean) }
    
    switch composition {
      case .sample:
        return squareSum / (Double(count) - 1)
      case .population:
        return squareSum / Double(count)
    }
  }
  
  /**
   Calculates the standard deviation of all contained items.
   - parameter composition: The composition of the collection.
   - returns: The standard deviation of the collection, rounded to a representable value.
   */
  @inlinable
  public func standardDeviation(assuming composition: DataSetComposition) -> Double {
    variance(assuming: composition).squareRoot()
  }
}

extension Collection where Self.Element: BinaryFloatingPoint {
  /**
  Calculates the mean of all contained elements.
  - returns: The mean of all items.
  */
  @inlinable
  public var mean: Double { Double(sum) / Double(count) }
  
  /**
   Calculates the variance of all contained items.
   - parameter composition: The composition of the collection.
   - returns: The sample or population variance of the collection.
   */
  @inlinable
  public func variance(assuming composition: DataSetComposition) -> Double {
    let mean = self.mean
    func square(of number: Double) -> Double { number * number }
    
    let squareSum = self.reduce(into: 0) { (squareSum, element) in squareSum += square(of: Double(element) - mean) }
    
    switch composition {
      case .sample:
        return squareSum / (Double(count) - 1)
      case .population:
        return squareSum / Double(count)
    }
  }
  
  /**
   Calculates the standard deviation of all contained items.
   - parameter composition: The composition of the collection.
   - returns: The standard deviation of the collection, rounded to a representable value.
   */
  @inlinable
  public func standardDeviation(assuming composition: DataSetComposition) -> Double {
    variance(assuming: composition).squareRoot()
  }
}
