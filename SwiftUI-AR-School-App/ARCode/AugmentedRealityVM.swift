//
//  AugmentedRealityVM.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/22/24.
//
import SwiftUI
import ARKit
import RealityKit
import CoreLocation


class AugmentedRealityVM: NSObject, ObservableObject {
    @Published var coordinates: [CLLocationCoordinate2D]
    private var arView: ARView?
    
    init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
        super.init()
        
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
    
    func setupARView(arView: ARView) {
        self.arView = arView
        let config = ARGeoTrackingConfiguration()
        arView.session.run(config)
        arView.session.delegate = self
    }
}

extension AugmentedRealityVM: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            print("Anchor added:", anchor)
            let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.5), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
            let geoAnchorEntity = AnchorEntity(anchor: anchor)
            geoAnchorEntity.addChild(box)
            guard let arView = arView else {
                print("ARView not available")
                return
            }
            arView.scene.addAnchor(geoAnchorEntity)
        }
    }
}

