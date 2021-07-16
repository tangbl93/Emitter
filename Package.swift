// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Emitter",
    platforms: [
        .macOS(.v10_11),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(name: "Emitter", targets: ["Emitter"])
    ],
    targets: [
        .target(
            name: "Emitter",
            dependencies: [],
            path: "Emitter",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("Core"),
            ]
        ),
    ]
)
