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
    let startingPointText: String
    let destinationPointText: String
    
    @State private var mapStartRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(37.72243, -122.47819), span: MKCoordinateSpan(latitudeDelta: 0.0035, longitudeDelta: 0.0035))
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Map {
                    ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                        if (i == 0) {
                            Annotation( mapVM.vPath[i].name, coordinate: mapVM.vPath[i].coordinate,
                                        anchor: .bottom
                            ) {
                                Image(systemName: "building.2.crop.circle.fill")
                                    .padding (4)
                                    .foregroundStyle(.white)
                                    .background(Color.indigo)
                                    .cornerRadius (5)
                            }
                        } else if (i == mapVM.vPath.count-1) {
                            Annotation( mapVM.vPath[i].name, coordinate: mapVM.vPath[i].coordinate,
                                        anchor: .bottom
                            ) {
                                Image(systemName: "building.2.crop.circle.fill")
                                    .padding (4)
                                    .foregroundStyle(.white)
                                    .background(Color.indigo)
                                    .cornerRadius (5)
                            }
                        } else {
                            Annotation( "", coordinate: mapVM.vPath[i].coordinate,
                                        anchor: .bottom
                            ) {
                                Image(systemName: "figure.walk.circle.fill")
                                    .padding (4)
                                    .foregroundStyle(.white)
                                    .background(Color.yellow)
                                    .cornerRadius (15)
                            }
                        }
                    }
                }
                .mapStyle(.hybrid(elevation: .realistic))
                .edgesIgnoringSafeArea(.all)
                .border(.green)

                NavigationLink {
                    AugmentedRealityView(mapCoords: mapVM.vPath)
                        .ignoresSafeArea(.all)
                } label: {
                    Text("Tap me")
                        .frame(width: 50, height: 50)
                        .background(.thinMaterial)
                        .padding(.leading, 275)
                        .padding(.bottom, 550)
                }
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
            .ignoresSafeArea(.all)
            .border(.blue)
            
        }
        .onAppear {
            mapVM.vPath = mapVM.findClassRoute(startingPointText: startingPointText, destinationPointText: destinationPointText)
        }
       
    }
}

@available(iOS 17.0, *)
#Preview {
    MapView(startingPointText: "Admissions", destinationPointText: "Creative Arts")
}

