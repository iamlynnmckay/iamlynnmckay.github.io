# Use a Swift Library in a Swift Application

## 1. Create the Swift application and library 

See [How to Make a Simple CLI Application in Swift]() to create the application and [How to Make a Simple Library in Swift]().

Ensure that both the application directory and the library directory have the same parent directory.

## 1. Edit the application's `./MyApp/Package.swift` to depend on the library

### 1.1. Option 1: Using the Swift Package Manager (SPM)

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/username/MyLib.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "MyApp",
            dependencies: ["MyLib"])
    ]
)
```

### 1.2. Option 2: Using a local library

```swift
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
```

## 2. Edit the application's `./MyApp/Sources/main.swift` to include and use the library

```swift
import Foundation
import MyLib

func main() {
    print(MyLib.sayHello())
}

// Call the main function
main()
```

## 3. Move the application's `main.swift` from `./MyApp/Sources/main.swift` to `./MyApp/Sources/MyApp/main.swift` 

```sh
mkdir -p MyApp/Sources/MyApp
mv MyApp/Sources/main.swift MyApp/Sources/MyApp/main.swift
```
`
## 3. Build and run your application

```sh
cd MyApp
swift package clean
swift build
swift run
```

## 8. Observe application execution

The application will print

```sh
Hello, Lynn!
```

