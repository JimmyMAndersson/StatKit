/// An internal protocol defining the methods required by correlation coefficient calculator types.
@usableFromInline
internal protocol LinearCorrelationCalculator {
  /// Computes the linear relationship between two variables in a collection.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - parameter collection: The data set containing the measurements.
  /// - parameter composition: The composition of the data set.
  /// - returns: The correlation coefficient for the specified variables.
  func compute<T, U, C>(
    for X: KeyPath<C.Element, T>,
    and Y: KeyPath<C.Element, U>,
    in collection: C,
    as composition: DataSetComposition) -> Double
    where T: ConvertibleToReal, U: ConvertibleToReal, C: Collection
}

/// Different methods of calculating the correlation coefficient between arbitrary numeric variables.
public enum LinearCorrelationMethod {
  /// Pearson's product-moment correlation coefficient.
  case pearsonsProductMoment
  
  @usableFromInline
  internal var calculator: LinearCorrelationCalculator {
    switch self {
      case .pearsonsProductMoment:
        return PearsonsProductMomentCalculator()
    }
  }
}
