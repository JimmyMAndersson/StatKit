/// Computes the factorial of a number (`x!`).
/// - parameter x: The number for which to compute the factorial.
@inlinable
public func factorial<Integer: BinaryInteger>(_ x: Integer) -> Integer {
  precondition(0 <= x, "The factorial function is only defined for non-negative integers (\(x) was provided).")
  
  switch x {
    case 0, 1:
      return 1
      
    default:
      return (2 ... Int(x)).reduce(into: 1) { result, number in result *= Integer(number) }
  }
}
