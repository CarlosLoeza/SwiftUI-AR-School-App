//
//  ARView+CoachingOverlay.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/22/24.
//

import ARKit
import RealityKit

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
