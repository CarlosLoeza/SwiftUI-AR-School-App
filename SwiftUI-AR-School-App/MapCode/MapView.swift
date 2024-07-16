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
    
    @State private var selectedButton: String = ""

    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack{
                    Map(position: $campusPositionStart ) {
                        if ((startingPointText != nil || destinationPointText != nil) && selectedButton == "") {
                            ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                                mapVM.decideAnnotationType(i: i)
                            }
                        } else if selectedButton == "Bathroom"{
                            ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                                mapVM.annotateCampusLocations(i: i, image: "figure.dress.line.vertical.figure")
                            }
                        } else if ((selectedButton == "Buildings" || selectedButton == "") && (startingPointText == nil || destinationPointText == nil)){
                            ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                                mapVM.annotateCampusLocations(i: i, image: "building.2.fill")
                            }
                        }
                        
                    }
                    .mapControls{
                        MapUserLocationButton()
                           
                    }
                    .mapStyle(.hybrid(elevation: .realistic))
                    MapIconBar(mapVM: mapVM, selectedButton: $selectedButton)
//                    VStack {
//                        Spacer()
//                        // go to AR view
//                        NavigationLink {
//                            AugmentedRealityView(mapCoords: mapVM.vPath)
//                                .navigationBarBackButtonHidden(true)
//                                .ignoresSafeArea(.all)
//                        } label: {
//                            MapImageButton(imageName: "binoculars.fill")
//                        }
//                        
//                        
//                        // go to previous screen, selecting destination
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                            selectedTab = 0
//                        }, label: {
//                            MapImageButton(imageName: "figure.walk.circle.fill")
//                        })
////
//                        Spacer()
//                    }
//                    .padding(.leading, geometry.size.width * 0.75)
//                    .padding(.top, geometry.size.height * 0.8)
//                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                }
                .mapStyle(.hybrid(elevation: .realistic))
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
        }
        .onAppear {
            CLLocationManager().requestWhenInUseAuthorization()
            if (startingPointText != nil || destinationPointText != nil){
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

