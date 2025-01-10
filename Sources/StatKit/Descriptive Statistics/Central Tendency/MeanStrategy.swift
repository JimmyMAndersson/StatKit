/// An enumeration specififying a type of mean value calculation.
public enum MeanStrategy: CaseIterable {
  /// A case specifying the arithmetic mean.
  case arithmetic

  /// A case specifying the geometric mean.
  /// This implementation of the geometric mean supports collections that produce a real-valued result.
  /// If a collection only has complex solutions, this strategy returns a NaN.
  case geometric

  /// A case specifying the harmonic mean.
  case harmonic
}

extension MeanStrategy {
  /// Computes the specified mean value of a collection.
  /// - parameter variable: The random variable for which to calculate the mean.
  /// - parameter collection: The collection of values.
  /// - returns: The specified mean value.
  /// The time complexity of this method is O(n).
  @usableFromInline
  internal func compute<C: Collection, T: ConvertibleToReal>(
    for variable: KeyPath<C.Element, T>,
    in collection: C
  ) -> Double {
    switch self {
      case .arithmetic:
        return zip(collection, 1...collection.count)
          .reduce(into: 0.0) { result, zip in
            let (element, count) = zip
            result += (element[keyPath: variable].realValue - result) / count.realValue
          }

      case .geometric:
        typealias GeometricCalculation = (numberOfNegatives: Int, logSum: Double)
        let (numberOfNegatives, logSum): GeometricCalculation = collection
          .reduce(into: (0, 0)) { result, element in
            let value = element[keyPath: variable].realValue
            result.numberOfNegatives += value < .zero ? 1 : 0
            result.logSum += .log(value.magnitude)
          }

        let oddNumberOfNegatives = numberOfNegatives & 1 == 1
        let oddElementCount = collection.count & 1 == 1

        guard !oddNumberOfNegatives || oddElementCount else {
          return .signalingNaN
        }

        let sign = (oddNumberOfNegatives && oddElementCount) ? -1.0 : 1.0
        return sign * .exp(logSum / collection.count.realValue)

      case .harmonic:
        let reciprocalSum = collection.reduce(into: 0) { sum, element in
          sum += 1 / element[keyPath: variable].realValue
        }

        return collection.count.realValue / reciprocalSum
    }
  }
}
