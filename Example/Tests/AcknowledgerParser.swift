// =======================================================
// Acknowledger
// Nathaniel Kirby
// https://github.com/nkirby/Acknowledger.git
// =======================================================

import XCTest
import Acknowledger

// =======================================================

class AcknowledgerParser: XCTestCase {
    private var acknowledger: Acknowledger?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.acknowledger = try! Acknowledger(plistFilename: "Pods-acknowledgements.plist")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.acknowledger = nil
    }
    
// =======================================================
// MARK: - Library Retrieval

    func testAllLibraries() {
        let libs = self.acknowledger?.allLibraries() ?? [Library]()
        XCTAssert(libs.count > 0, "allLibraries() returned libraries")
    }

    func testLibraryNames() {
        let libraryNames = self.acknowledger?.libraryNames() ?? [String]()
        XCTAssert(libraryNames.count > 0, "libraryNames() returned library names")
        
        if libraryNames.indexOf("RealmSwift") != nil {
            XCTAssert(true, "libraryNames() returned library names including 'RealmSwift'")
        } else {
            XCTAssert(false, "libraryNames() either returned invalid library names, or is missing libraries")
        }
    }
    
    func testLibraryWithName() {
        if let _ = self.acknowledger?.libraryWithName("AFNetworking") {
            XCTAssert(true, "Library 'AFNetworking' found")
        } else {
            XCTAssert(false, "Library 'AFNetworking' not found")
        }
        
        if let _ = self.acknowledger?.libraryWithName("TestLibrary") {
            XCTAssert(false, "Library 'TestLibrary' found")
        } else {
            XCTAssert(true, "Library 'TestLibrary' not found")
        }
    }
    
    func testLicenseForLibrary() {
        if let _ = self.acknowledger?.licenseForLibrary("JLRoutes") {
            XCTAssert(true, "Returned a license for 'JLRoutes'")
        } else {
            XCTAssert(false, "Didn't return a license for 'JLRoutes'")
        }
    }
}
