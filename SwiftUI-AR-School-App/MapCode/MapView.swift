//
//  MapView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/11/24.
//

import SwiftUI
import MapKit



/*
 "Admissions": 0,
 "Burk Hall": 31,
 "Business": 1,
 "Creative Arts": 19,
 "Cesar Chavez Student Center": 13,
 "Fine Arts": 21,
//                            "Humanities": 0, // change this
 "J. Paul Leonard Library": 5
 */

@available(iOS 17.0, *)
struct MapView: View {
    @StateObject var mapVM = MapVM()
    let startingPointText: String
    let destinationPointText: String
    
    @State private var mapStartRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(37.72243, -122.47819), span: MKCoordinateSpan(latitudeDelta: 0.0035, longitudeDelta: 0.0035))
    
    
    
    var body: some View {
        VStack{
            /*
            Map(coordinateRegion: $mapStartRegion, annotationItems: locations) {location in
                MapMarker(coordinate: location.coordinate)
            }
             */
            Map {
                ForEach(0..<locations.count, id: \.self) { i in
                    //                MapAnnotation(coordinate: location.coordinate) {
                    //                    VStack {
                    //                        Image(systemName: "figure.walk.circle.fill")
                    //                            .resizable()
                    //                            .frame(width: 30, height: 30)
                    //                            .foregroundColor(.yellow)
                    //
                    //
                    //
                    //                    }
                    //
                    //                }
                    
                    if (i == 0) {
                        Annotation( locations[i].name, coordinate: locations[i].coordinate,
                                    anchor: .bottom
                        ) {
                            Image(systemName: "building.2.crop.circle.fill")
                                .padding (4)
                                .foregroundStyle(.white)
                                .background(Color.indigo)
                                .cornerRadius (5)
                        }
                    } else if (i == locations.count-1) {
                        Annotation( locations[i].name, coordinate: locations[i].coordinate,
                                    anchor: .bottom
                        ) {
                            Image(systemName: "building.2.crop.circle.fill")
                                .padding (4)
                                .foregroundStyle(.white)
                                .background(Color.indigo)
                                .cornerRadius (5)
                        }
                    } else {
                        Annotation( locations[i].name, coordinate: locations[i].coordinate,
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
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            mapVM.path = mapVM.findClassRoute(startingPointText: startingPointText, destinationPointText: destinationPointText)
        }
       
    }
}

@available(iOS 17.0, *)
#Preview {
    MapView(startingPointText: "Admissions", destinationPointText: "Creative Arts")
}
