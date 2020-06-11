#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

extension Collection {
  
  /// Calculates the arithmetic mean of the selected variable.
  /// - parameter variable: The variable over which to calculate the mean.
  /// - returns: The mean of all items.
  /// Since the arithmetic mean has no meaning on an empty set, this method returns a NaN if the collection is empty.
  /// The time complexity of this method is O(n).
  @inlinable
  public func arithmeticMean<T: ConvertibleToDouble>(over variable: KeyPath<Element, T>) -> Double {
    !isEmpty ? sum(over: variable).doubleValue / Double(count) : .nan
  }
  
  #if canImport(Darwin) || canImport(GlibC)
  /// Calculates the geometric mean of the selected variable.
  /// - parameter variable: The variable over which to calculate the mean.
  /// - returns: The geometric mean of all items.
  /// Since the geometric mean has no meaning on an empty set, this method returns a NaN if the collection is empty.
  /// The time complexity of this method is O(n).
  @inlinable
  public func geometricMean<T: ConvertibleToDouble>(over variable: KeyPath<Element, T>) -> Double {
    guard !isEmpty else { return .nan }
    
    let product = reduce(into: 1) { product, element in product *= element[keyPath: variable] }.doubleValue
    let power = 1 / Double(count)
    return pow(product, power)
  }
  #endif
  
  /// Calculates the median of the selected variable.
  /// - parameter variable: The variable over which to calculate the median.
  /// - returns: The median of all items.
  /// Since the median has no meaning on an empty set, this method returns a NaN if the collection is empty.
  /// The time complexity of this method is O(n).
  @inlinable
  public func median<T: ConvertibleToDouble & Comparable>(over variable: KeyPath<Element, T>) -> Double {
    guard count > 0 else { return .nan }
    
    let isEvenNumberOfElements = count % 2 == 0
    let sortedElements = self.sorted(by: { $0[keyPath: variable] < $1[keyPath: variable] })
    
    let index = (count - 1) / 2
    
    var median: Double
    
    if isEvenNumberOfElements {
      let firstValue = sortedElements[index][keyPath: variable].doubleValue
      let secondValue = sortedElements[index + 1][keyPath: variable].doubleValue
      median = (firstValue + secondValue) / 2
    } else {
      median = sortedElements[index][keyPath: variable].doubleValue
    }
    
    return median
  }
}

extension Sequence {
  
  /// Finds the mode(s) of the sequence.
  /// - parameter variable: The variable over which to calculate the mode(s).
  /// - returns: A set containing the mode(s) sorted in ascending order.
  /// The mode of a sequence is the item that occurs most frequently.
  /// A sequence that has a single item that is most occuring is unimodal,
  /// as opposed to sequences that have several items that occur equally often and are called multimodal.
  /// The time complexity of this method is O(n).
  @inlinable
  public func mode<T: Hashable>(over variable: KeyPath<Element, T>) -> Set<T> {
    let dictionary = self.reduce(into: [T: Int]()) { (result, element) in
      result[element[keyPath: variable], default: 0] += 1
    }
    
    let maximumOccurence = dictionary.values.max() ?? 0
    
    let result = dictionary
      .filter { variableCount in variableCount.value == maximumOccurence }
      .map { variableCount in variableCount.key }
    
    return Set(result)
  }
}
