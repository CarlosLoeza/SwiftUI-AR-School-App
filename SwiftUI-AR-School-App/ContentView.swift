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
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            if !isSignIn {
                LoginView(loginVM: LoginVM())
            } else {
                TabView(selection: $selectedTab) {
                    DestinationView(selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "figure.walk")
                            Text("Path")
                        }
                        .tag(0)
                    
                    MapView(selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "map")
                            Text("Map")
                        } 
                        .tag(1)
                    
                    Settings()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                        .tag(2)
                }
                .onAppear {
                    UITabBar.appearance().backgroundColor = .systemGray2
                }
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ContentView()
}
