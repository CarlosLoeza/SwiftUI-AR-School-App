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

struct AugmentedRealityView: UIViewRepresentable {
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
            let gAnchor = ARGeoAnchor(coordinate: mapCoord.coordinate)
            arView.session.add(anchor: gAnchor)
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
