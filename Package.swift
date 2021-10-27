// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "StatKit",
  platforms: [
    .macOS(.v10_15), .iOS(.v13), .tvOS(.v13)
  ],
  products: [
    .library(
      name: "StatKit",
      targets: ["StatKit"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-numerics.git",
      from: "1.0.0"
    )
  ],
  targets: [
    .target(
      name: "StatKit",
      dependencies: [
        .product(name: "RealModule", package: "swift-numerics")
      ]
    ),
    .testTarget(
      name: "StatKitTests",
      dependencies: ["StatKit"]),
  ],
  swiftLanguageVersions: [
    .v5
  ]
)
