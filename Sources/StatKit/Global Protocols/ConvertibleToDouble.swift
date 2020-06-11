import CoreGraphics

/// A protocol marking types that are directly convertible to a real number type.
public protocol ConvertibleToDouble: Numeric {
  /// The value in a real number form.
  var doubleValue: Double { get }
}

extension ConvertibleToDouble where Self: BinaryInteger {
  public var doubleValue: Double { Double(self) }
}

extension ConvertibleToDouble where Self: BinaryFloatingPoint {
  public var doubleValue: Double { Double(self) }
}

// - MARK: Floating Point Types
extension Double: ConvertibleToDouble {}
extension Float: ConvertibleToDouble {}
extension Float80: ConvertibleToDouble {}
extension CGFloat: ConvertibleToDouble {}

// - MARK: Integer Types
extension Int: ConvertibleToDouble {}
extension Int8: ConvertibleToDouble {}
extension Int16: ConvertibleToDouble {}
extension Int32: ConvertibleToDouble {}
extension Int64: ConvertibleToDouble {}

extension UInt: ConvertibleToDouble {}
extension UInt8: ConvertibleToDouble {}
extension UInt16: ConvertibleToDouble {}
extension UInt32: ConvertibleToDouble {}
extension UInt64: ConvertibleToDouble {}
