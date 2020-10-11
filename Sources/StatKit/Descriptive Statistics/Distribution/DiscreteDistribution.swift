public protocol DiscreteDistribution: Distribution {
  func PMF(x: Element) -> Double
}
