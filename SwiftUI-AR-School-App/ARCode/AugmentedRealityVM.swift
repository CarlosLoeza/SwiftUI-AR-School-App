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
/*
class AugmentedRealityVM: NSObject, ObservableObject, ARSessionDelegate {
    @Published var mapCoords: [Locations]
    private var arView: ARView?
    
    init(mapCoords: [Locations]) {
        self.mapCoords = mapCoords
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
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for geoAnchor in anchors.compactMap({ $0 as? ARGeoAnchor }) {
            // Effect a spatial-based delay to avoid blocking the main thread.
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                // Add an AR placemark visualization for the geo anchor.
                self.arView?.scene.addAnchor(Entity.placemarkEntity(for: geoAnchor))
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



extension Entity {
    static func placemarkEntity(for arAnchor: ARAnchor) -> AnchorEntity {
        let placemarkAnchor = AnchorEntity(anchor: arAnchor)
        
        let sphereIndicator = generateSphereIndicator(radius: 0.1)
        
        // Move the indicator up so that it doesn't intersect with the ground.
        let height = sphereIndicator.visualBounds(relativeTo: nil).extents.y
        sphereIndicator.position.y = height / 4
        
        // The move function animates the indicator to expand and rise up 0.1 meters from the ground like a balloon.
        let distanceFromGround: Float = 0.1
        sphereIndicator.move(by: [0, distanceFromGround, 0], scale: .one * 10, after: 0.5, duration: 5.0)
        placemarkAnchor.addChild(sphereIndicator)
        
        return placemarkAnchor
    }
    
    static func generateSphereIndicator(radius: Float) -> Entity {
        let indicatorEntity = Entity()
        
        let innerSphere = ModelEntity.blueSphere.clone(recursive: true)
        indicatorEntity.addChild(innerSphere)
        let outerSphere = ModelEntity.transparentSphere.clone(recursive: true)
        indicatorEntity.addChild(outerSphere)
        
        return indicatorEntity
    }
    
    func move(by translation: SIMD3<Float>, scale: SIMD3<Float>, after delay: TimeInterval, duration: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            var transform: Transform = .identity
            transform.translation = self.transform.translation + translation
            transform.scale = self.transform.scale * scale
            self.move(to: transform, relativeTo: self.parent, duration: duration, timingFunction: .easeInOut)
        }
    }
}

extension ModelEntity {
    static let blueSphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.066), materials: [UnlitMaterial(color: #colorLiteral(red: 0, green: 0.3, blue: 1.4, alpha: 1))])
    static let transparentSphere = ModelEntity(
        mesh: MeshResource.generateSphere(radius: 0.1),
        materials: [SimpleMaterial(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25), roughness: 0.3, isMetallic: true)])
}
*/
