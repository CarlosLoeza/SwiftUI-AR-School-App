//
//  ContentView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/7/24.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View{
//        LoginView(loginVM: LoginVM())
//    }
//}
@available(iOS 17.0, *)
struct ContentView: View {
    @EnvironmentObject var locationManagerVM: LocationManagerVM
    @AppStorage("signIn") private var isSignIn = false

    var body: some View {
        VStack {
            if !isSignIn {
                LoginView(loginVM: LoginVM())
                    .environmentObject(locationManagerVM)
            } else {
                DestinationView()
                    .environmentObject(locationManagerVM)
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ContentView()
}
