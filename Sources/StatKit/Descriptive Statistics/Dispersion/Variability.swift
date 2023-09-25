import RealModule

public extension Collection {
  /// Calculates the variance of some selected variable in a collection.
  /// - parameter variable: The variable over which to calculate the variance.
  /// - parameter composition: The composition of the collection.
  /// - returns: The variance of the collection.
  ///
  /// The time complexity of this method is O(n).
  @inlinable
  func variance<T: ConvertibleToReal>(
    variable: KeyPath<Element, T>,
    from composition: DataSetComposition
  ) -> Double {

    guard !self.isEmpty else { return .signalingNaN }
    guard self.count > 1 else { return 0 }

    let mean = self.mean(variable: variable)

    let squareDiff = self.lazy.reduce(into: 0) { (squareSum, element) in
      squareSum += .pow(element[keyPath: variable].realValue - mean, 2)
    }

    switch composition {
      case .sample:
        return squareDiff / (self.count.realValue - 1)
      case .population:
        return squareDiff / self.count.realValue
    }
  }

  /// Calculates the standard deviation of the selected variable.
  /// - parameter variable: The variable over which to calculate the standard deviation.
  /// - parameter composition: The composition of the collection.
  /// - returns: The standard deviation of the collection, rounded to a representable value.
  ///
  /// The time complexity of this method is O(n).
  @inlinable
  func standardDeviation<T: ConvertibleToReal>(
    variable: KeyPath<Element, T>,
    from composition: DataSetComposition
  ) -> Double {
    self.variance(variable: variable, from: composition).squareRoot()
  }

  /// Calculates the covariance of two random variables in a collection.
  /// - parameter X: The first random variable.
  /// - parameter Y: The second random varaible.
  /// - parameter composition: The composition of the collection.
  /// - returns: The covariance of the two variables.
  ///
  /// Since there is no notion of covariance in collections with less than two elements,
  /// this method returns NaN if the array count is less than two.
  /// The time complexity of this method is O(n).
  @inlinable
  func covariance<T, U>(
    of X: KeyPath<Element, T>,
    and Y: KeyPath<Element, U>,
    from composition: DataSetComposition) -> Double
  where T: Comparable & Hashable & ConvertibleToReal,
        U: Comparable & Hashable & ConvertibleToReal
  {

  guard self.count > 1 else { return .signalingNaN }

  let meanX = self.mean(variable: X)
  let meanY = self.mean(variable: Y)
  let varXY = self.reduce(into: 0) { result, element in
    result += (element[keyPath: X].realValue - meanX) * (element[keyPath: Y].realValue - meanY)
  }

  switch composition {
    case .population:
      return varXY / self.count.realValue
    case .sample:
      return varXY / (self.count.realValue - 1)
  }
  }
}
