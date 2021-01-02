public func factorial(_ x: Int) -> Int {
  switch x {
    case ..<0:
      fatalError("The factorial function is only defined for non-negative integers (\(x) was provided).")
      
    case 0:
      return 1
      
    default:
      return (1 ... x).reduce(into: 1) { result, number in result *= number }
  }
}
