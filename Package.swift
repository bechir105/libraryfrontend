// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "libraryFrontend",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "libraryFrontend",
            targets: ["libraryFrontend"]
        ),
    ],
    targets: [
        .target(
            name: "libraryFrontend",
            path: "Sources/libraryFrontend"
        ),
        .testTarget(
            name: "libraryFrontendTests",
            dependencies: ["libraryFrontend"],
            path: "Tests/libraryFrontendTests"
        ),
    ]
)
