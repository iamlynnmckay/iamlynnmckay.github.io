# Make a Simple GUI Application in Swift

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
import SwiftUI

// Define a simple SwiftUI view
struct ContentView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.title)
            Button("Increment") {
                count += 1
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
    }
}

// Application Entry Point
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
}

// Create a standalone function to start the app
func main() {
    let appDelegate = AppDelegate()
    let application = NSApplication.shared
    application.delegate = appDelegate
    application.run()
}

main()  // Call the main function to start the application
```

## 6. Compile the application and check if compilation was successful

```sh
echo "Compiling the application..."
swift package clean
xcrun swiftc \
    -target x86_64-apple-macosx14.5 \
    -sdk $(xcrun --show-sdk-path --sdk macosx) \
    -I $(xcrun --show-sdk-path --sdk macosx)/usr/lib/swift \
    -framework SwiftUI \
    -o MyApp ./Sources/main.swift
if [ $? -eq 0 ]; then
    echo "Compilation successful."
else
    echo "Compilation failed. Please check the errors and try again."
fi
```

## 7. Run the application

```sh
./MyApp
```

## 8. Observe application execution

The application will open a new window.