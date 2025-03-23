// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Presentation",
  platforms: [.iOS(.v15)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "Presentation",
      targets: ["Presentation"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(path: "../Domain"),
    .package(path: "../AppDesignSystem"),
    .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.3.1"),
    .package(url: "https://github.com/BastiaanJansen/toast-swift", from: "2.1.3"),
    .package(url: "https://github.com/huri000/SwiftEntryKit", from: "2.0.0"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "Presentation",
      dependencies: [
        "Domain",
        "AppDesignSystem",
        "Kingfisher",
        "SwiftEntryKit",
        .product(name: "SnapKit", package: "SnapKit"),
        .product(name: "Toast", package: "toast-swift")
      ],
      swiftSettings: [
        .unsafeFlags(["-Xfrontend", "-strict-concurrency=targeted"])
      ]
    ),
    .testTarget(
      name: "PresentationTests",
      dependencies: ["Presentation"]
    )
  ]
)
