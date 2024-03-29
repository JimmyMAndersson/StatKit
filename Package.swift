// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "StatKit",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
    .tvOS(.v15)
  ],
  products: [
    .library(
      name: "StatKit",
      targets: ["StatKit"]
    ),
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
        .product(name: "RealModule", package: "swift-numerics", condition: .none)
      ],
      resources: [
        .process("Resources/PrivacyInfo.xcprivacy")
      ]
    ),
    .testTarget(
      name: "StatKitTests",
      dependencies: ["StatKit"]
    )
  ],
  swiftLanguageVersions: [
    .v5
  ]
)
