import CoreGraphics

/// A protocol marking types that are directly convertible to a real number type.
public protocol ConvertibleToReal: Numeric {
  /// The value in a real number form.
  var realValue: Double { get }
}

extension ConvertibleToReal where Self: BinaryInteger {
  public var realValue: Double { Double(self) }
}

extension ConvertibleToReal where Self: BinaryFloatingPoint {
  public var realValue: Double { Double(self) }
}

// - MARK: Floating Point Types
extension Double: ConvertibleToReal {}
extension Float: ConvertibleToReal {}
extension CGFloat: ConvertibleToReal {}

#if !(arch(arm) || arch(arm64))
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
