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
    @StateObject private var viewModel: AugmentedRealityVM
    @Environment(\.presentationMode) var presentationMode

    init(mapCoords: [Locations]) {
        self._viewModel = StateObject(wrappedValue: AugmentedRealityVM(mapCoords: mapCoords))
    }

    var body: some View {
        ZStack {
            ARViewRepresentable(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)

            // MARK: - REVERTED: UI buttons are simplified.
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            MapImageButton(imageName: "map.fill")
                        })
                    }
                }
                .padding()
            }
        }
        .onDisappear {
            viewModel.pauseSession()
        }
    }
}

struct ARViewRepresentable: UIViewRepresentable {
    @ObservedObject var viewModel: AugmentedRealityVM

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        viewModel.setupARView(arView: arView)
        arView.setupCoachingOverlay(for: arView)
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
