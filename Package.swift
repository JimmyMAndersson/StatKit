// swift-tools-version:6.0

import PackageDescription

let package = Package(
  name: "StatKit",
  platforms: [
    .macCatalyst(.v17),
    .macOS(.v14),
    .iOS(.v17),
    .tvOS(.v17),
    .watchOS(.v10),
    .visionOS(.v2)
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
  swiftLanguageModes: [
    .v6
  ]
)
