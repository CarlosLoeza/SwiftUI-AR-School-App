//
//  ARView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/15/24.
//

import SwiftUI
import ARKit
import RealityKit
import CoreLocation

@available(iOS 17.0, *)
struct AugmentedRealityView: View {
    let mapCoords: [Locations]
    @StateObject var viewModel: AugmentedRealityVM
    @Environment(\.presentationMode) var presentationMode
    
    init(mapCoords: [Locations]) {
        self.mapCoords = mapCoords
        self._viewModel = StateObject(wrappedValue: AugmentedRealityVM(mapCoords: mapCoords))
    }
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {
                    ARViewRepresentable(mapCoords: mapCoords)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        // go to AR view
                        NavigationLink {
//                            DestinationView(destinationVM: DestinationVM())
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            MapImageButton(imageName: "figure.walk.circle.fill")
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
            }
        }
    }
}

struct ARViewRepresentable: UIViewRepresentable {
    let mapCoords: [Locations]
    @StateObject var viewModel: AugmentedRealityVM
   
    init(mapCoords: [Locations]) {
        self.mapCoords = mapCoords
        self._viewModel = StateObject(wrappedValue: AugmentedRealityVM(mapCoords: mapCoords))
    }
   
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        viewModel.setupARView(arView: arView)
        arView.setupCoachingOverlay(for: arView)

        for mapCoord in mapCoords {
            let geoAnchor = ARGeoAnchor(coordinate: mapCoord.coordinate)
            arView.session.add(anchor: geoAnchor)
        }
        
        return arView
    }
   
    func updateUIView(_ uiView: ARView, context: Context) {}
}

extension ARView {
    func setupCoachingOverlay(for arView: ARView) {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .geoTracking
        arView.addSubview(coachingOverlay)
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: arView.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: arView.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: arView.heightAnchor),
        ])
    }
}
