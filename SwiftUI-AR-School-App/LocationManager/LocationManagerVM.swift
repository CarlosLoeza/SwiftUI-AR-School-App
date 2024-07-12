//
//  LocationManager.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 7/9/24.
//

import SwiftUI
import CoreLocation

// LocationManager class is used to handle location permissions
class LocationManagerVM: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager() // CLLocationManager instance to handle location services
    
    // Published property to track the authorization status. SwiftUI views will update when this changes.
    @Published var authorizationStatus: CLAuthorizationStatus
    // Published property shows an alert box when the user has denied location access
    @Published var showAlert: Bool = false
    // Published property is used to save the user's location
    @Published var currentLocation: CLLocationCoordinate2D?

    // Initializer for the LocationManager class
    override init() {
        // Initialize authorizationStatus with the current authorization status
        self.authorizationStatus = CLLocationManager.authorizationStatus()
        super.init() // Call to superclass initializer
        self.locationManager.delegate = self // Set the delegate to self to handle CLLocationManagerDelegate methods
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Function to request location permissions
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization() // Request permission to use location services when the app is in use
    }
    
    func startUpdatingLocation() {
           locationManager.startUpdatingLocation()
       }
       
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // Delegate method that gets called when the authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            // Update the published authorizationStatus property, ensuring it happens on the main thread
            self.authorizationStatus = status
            // If our location status is denied, show the alert box
            if self.authorizationStatus == .denied {
                self.showAlert = true
                self.currentLocation = nil
            } else if self.authorizationStatus == .authorizedWhenInUse || self.authorizationStatus == .authorizedAlways {
                self.startUpdatingLocation()
            } else if self.authorizationStatus == .notDetermined {
                self.currentLocation = nil
            }
        }
    }
    
    // Delegate method that gets called when new location data is available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.currentLocation = location.coordinate
                self.stopUpdatingLocation() // Stop updates to save battery life
            }
        }
    }
}



