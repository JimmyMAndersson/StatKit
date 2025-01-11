/// Computes the binomial coefficient for the provided n and k.
/// - parameter n: The number of items to choose from.
/// - parameter k: The number of items to select.
/// - returns: The binomial coefficient.
/// This implementation of the binomial coefficient supports negative numbers n and k
/// and follows the work of Kronenburg.
public func choose<Integer: BinaryInteger>(n: Integer, k: Integer) -> Integer {
  switch n < 0 {
    case true:
      if 0 <= k {
        let sign: Integer = (k & 1 == 0) ? 1 : -1
        return sign * binomial(n: k - n - 1, k: k)
      } else if k <= n {
        let sign: Integer = ((n - k) & 1 == 0) ? 1 : -1
        return sign * binomial(n: -1 - k, k: n - k)
      } else {
        return 0
      }
      
    case false:
      if 0 <= k && k <= n {
        return binomial(n: n, k: k)
      } else {
        return 0
      }
  }
}

/// Computes the binomial coefficient for the provided n and k.
/// - parameter n: The number of items to choose from (needs to be a non-negative number).
/// - parameter k: The number of items to select (needs to be a non-negative number).
/// - returns: The binomial coefficient.
private func binomial<Integer: BinaryInteger>(n: Integer, k: Integer) -> Integer {
  var result: Integer = 1
  var k = k

  if k > n - k {
    k = n - k
  }

  for offset in 0 ..< Int(k) {
    result *= n - Integer(offset)
    result /= Integer(offset) + 1
  }

  return result
}
