//
//  ARView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/15/24.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let config = ARGeoTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        arView.session.run(config)
        // Configure AR view and add coaching overlay
        arView.setupCoachingOverlay(for: arView)
        return arView
    }


    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the view if needed
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


struct AugmentedRealityView : View {
    @State private var isARSupported = false
    @State private var isARAvailable = false

    var body: some View {
        VStack {
            if isARSupported && isARAvailable {
                ARViewContainer()
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        UIApplication.shared.isIdleTimerDisabled = true
                    }
            } else {
                Text("AR is not supported on this device or at this location.")
                    .padding()
            }
        }
        .onAppear {
            checkARCompatibility()
        }
    }

    func checkARCompatibility() {
        // Check device support for geo-tracking
        if ARGeoTrackingConfiguration.isSupported {
            isARSupported = true

            // Check current location is supported for geo-tracking
            ARGeoTrackingConfiguration.checkAvailability { available, _ in
                if available {
                    // Geo-tracking is available at this location
                    isARAvailable = true
                }
            }
        }
    }
}


#Preview {
    AugmentedRealityView()
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
}
