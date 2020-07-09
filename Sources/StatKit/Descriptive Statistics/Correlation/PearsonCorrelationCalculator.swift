/// A helper object for calculating the Pearson Correlation Coefficient.
internal struct PearsonCorrelationCalculator: CorrelationCalculationProtocol {
  func compute<T, U, C>(for X: KeyPath<C.Element, T>,
                        and Y: KeyPath<C.Element, U>,
                        in collection: C,
                        as composition: DataSetComposition) -> Double
    where T: ConvertibleToReal, U: ConvertibleToReal, C: Collection {
      
      if collection.count < 2 {
        return .nan
      }
      if X == Y {
        return 1
      }
      let XStdDev = collection.standardDeviation(of: X, from: composition)
      let YStdDev = collection.standardDeviation(of: Y, from: composition)
      let stdDevProduct = XStdDev * YStdDev
      if stdDevProduct.isZero {
        return .nan
      }
      
      switch composition {
        case .population:
          return collection.covariance(of: X, and: Y, from: composition) / stdDevProduct
        
        case .sample:
          let sumOfProducts = collection.lazy.reduce(into: 0) { result, element in
            result += element[keyPath: X].realValue * element[keyPath: Y].realValue
          }
          let numerator = sumOfProducts - collection.count.realValue * collection.mean(of: X) * collection.mean(of: Y)
          let denominator = (collection.count - 1).realValue * stdDevProduct
          return numerator / denominator
      }
  }
}
