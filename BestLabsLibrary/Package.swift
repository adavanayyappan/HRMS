// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BestLabsLibrary",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "BestLabsLibrary",
            targets: ["BestLabsLibrary"]),
    ],
    targets: [
        .target(
            name: "BestLabsLibrary"),

    ]
)
