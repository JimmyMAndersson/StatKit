extension Collection {
  
  /// Calculates the covariance of two random variables in a collection.
  /// - parameter X: The first random variable.
  /// - parameter Y: The second random varaible.
  /// - returns: The covariance of the two variables.
  @inlinable
  public func covariance<T, U>(of X: KeyPath<Element, T>,
                               and Y: KeyPath<Element, U>) -> Double
    where T: ConvertibleToReal, U: ConvertibleToReal {
      guard !isEmpty else { return .nan }
      
      let EXY = lazy.map { element in
        element[keyPath: X].realValue * element[keyPath: Y].realValue
      }
      .arithmeticMean(of: \.self)
      
      let EX = lazy.arithmeticMean(of: X)
      let EY = lazy.arithmeticMean(of: Y)
      
      return EXY - (EX * EY)
  }
}
