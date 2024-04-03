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
        VStack{
            Map {
                ForEach(0..<mapVM.vPath.count, id: \.self) { i in
                    // decide what map annotation to show based on i
                    mapVM.decideAnnotationType(i: i)
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            mapVM.vPath = mapVM.findClassRoute(startingPointText: startingPointText, destinationPointText: destinationPointText)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    MapView(startingPointText: "Admissions", destinationPointText: "Creative Arts")
}

