# Make a Simple CLI Application in Swift

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
mkdir MyApp
cd MyApp
```

## 4. Initialize a new Swift package as executable

```sh
echo "Initializing new Swift package..."
swift package init --type executable
```

## 5. Write the application code into `./Sources/main.swift`

```swift
import Foundation

func main() {
    let arguments = CommandLine.arguments

    // The first argument is always the executable name, so we skip it
    guard arguments.count > 1 else {
        print("No arguments provided. Usage: SimpleCLI <name>")
        exit(1)
    }

    let name = arguments[1]
    print("Hello, \(name)!")
}

// Call the main function
main()
```

## 6. Compile the application and check if compilation was successful

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

## 7. Run the application

```sh
.build/debug/MyApp Lynn
```

## 8. Observe application execution

The application will print

```sh
Hello, Lynn!
```
