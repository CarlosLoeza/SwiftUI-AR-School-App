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

// MARK: - NEW CODE: State Enum
// This enum represents the different states of the AR session to provide UI feedback.
enum ARState {
    case initializing
    case tracking
    case failed(Error)
}

class AugmentedRealityVM: NSObject, ObservableObject, ARSessionDelegate {
    @Published var mapCoords: [Locations]
    private var arView: ARView?

    init(mapCoords: [Locations]) {
        self.mapCoords = mapCoords
        super.init()

        guard ARGeoTrackingConfiguration.isSupported else {
            print("ARGeoTracking is not supported on this device.")
            return
        }
    }

    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let geoAnchor = anchor as? ARGeoAnchor else { continue }

            let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.5), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
            let geoAnchorEntity = AnchorEntity(anchor: geoAnchor)
            geoAnchorEntity.addChild(box)

            guard let arView = self.arView else { return }
            arView.scene.addAnchor(geoAnchorEntity)
        }
    }

    func setupARView(arView: ARView) {
        self.arView = arView
        let config = ARGeoTrackingConfiguration()

        for location in mapCoords {
            let geoAnchor = ARGeoAnchor(coordinate: location.coordinate)
            arView.session.add(anchor: geoAnchor)
        }

        arView.session.run(config)
        arView.session.delegate = self
    }

    func pauseSession() {
        arView?.session.pause()
    }
}



