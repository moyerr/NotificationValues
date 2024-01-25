// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NotificationValues",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .macCatalyst(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "NotificationValues",
            targets: ["NotificationValues"]
        ),
    ],
    targets: [
        .target(
            name: "NotificationValues",
            path: "Sources"
        ),
        .testTarget(
            name: "NotificationValuesTests",
            dependencies: ["NotificationValues"],
            path: "Tests"
        ),
    ]
)
