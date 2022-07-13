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

import Foundation
if ProcessInfo.processInfo.environment["RESOLVE_COMMAND_PLUGINS"] != nil {
    package.dependencies.append(
        .package(url: "https://github.com/elegantchaos/SwiftFormatterPlugin.git", from: "1.0.1")
    )
}
