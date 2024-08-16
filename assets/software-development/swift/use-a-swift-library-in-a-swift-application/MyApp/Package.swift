// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(name: "MyLib", path: "../MyLib")
    ],
    targets: [
        .target(
            name: "MyApp",
            dependencies: ["MyLib"])
    ]
)