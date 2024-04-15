//
//  DestinationView_UITests.swift
//  SwiftUI-AR-School-AppUITests
//
//  Created by Carlos on 4/11/24.
//

import XCTest

final class DestinationView_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_DestinationView_FindClassButton_ShouldContinue() {

    }
    
    func test_DestinationView_FindClassButton_DoesNotExist(){
        let findButton = app.buttons["Find Class"]
        XCTAssertFalse(findButton.exists)
    }
    
    func test_DestinationView_StartingPointButton_showPickerRoll(){
        let startingPointButton = app.buttons["Select Starting Point"]
        let pickerStartingPickerWheel = app.pickerWheels["-- Select One --"]
        
        startingPointButton.tap()
        XCTAssertTrue(pickerStartingPickerWheel.exists)
    }
    
    func test_DestinationView_DestinationPointButton_showPickerRoll(){
        let destinationPointButton = app.buttons["Select Destination Point"]
        let pickertDestinationWheel = app.pickerWheels["-- Select One --"]
        
        destinationPointButton.tap()
        XCTAssertTrue(pickertDestinationWheel.exists)
    }
    
    func test_DestinationView_StartingPoint_selectAdmission(){
        var startingPointButton = app.buttons["Select Starting Point"]
        var pickerStartingPickerWheel = app.pickerWheels["-- Select One --"]
        let selectButton = app.buttons["Select"]
        
        startingPointButton.tap()
        pickerStartingPickerWheel.adjust(toPickerWheelValue: "Admissions")
        selectButton.tap()
        
        XCTAssertTrue(app.buttons["Admissions"].exists)
    }
    
    func test_DestinationView_DestinationPoint_selectBurkHall(){
        let destinationPointButton = app.buttons["Select Destination Point"]
        var pickerDestinationPickerWheel = app.pickerWheels["-- Select One --"]
        let selectButton = app.buttons["Select"]
        
        destinationPointButton.tap()
        pickerDestinationPickerWheel.adjust(toPickerWheelValue: "Burk Hall")
        selectButton.tap()
        
        XCTAssertTrue(app.buttons["Burk Hall"].exists)
    }
    
    func test_DestinationView_FindClassButton_DoesExist(){
        let startingPointButton = app.buttons["Select Starting Point"]
        let pickerStartingPickerWheel = app.pickerWheels["-- Select One --"]
        let destinationPointButton = app.buttons["Select Destination Point"]
        let pickerDestinationPickerWheel = app.pickerWheels["-- Select One --"]
        let selectButton = app.buttons["Select"]
        
        startingPointButton.tap()
        pickerStartingPickerWheel.adjust(toPickerWheelValue: "Admissions")
        selectButton.tap()
        destinationPointButton.tap()
        pickerDestinationPickerWheel.adjust(toPickerWheelValue: "Burk Hall")
        selectButton.tap()
        
        let findButton = app.buttons["Find Class"]
        XCTAssertTrue(findButton.exists)
    }
}
