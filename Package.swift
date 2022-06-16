// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "PageView",
    platforms: [
        .macCatalyst(.v15), .iOS(.v15)
    ],
    products: [
        .library(
            name: "PageView",
            targets: ["PageView"]),
    ],

    dependencies: [
    ],

    targets: [
        .target(
            name: "PageView",
            dependencies: []),
    ]
)
