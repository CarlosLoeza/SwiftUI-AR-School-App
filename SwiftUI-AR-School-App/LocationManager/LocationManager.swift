//
//  LocationManager.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 7/9/24.
//

import SwiftUI
import CoreLocation

// LocationManager class is used to handle location permissions
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager() // CLLocationManager instance to handle location services
    
    // Published property to track the authorization status. SwiftUI views will update when this changes.
    @Published var authorizationStatus: CLAuthorizationStatus
    // Published property shows an alert box when the user has denied location access
    @Published var showAlert: Bool = false

    // Initializer for the LocationManager class
    override init() {
        // Initialize authorizationStatus with the current authorization status
        self.authorizationStatus = CLLocationManager.authorizationStatus()
        super.init() // Call to superclass initializer
        self.locationManager.delegate = self // Set the delegate to self to handle CLLocationManagerDelegate methods
    }
    
    // Function to request location permissions
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization() // Request permission to use location services when the app is in use
    }
    
    // Delegate method that gets called when the authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            // Update the published authorizationStatus property, ensuring it happens on the main thread
            self.authorizationStatus = status
            // If our location status is denied, show the alert box
            
        }
    }
}



