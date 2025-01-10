/// A protocol marking types that are directly convertible to a real number type.
public protocol ConvertibleToReal: Numeric {
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

#if swift(>=5.4) && !((os(macOS) || targetEnvironment(macCatalyst)) && arch(x86_64))
@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: ConvertibleToReal {}
#endif

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

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension Int128: ConvertibleToReal {}

@available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
extension UInt128: ConvertibleToReal {}
