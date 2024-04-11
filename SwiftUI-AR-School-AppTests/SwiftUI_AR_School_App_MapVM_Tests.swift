//
//  SwiftUI_AR_School_App_MapVM_Tests.swift
//  SwiftUI-AR-School-AppTests
//
//  Created by Carlos on 4/10/24.
//

import XCTest
@testable import SwiftUI_AR_School_App

final class SwiftUI_AR_School_App_MapVM_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Admission to Burk Hall Tests
    func test_MapVM_FindClassRoute_AdmissionToBurkHall_NotEmpty() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Burk Hall")
        
        XCTAssertFalse(path.isEmpty, "Our path should not be empty.")
    }
    func test_MapVM_FindClassRoute_AdmissionToBurkHallPath_CorrectPathCount() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Burk Hall")
        XCTAssertEqual(path.count, 21)
    }
    
    // Admissions to Business Tests
    func test_MapVM_FindClassRoute_AdmissionToBusinessPath_NotEmpty() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Business")
        XCTAssertFalse(path.isEmpty)
    }
    func test_MapVM_FindClassRoute_AdmissionToBusinessPath_CorrectPathCount() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Business")
        XCTAssertEqual(path.count, 2)
    }
    
    // Admissions to Creative Arts Tests
    func test_MapVM_FindClassRoute_AdmissionToCreativeArtsPath_NotNil() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Creative Arts")
        XCTAssertNotNil(path)
    }
    func test_MapVM_FindClassRoute_AdmissionToCreativeArtsPath_CorrectPathCount() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Creative Arts")
        XCTAssertEqual(path.count, 13)
    }
    
    // Admissions to Cesar Chavez Student Center Tests
    func test_MapVM_FindClassRoute_AdmissionToCesarChavezPathNotNil() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Cesar Chavez Student Center")
        XCTAssertNotNil(path)
    }
    func test_MapVM_FindClassRoute_AdmissionToCesarChavezPath_CorrectPathCount() {
        let mapVM = MapVM()
        let path = mapVM.findClassRoute(startingPointText: "Admissions", destinationPointText: "Cesar Chavez Student Center")
        XCTAssertEqual(path.count, 11)
    }

}
