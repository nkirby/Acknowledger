// =======================================================
// Acknowledger
// Nathaniel Kirby
// https://github.com/nkirby/Acknowledger.git
// =======================================================

import UIKit
import XCTest
import Acknowledger

class AcknowledgerLoader: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
// =======================================================
// MARK: - Loading
    
    func testLoadingValidAcknowledgementsFileWithExtensionDoesntThrow() {
        do {
            let _ = try Acknowledger(plistFilename: "Pods-acknowledgements.plist")
            XCTAssert(true, "Didn't throw an error for Pods-acknowledgements.plist")
        } catch {
            XCTAssert(false, "Threw error of type \(error)")
        }
    }
    
    func testLoadingValidAcknowledgementsFileWithoutExtensionDoesntThrow() {
        do {
            let _ = try Acknowledger(plistFilename: "Pods-acknowledgements")
            XCTAssert(true, "Didn't throw an error for Pods-acknowledgements.plist")
        } catch {
            XCTAssert(false, "Threw error of type \(error)")
        }
    }
    
    func testLoadingInvalidAcknowledgementsFileWithExtensionDoesntThrow() {
        do {
            let _ = try Acknowledger(plistFilename: "Dummy.plist")
            XCTAssert(false, "Didn't throw an error for Dummy.plist")
        } catch {
            XCTAssert(true, "Threw error of type \(error) for Dummy.plist")
        }
    }
    
    func testLoadingInvalidAcknowledgementsFileWithoutExtensionDoesntThrow() {
        do {
            let _ = try Acknowledger(plistFilename: "Dummy")
            XCTAssert(false, "Didn't throw an error for Dummy.plist")
        } catch {
            XCTAssert(true, "Threw error of type \(error) for Dummy.plist")
        }
    }
    
    func testLoadingValidPlistObjectDoesntThrow() {
        do {
            let dict = ["PreferenceSpecifiers": [
                ["Title": "Testing"]
            ]]
            let _ = try Acknowledger(plist: dict)
            XCTAssert(true, "Didn't throw an error for a valid plist object")
        } catch {
            XCTAssert(false, "Threw error of type \(error) for valid plist object")
        }
    }
    
    func testLoadingInvalidPlistObjectThrows() {
        do {
            let dict = ["Something": [
                ["Title": "Testing"]
                ]]
            let _ = try Acknowledger(plist: dict)
            XCTAssert(false, "Didn't throw an error for a valid plist object")
        } catch {
            XCTAssert(true, "Threw error of type \(error) for valid plist object")
        }
    }
}
