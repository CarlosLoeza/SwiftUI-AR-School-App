import XCTest
import CoreLocation

// By using @testable, you can access the internal properties and methods of your app.
@testable import SwiftUI_AR_School_App

// The test class must inherit from XCTestCase.
final class MapVMTests: XCTestCase {

    // Create a single instance of the VM to use in all tests.
    // This is more efficient.
    let mapVM = MapVM()

    func testFindClassRoute_FromAdmissionsToLibrary_ShouldReturnCorrectIndices() {
        // MARK: - 1. Arrange
        let startPoint = "Admissions"
        let endPoint = "J. Paul Leonard Library"
        
        // The expected path, defined by the vertex indices from your graph.
        // This is the "ground truth" of your algorithm.
        let expectedPathIndices = [0, 1, 2, 3, 4, 5]

        // MARK: - 2. Act
        let actualPathLocations = mapVM.findClassRoute(startingPointText: startPoint, destinationPointText: endPoint)

        // MARK: - 3. Assert
        
        // Helper step: Convert the resulting [Locations] back into an array of indices.
        // This makes the test independent of the 'name' property.
        let actualPathIndices = actualPathLocations.map { location in
            // Find the index of the current location in the main locations array.
            // We use firstIndex(where:) because Locations is not inherently Equatable without a custom implementation.
            mapVM.locations.firstIndex(where: { $0.id == location.id }) ?? -1 // Return -1 if not found
        }
        
        // Assert that the sequence of indices is correct.
        XCTAssertEqual(actualPathIndices, expectedPathIndices, "The path indices from Admissions to Library are incorrect.")
    }
    
    func testFindClassRoute_FromAdmissionsToBusiness_ShouldReturnCorrectIndices() {
        // MARK: - 1. Arrange
        let startPoint = "Admissions"
        let endPoint = "Business"
        
        let expectedPathIndices = [0, 1]

        // MARK: - 2. Act
        let actualPathLocations = mapVM.findClassRoute(startingPointText: startPoint, destinationPointText: endPoint)

        // MARK: - 3. Assert
        let actualPathIndices = actualPathLocations.map { location in
            mapVM.locations.firstIndex(where: { $0.id == location.id }) ?? -1
        }
        
        XCTAssertEqual(actualPathIndices, expectedPathIndices, "The path indices from Admissions to Business are incorrect.")
    }
}
