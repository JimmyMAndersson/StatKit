/// A helper object for calculating Spearman's Rho Coefficient.
internal struct SpearmansRhoCalculator: CorrelationCalculator {
  internal func compute<T, U, C>(
    for X: KeyPath<C.Element, T>,
    and Y: KeyPath<C.Element, U>,
    in collection: C,
    as composition: DataSetComposition) -> Double
  where T: Comparable & Hashable, U: Comparable & Hashable, C: Collection {
    
    guard X != Y else { return 1 }
    
    let XRanks = collection.rank(
      variable: X,
      by: >,
      strategy: .fractional
    )
    let YRanks = collection.rank(
      variable: Y,
      by: >,
      strategy: .fractional
    )
    let ranks: [(X: Double, Y: Double)] = Array(zip(XRanks, YRanks))
    
    return ranks.correlation(
      of: \.X,
      and: \.Y,
      for: composition,
      method: .pearsonsProductMoment
    )
  }
}	
