//
//  SwiftUI_AR_School_AppUITests.swift
//  SwiftUI-AR-School-AppUITests
//
//  Created by Carlos on 3/7/24.
//

import XCTest


final class SwiftUI_AR_School_AppUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

//
    func testSelectStartingPointText() throws {

        let button = app.buttons["Select Starting Point"]

        // Verify the text on the button
        XCTAssertEqual(button.label, "Select Starting Point")
    }
//    
    func testSelectDestinationPointText() throws {

        let button = app.buttons["Select Destination Point"]

        // Verify the text on the button
        XCTAssertEqual(button.label, "Select Destination Point")
    }
    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
