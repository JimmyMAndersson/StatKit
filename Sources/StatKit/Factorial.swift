/// Computes the factorial of a number (`x!`).
/// - parameter x: The number for which to compute the factorial.
public func factorial(_ x: Int) -> Int {
  precondition(0 <= x, "The factorial function is only defined for non-negative integers (\(x) was provided).")
  
  switch x {
    case 0, 1:
      return 1
      
    default:
      return (2 ... x).reduce(into: 1) { result, number in result *= number }
  }
}
