extension Collection where Self.Element: AdditiveArithmetic & ConvertibleToDouble {
  /**
   Calculates the variance of all contained items.
   - parameter composition: The composition of the collection.
   */
  @inlinable
  public func variance(assuming composition: DataSetComposition) -> Double {
    let mean = self.arithmeticMean
    func square(of number: Double) -> Double { number * number }
    
    let squareSum = self.reduce(into: 0) { (squareSum, element) in
      squareSum += square(of: element.doubleValue - mean)
    }
    
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
