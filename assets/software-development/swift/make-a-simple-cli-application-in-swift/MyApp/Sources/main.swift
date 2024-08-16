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