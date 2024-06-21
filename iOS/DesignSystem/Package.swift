// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "DesignSystem"

let platforms: [SupportedPlatform] = [.iOS(.v17)]

let products: [Product] = [.library(name: name, targets: [name])]

let dependencies: [Package.Dependency] = [
    .package(name: "Core", path: "../Core")
]

let targetDependencies: [Target.Dependency] = [
    "Core"
]

let targetTestDependencies: [Target.Dependency] = [.init(stringLiteral: name)]

let targets: [Target] = [
    .target(name: name,
            dependencies: targetDependencies,
            resources: [.process("Resources")],
            swiftSettings: [
                .unsafeFlags(["-enable-testing"])
            ]),
    .testTarget(name: "\(name)Tests", dependencies: targetTestDependencies)
]

let swiftLanguageVersions: [SwiftVersion] = [.v5]

let package = Package(name: name,
                      platforms: platforms,
                      products: products,
                      dependencies: dependencies,
                      targets: targets,
                      swiftLanguageVersions: swiftLanguageVersions)
