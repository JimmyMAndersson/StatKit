public protocol Distribution {
  associatedtype Element
  
  var mean: Double { get }
  var variance: Double { get }
  var skewness: Double { get }
  var kurtosis: Double { get }
  
  func CDF(x: Element) -> Double
  
  func percentPointFunction(x: Element) -> Double
  
  func survivialFunction(x: Element) -> Double
  func inverseSurvivalFunction(x: Element) -> Double
  
  func moment(_ type: MomentType, order: Int) -> Double
}

public enum MomentType {
  case central
  case raw
}
