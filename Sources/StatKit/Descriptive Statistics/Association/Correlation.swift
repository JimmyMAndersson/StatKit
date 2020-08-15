extension Collection {
  
  /// Calculates the covariance of two random variables in a collection.
  /// - parameter X: The first random variable.
  /// - parameter Y: The second random varaible.
  /// - parameter composition: The composition of the collection.
  /// - returns: The covariance of the two variables.
  /// Since there is no notion of covariance in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  @inlinable
  public func covariance<T, U>(
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>,
    from composition: DataSetComposition) -> Double
    where
    T: ConvertibleToReal,
    U: ConvertibleToReal {
      
      guard count > 1 else { return .signalingNaN }
      
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
  /// Since there is no notion of correlation in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  @inlinable
  public func correlation<T, U>(
    _ method: LinearCorrelationMethod = .pearsonsProductMoment,
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>,
    for composition: DataSetComposition) -> Double
    where
    T: ConvertibleToReal,
    U: ConvertibleToReal {
      
      guard count > 1 else { return .signalingNaN }
      return method.calculator.compute(for: X, and: Y, in: self, as: composition)
  }
  
  /// Calculates the specified rank correlation coefficient for a collection.
  /// - parameter method: The calculation method to use.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - parameter composition: The composition of the collection.
  /// - returns: The association coefficient for the specified variables in the collection.
  /// Since there is no notion of correlation in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  @inlinable
  public func correlation<T, U>(
    _ method: RankCorrelationMethod,
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>,
    for composition: DataSetComposition) -> Double
    where
    T: Comparable & Hashable & ConvertibleToReal,
    U: Comparable & Hashable & ConvertibleToReal {
      
      guard count > 1 else { return .signalingNaN }
      return method.calculator.compute(for: X, and: Y, in: self, as: composition)
  }
}
