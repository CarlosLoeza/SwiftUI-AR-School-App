//
//  DestinationView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/10/24.
//

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct DestinationView: View {
    @StateObject var destinationVM : DestinationVM
    @StateObject var locationManagerVM = LocationManagerVM()
    @State var duplicateLocations = false
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                VStack{
                    ZStack{
                        // Sf State logo
                        Image("new-state-logo")
                            .resizable()
                            .edgesIgnoringSafeArea(.bottom)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.15)
                            .padding(.bottom, geometry.size.height)
                            .padding(.trailing, geometry.size.width * 0.02)
                        // Campus photo
                        Image("sf-state-day-campus")
                            .resizable()
                            .frame(height: geometry.size.height < 700 ? geometry.size.height * 0.85 : geometry.size.height * 0.91)
                            .padding(.top, geometry.size.height * 0.06)
                        // Select starting point button
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    destinationVM.isStartingButtonClicked.toggle()
                                    destinationVM.isDestinationButtonClicked = false
                                }, label: {
                                    ZStack {
                                        Text(destinationVM.startingPointText)
                                            .font(.headline)
                                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.07)
                                            .background(RoundedRectangle(cornerRadius:8).fill(Color.white))
                                            .foregroundColor(.black)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.yellow, lineWidth: 2)
                                        )
                                      
                                        LocationPermissionButton(
                                            screenWidth: geometry.size.width,
                                            screenHeight: geometry.size.height,
                                            action: locationManagerVM.locationManager.requestPermission,
                                            authorizationStatus: locationManagerVM.locationManager.authorizationStatus
                                        )
                                            
//                                        .padding()
                                    }
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.07)
                                })
                                Spacer()
                            }
                            Spacer()
                            Spacer()
                        }
                        // UI: destination picker wheel and select button
                        VStack {
                            if destinationVM.isStartingButtonClicked {
                                DestinationPickerWheel(selectedText: $destinationVM.startingPointText, placeHolderText: "Select Starting Point", destinations: destinationVM.destinations)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
                                    .pickerStyle(.wheel)
                                    .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow, lineWidth: 2)
                                    )
                                Button(action: {
                                    destinationVM.isStartingButtonClicked = false
                                }, label: {
                                    Text(destinationVM.selectText)
                                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
                                        .foregroundColor(.black)
                                        .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.yellow, lineWidth: 2)
                                        )
                                })
                            }
                        }
                        .zIndex(1)
                        .padding(.top, geometry.size.height * 0.025)
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    destinationVM.isDestinationButtonClicked.toggle()
                                    destinationVM.isStartingButtonClicked = false
                                }, label: {
                                    Text(destinationVM.destinationPointText)
                                        .font(.headline)
                                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.07)
                                        .background(RoundedRectangle(cornerRadius:8).fill(Color.white))
                                        .foregroundColor(.black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.yellow, lineWidth: 2)
                                        )
                                        .padding()
                                })
                                Spacer()
                            }
                            Spacer()
                            Spacer()
                        }
                        
                        VStack {
                            if destinationVM.isDestinationButtonClicked {
                                DestinationPickerWheel(selectedText: $destinationVM.destinationPointText, placeHolderText: "Select Destination Point", destinations: destinationVM.destinations)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
                                    .pickerStyle(.wheel)
                                    .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow, lineWidth: 2)
                                    )
                                Button(action: {
                                    destinationVM.isDestinationButtonClicked = false
                                }, label: {
                                    Text(destinationVM.selectText)
                                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
                                        .foregroundColor(.black)
                                        .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.yellow, lineWidth: 2)
                                        )
                                })
                            }
                        }
                        .zIndex(1)
                        .padding(.top, geometry.size.height * 0.38)
                        Spacer()
                        
                        VStack{
                            Spacer()
                            Spacer()
                            Spacer()
                            if destinationVM.startingPointText != destinationVM.startingPlaceholderText && destinationVM.destinationPointText != destinationVM.destinationPlaceholderText {
                                NavigationLink(destination: MapView(startingPointText: destinationVM.startingPointText, destinationPointText: destinationVM.destinationPointText).navigationBarBackButtonHidden(true)) {
                                    Text(destinationVM.classText)
                                        .font(.headline)
                                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.06)
                                        .foregroundColor(.black)
                                        .background(RoundedRectangle(cornerRadius:8).fill(Color.yellow))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(destinationVM.lightPurple, lineWidth: 2)
                                        )
                                }
                            }
                            
                            if locationManagerVM.locationManager.authorizationStatus == .notDetermined || locationManagerVM.locationManager.authorizationStatus == .restricted {
                                    Button(action: {
                                        locationManagerVM.locationManager.requestPermission()
                                    }) {
                                        Text("Allow Location Access")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                            } else if locationManagerVM.locationManager.authorizationStatus == .denied {
                                Button(action: {
                                    locationManagerVM.locationManager.showAlert = true
                                    print("inside denied")
                                    print(locationManagerVM.locationManager.showAlert)
                                }) {
                                    Text("Allow Location Access")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            Button("Open Settings") {
                                // Get the settings URL and open it
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            LocationButton(width: geometry.size.width, height: geometry.size.height)
                            Spacer()
                            
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 60.0/255, green: 58.0/255, blue: 100.0/255))
                .onAppear{
                    destinationVM.startingPointText = "Select Starting Point"
                    destinationVM.destinationPointText = "Select Destination Point"
                }
                .alert(isPresented: $locationManagerVM.locationManager.showAlert) {
                            Alert(
                                title: Text("Location Access Denied"),
                                message: Text("To enable location access, please go to Settings and allow location access for this app."),
                                primaryButton: .default(Text("Settings"), action: {
                                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    }
                                }),
                                secondaryButton: .cancel()
                            )
                        }
            }
        }
    }
}


struct LocationButton: View {
    let width: CGFloat
    let height: CGFloat
    
    var body : some View {
        Button {
            
        } label: {
            Image(systemName: "location.fill")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.055, height: height * 0.055)
//                .border(Color.black)
                .padding(.leading, width * 0.7)
        }
    }
}

struct LocationImage: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var body: some View {
        Image(systemName: "location.fill")
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth * 0.055, height: screenHeight * 0.055)
            .padding(.leading, screenWidth * 0.7)
    }
}

struct LocationPermissionButton: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    var action: () -> Void
    var authorizationStatus: CLAuthorizationStatus

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.055, height: screenHeight * 0.055)
                .padding(.leading, screenWidth * 0.7)
        }
    }

    private var imageName: String {
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            return "location.fill" // Image 1 for authorized
        case .notDetermined:
            return "location" // Image 2 for not determined
        case .denied, .restricted:
            return "location.slash" // Image 3 for denied
        @unknown default:
            return "questionmark" // Default case for unknown statuses
        }
    }
}


@available(iOS 17.0, *)
#Preview {
    DestinationView(destinationVM: DestinationVM())
}
