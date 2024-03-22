//
//  SwiftUI_AR_School_AppApp.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/7/24.
//

import SwiftUI
import MapKit

@main
@available(iOS 17.0, *)
struct SwiftUI_AR_School_AppApp: App {
    let houseCoords: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.702811, longitude: -122.467506),
        CLLocationCoordinate2D(latitude: 37.702861, longitude: -122.467506),
        CLLocationCoordinate2D(latitude: 37.702926, longitude: -122.467509),
        CLLocationCoordinate2D(latitude: 37.702994, longitude: -122.467509)
    ]
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            DestinationView(destinationVM: DestinationVM())
            AugmentedRealityView(coordinates: houseCoords)
        }
    }
}
