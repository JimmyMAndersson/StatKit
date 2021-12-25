/// A helper object for calculating Spearman's Rho Coefficient.
internal struct SpearmansRhoCalculator: CorrelationCalculator {
  internal func compute<T, U, C>(
    for X: KeyPath<C.Element, T>,
    and Y: KeyPath<C.Element, U>,
    in collection: C,
    as composition: DataSetComposition) -> Double
  where T: Comparable & Hashable, U: Comparable & Hashable, C: Collection {
    
    guard X != Y else { return 1 }
    
    let XRanks = rank(collection, variable: X, by: >, strategy: .fractional)
    let YRanks = rank(collection, variable: Y, by: >, strategy: .fractional)
    let ranks: [(X: Double, Y: Double)] = Array(zip(XRanks, YRanks))
    
    return correlation(
      ranks,
      of: \.X,
      and: \.Y,
      for: composition,
      method: .pearsonsProductMoment
    )
  }
}	
