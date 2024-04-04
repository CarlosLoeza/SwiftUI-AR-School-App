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
    let startingPointText: String
    let destinationPointText: String

    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack{
                    Map(position: $campusPositionStart) {
                        ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                            // decide what map annotation to show based on i
                            mapVM.decideAnnotationType(i: i)
                        }
                    }
                    .mapStyle(.hybrid(elevation: .realistic))
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        // go to AR view
                        NavigationLink {
                            AugmentedRealityView(mapCoords: mapVM.vPath)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            MapImageButton(imageName: "binoculars.fill")
                        }
                        // go to previous screen, selecting destination
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            MapImageButton(imageName: "map.fill")
                        })
                        
                        Spacer()
                    }
                    .padding(.leading, geometry.size.width * 0.75)
                    .padding(.top, geometry.size.height * 0.8)
                    .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                }
//                .ignoresSafeArea(.all)
            }
        }
        .onAppear {
            mapVM.vPath = mapVM.findClassRoute(startingPointText: startingPointText, destinationPointText: destinationPointText)
        }
    }
}

struct MapImageButton: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .padding(5)
            .background(.regularMaterial)
    }
}


@available(iOS 17.0, *)
#Preview {
    MapView(startingPointText: "Admissions", destinationPointText: "Creative Arts")
}

