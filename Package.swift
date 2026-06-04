// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IosAwnCore",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "IosAwnCore", targets: ["IosAwnCore"])
    ],
    targets: [
        .target(
            name: "IosAwnCore",
            // Reuse the existing CocoaPods source tree so the same files feed both
            // Swift Package Manager and the IosAwnCore.podspec during the transition.
            path: "IosAwnCore/Classes"
        )
    ]
)
