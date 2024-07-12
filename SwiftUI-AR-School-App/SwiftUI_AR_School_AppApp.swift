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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var locationManagerVM = LocationManagerVM()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManagerVM)
        }
    }
}
