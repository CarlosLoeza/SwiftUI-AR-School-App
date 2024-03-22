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
    let coordinates: [CLLocationCoordinate2D]
    
    init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
        guard ARGeoTrackingConfiguration.isSupported else {
            print("ARGeoTracking is not supported")
            return
        }
        
        
        ARGeoTrackingConfiguration.checkAvailability { available, error in
            if let error = error {
                print("ARGeoTracking availability error:", error)
            } else if available {
                print("ARGeoTracking is available")
            } else {
                print("ARGeoTracking is not available")
            }
        }
    }
   
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.session.delegate = context.coordinator
        context.coordinator.arView = arView
        let config = ARGeoTrackingConfiguration()
        arView.session.run(config)
        
        // Configure AR view and add coaching overlay
        arView.setupCoachingOverlay(for: arView)
        
        for coordinate in coordinates {
            let geoAnchor = ARGeoAnchor(coordinate: coordinate)
                arView.session.add(anchor: geoAnchor)
        }
        
        return arView
    }
   
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
   
    func updateUIView(_ uiView: ARView, context: Context) {}
}

class Coordinator: NSObject, ARSessionDelegate {
   
    weak var arView: ARView?
   
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {

        for anchor in anchors {
            print("Anchor added:", anchor)
            // create box we will attach to location
            let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.5), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
            // add location to geoAnchor
            let geoAnchorEntity = AnchorEntity(anchor: anchor)
            // add box to geoAnchor
            geoAnchorEntity.addChild(box)
            // make sure we have our arView instance
            guard let arView = arView else {
                print("ARView not available")
                return
            }
            // add geoAnchor to our
            arView.scene.addAnchor(geoAnchorEntity)
        }
    }
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
