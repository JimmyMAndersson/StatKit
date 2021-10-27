/// An implementation of the Xoshiro256** pseudo random number generator.
///
/// - important: This PRNG is not considered cryptographically safe.
internal struct Xoroshiro256StarStar: RandomNumberGenerator {
  private typealias State = (UInt64, UInt64, UInt64, UInt64)
  private var state: State
  
  internal init<Source: RandomNumberGenerator>(from source: inout Source) {
    repeat {
      state = (source.next(), source.next(), source.next(), source.next())
    } while state == (0, 0, 0, 0)
  }
  
  internal init() {
    var entropy = SystemRandomNumberGenerator()
    self.init(from: &entropy)
  }
  
  internal mutating func next() -> UInt64 {
    let result = rotateLeft(state.1 &* 5, 7) &* 9
    let temp = state.1 << 17
    
    state.2 ^= state.0
    state.3 ^= state.1
    state.1 ^= state.2
    state.0 ^= state.3
    
    state.2 ^= temp
    state.3 = rotateLeft(state.3, 45)
    
    return result
  }
  
  private func rotateLeft(_ x: UInt64, _ steps: UInt64) -> UInt64 {
    return (x << steps) | (x >> (64 - steps))
  }
}
