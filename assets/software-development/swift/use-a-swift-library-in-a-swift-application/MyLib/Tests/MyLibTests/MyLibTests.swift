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