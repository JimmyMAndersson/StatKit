// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "StatKit",
  platforms: [
    .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
  ],
  products: [
    .library(
      name: "StatKit",
      targets: ["StatKit"]),
  ],
  targets: [
    .target(
      name: "StatKit",
      dependencies: []),
    .testTarget(
      name: "StatKitTests",
      dependencies: ["StatKit"]),
  ]
)
