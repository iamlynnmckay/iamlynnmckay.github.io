# Make a Simple Library in Swift

## 1. Check for Xcode Command Line Tools and install if not present

```sh
if ! xcode-select -p; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
    read -p "Press [Enter] key after installation has finished."
else
    echo "Xcode Command Line Tools found."
fi
```

## 2. Verify Swift installation

```sh
if ! which swift > /dev/null; then
    echo "Swift is not installed. Please install Xcode from the App Store."
    exit 1
fi
```

## 3. Create project directory

```sh
echo "Creating project directory..."
mkdir MyLib
cd MyLib
```

## 4. Initialize a new Swift package as a library

```sh
echo "Initializing new Swift package..."
swift package init --type library
```

## 5. Write the library code into `./Sources/MyLib/MyLib.swift`

```swift
public struct MyLib {
    public static func sayHello() -> String {
       return "Hello from MyLib!";
    }
}
```

## 6. Write the library test code into `./Tests/MyLibTests/MyLibTests.swift`

```swift
import XCTest
@testable import MyLib

final class MyLibTests: XCTestCase {
    
    // Test for the `sayHello` function
    func testSayHello() {
        // Capture the result of calling the library function
        let result = MyLib.sayHello()
        
        // Check that the output is as expected
        XCTAssertEqual(result, "Hello from MyLib!", "The sayHello function should return: 'Hello from MyLib!'")
    }
    
    // Other tests can be added here as needed
}
```

## 7. Compile the library and check if compilation was successful

```sh
echo "Compiling the application..."
swift package clean
swift build
if [ $? -eq 0 ]; then
    echo "Compilation successful."
else
    echo "Compilation failed. Please check the errors and try again."
fi
```

## 8. Run the library tests 

```sh
swift test
```

## 9. Observe test execution 

The tests will all pass without error.