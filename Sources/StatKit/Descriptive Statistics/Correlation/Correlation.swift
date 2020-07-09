extension Collection {
  
  /// Calculates the covariance of two random variables in a collection.
  /// - parameter X: The first random variable.
  /// - parameter Y: The second random varaible.
  /// - parameter composition: The composition of the collection.
  /// - returns: The covariance of the two variables.
  @inlinable
  public func covariance<T, U>(of X: KeyPath<Element, T>,
                               and Y: KeyPath<Element, U>,
                               from composition: DataSetComposition) -> Double
    where T: ConvertibleToReal, U: ConvertibleToReal {
      guard !isEmpty else { return .nan }
      
      let meanX = lazy.mean(of: X)
      let meanY = lazy.mean(of: Y)
      let varXY = lazy.reduce(into: 0) { result, element in
        result += (element[keyPath: X].realValue - meanX) * (element[keyPath: Y].realValue - meanY)
      }
      
      switch composition {
        case .population:
          return varXY / count.realValue
        case .sample:
          return varXY / (count.realValue - 1)
      }
  }
  
  /// Calculates the specified correlation coefficient for a collection.
  /// - parameter method: The calculation method to use.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - parameter composition: The composition of the collection.
  /// - returns: The correlation coefficient for the specified variables in the collection.
  @inlinable
  public func correlation<T, U>(_ method: CorrelationCoefficientMethod = .pearson,
                                of X: KeyPath<Element, T>,
                                and Y: KeyPath<Element, U>,
                                for composition: DataSetComposition) -> Double
    where T: ConvertibleToReal, U: ConvertibleToReal {
      guard !isEmpty else { return .nan }
      return method.calculator.compute(for: X, and: Y, in: self, as: composition)
  }
}
