/// An internal protocol defining the methods required by association measure calculator types.
@usableFromInline
internal protocol RankCorrelationCalculator {
  /// Computes the measure of association for two variables in a collection.
  /// - parameter X: The first variable.
  /// - parameter Y: The second variable.
  /// - parameter collection: The data set containing the measurements.
  /// - parameter composition: The composition of the data set.
  /// - returns: The measure of assocation coefficient for the specified variables.
  func compute<T, U, C>(
    for X: KeyPath<C.Element, T>,
    and Y: KeyPath<C.Element, U>,
    in collection: C,
    as composition: DataSetComposition) -> Double
    where
    T: Comparable & Hashable & ConvertibleToReal,
    U: Comparable & Hashable & ConvertibleToReal,
    C: Collection
}

/// Different methods of calculating the association measure between arbitrary comparable variables.
public enum RankCorrelationMethod {
  /// Spearman's Rho coefficient.
  case spearmansRho
  
  /// Kendall's Tau coefficient.
  ///
  /// This method calculates the Tau-B coefficient, which takes ties into account.
  /// The time complexity is O(n * log(n)).
  case kendallsTau
  
  /// A calculator object that can be used to compute the specified measure of association.
  @usableFromInline
  internal var calculator: RankCorrelationCalculator {
    switch self {
      case .spearmansRho:
        return SpearmansRhoCalculator()
      
      case .kendallsTau:
        return KendallsTauCalculator()
    }
  }
}
