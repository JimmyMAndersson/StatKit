/// A protocol marking types that are directly convertible to a real number type.
public protocol ConvertibleToReal {
  /// The real number representation of the value.
  var realValue: Double { get }
}

/// Default implementations for types conforming to the BinaryInteger protocol.
extension ConvertibleToReal where Self: BinaryInteger {
  /// The real number representation of the value.
  public var realValue: Double { Double(self) }
}

/// Default implementations for types conforming to the BinaryFloatingPoint protocol.
extension ConvertibleToReal where Self: BinaryFloatingPoint {
  /// The real number representation of the value.
  public var realValue: Double { Double(self) }
}

// - MARK: Floating Point Types
extension Double: ConvertibleToReal {}
extension Float: ConvertibleToReal {}

#if canImport(CoreGraphics)
import CoreGraphics
extension CGFloat: ConvertibleToReal {}
#endif

#if !(arch(arm) || arch(arm64) || os(watchOS))
extension Float80: ConvertibleToReal {}
#endif

// - MARK: Integer Types
extension Int: ConvertibleToReal {}
extension Int8: ConvertibleToReal {}
extension Int16: ConvertibleToReal {}
extension Int32: ConvertibleToReal {}
extension Int64: ConvertibleToReal {}

extension UInt: ConvertibleToReal {}
extension UInt8: ConvertibleToReal {}
extension UInt16: ConvertibleToReal {}
extension UInt32: ConvertibleToReal {}
extension UInt64: ConvertibleToReal {}
