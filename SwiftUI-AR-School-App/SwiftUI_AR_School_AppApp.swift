//
//  SwiftUI_AR_School_AppApp.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/7/24.
//

import SwiftUI

@main
@available(iOS 17.0, *)
struct SwiftUI_AR_School_AppApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            DestinationView(destinationVM: DestinationVM())
        }
    }
}
