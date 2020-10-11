public protocol ContinuousDistribution: Distribution {
  func PDF(x: Element) -> Double
}
