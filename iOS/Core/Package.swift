// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "Core"

let platforms: [SupportedPlatform] = [.iOS(.v17)]

let products: [Product] = [.library(name: name, targets: [name])]

let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.28.0"),
    .package(url: "https://github.com/hmlongco/Factory", from: "2.3.2")
]

let targetDependencies: [Target.Dependency] = [
    .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
    .product(name: "FirebaseDatabaseSwift", package: "firebase-ios-sdk"),
    .product(name: "Factory", package: "factory")
]

let targetTestDependencies: [Target.Dependency] = [.init(stringLiteral: name)]

let targets: [Target] = [
    .target(name: name,
            dependencies: targetDependencies,
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
