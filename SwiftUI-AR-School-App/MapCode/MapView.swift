//
//  MapView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/11/24.
//

import SwiftUI
import MapKit


@available(iOS 17.0, *)
struct MapView: View {
    @StateObject var mapVM = MapVM()
    @Environment(\.presentationMode) var presentationMode
    @State var campusPositionStart: MapCameraPosition = .automatic
    @State private var userPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @EnvironmentObject var locationManagerVM : LocationManagerVM
    @Binding var selectedTab: Int
    
    var startingPointText: String?
    var destinationPointText: String?
    
    @State private var selectedButton: String? = nil

    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack{
                    Map(position: $campusPositionStart ) {
                        if startingPointText == nil || destinationPointText == nil {
                            ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                                // decide what map annotation to show based on i
                                mapVM.annotateBuildings(i: i, image: "building.2.crop.circle.fill" )
                            }
                        } else {
                            ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                                mapVM.decideAnnotationType(i: i)
                            }
                        }
                        
                    }
                    .mapControls{
                        MapUserLocationButton()
                           
                    }
                    .mapStyle(.hybrid(elevation: .realistic))
//                    .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack {
                        Spacer()
                            HStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        MapIconButton(icon: "building.2.fill", label: "Buildings", isSelected: selectedButton == "Buildings") {
                                            selectedButton = "Buildings"
                                        }
                                        .frame(width: 80, height: 100)
                                        MapIconButton(icon: "figure.dress.line.vertical.figure", label: "Bathroom", isSelected: selectedButton == "Bathroom") {
                                            selectedButton = "Bathroom"
                                        }
                                        .frame(width: 80, height: 100)
                                        MapIconButton(icon: "takeoutbag.and.cup.and.straw.fill", label: "Food", isSelected: selectedButton == "Food") {
                                            selectedButton = "Food"
                                        }
                                        .frame(width: 80, height: 100)
                                        MapIconButton(icon: "person.2.fill", label: "Events", isSelected: selectedButton == "Events") {
                                            selectedButton = "Events"
                                        }
                                        .frame(width: 80, height: 100)
                                    }
                                    .padding(.leading, 15)
                                    .padding(.bottom, -5)
                                }
                                .padding(5)
                                Spacer()
                        }
                        .background(Color(.systemGray6).opacity(0.8))
                        .cornerRadius(20)
                        .shadow(radius: 10)
        //                .offset(y: isSlideUpViewVisible ? 0 : 300) // Adjust the offset value as needed
        //                .animation(.easeInOut)
                        
                    }
                    .padding(3)
                    
                    
                    VStack {
                        Spacer()
                        // go to AR view
//                        NavigationLink {
//                            AugmentedRealityView(mapCoords: mapVM.vPath)
//                                .navigationBarBackButtonHidden(true)
//                                .ignoresSafeArea(.all)
//                        } label: {
//                            MapImageButton(imageName: "binoculars.fill")
//                        }
                        
                        
                        // go to previous screen, selecting destination
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                            selectedTab = 0
//                        }, label: {
//                            MapImageButton(imageName: "figure.walk.circle.fill")
//                        })
//                        
                        Spacer()
                    }
                    .padding(.leading, geometry.size.width * 0.75)
                    .padding(.top, geometry.size.height * 0.8)
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                }
                .mapStyle(.hybrid(elevation: .realistic))
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
        }
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
            if (startingPointText != nil || destinationPointText != nil){
                print("starting: \(startingPointText)")
                print("destination: \(destinationPointText)")
                mapVM.vPath = mapVM.findClassRoute(startingPointText: startingPointText!, destinationPointText: destinationPointText!, currentLocation: locationManagerVM.currentLocation)
            } else {
                mapVM.vPath = mapVM.getSchoolBuildings()
            }
           
        }
    }
}



//@available(iOS 17.0, *)

//#Preview {
//    @State var selectedTab = 2
//    MapView(selectedTab: $selectedTab, startingPointText: "Admissions", destinationPointText: "Creative Arts")
//}

