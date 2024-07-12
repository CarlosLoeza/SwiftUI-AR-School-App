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
                    .environmentObject(locationManagerVM)
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
//                            Image(systemName: "magnifyingglass")
                            Text("Map")
                        }
                        .tag(1)
                }
                .onAppear {
                    UITabBar.appearance().backgroundColor = .systemGray2
                }
//                DestinationView()
//                    .environmentObject(locationManagerVM)
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ContentView()
}
