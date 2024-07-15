//
//  MapIconButton.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 7/15/24.
//

import SwiftUI

struct MapIconButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(isSelected ? Color.blue : Color.blue.opacity(0.2)) // Change color when selected
                    .frame(width: 60, height: 60) // Adjust the size as needed
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(isSelected ? .white : .blue)
            }
            .onTapGesture {
                action()
            }
            
            Text(label)
                .font(.headline)
                .foregroundColor(isSelected ? .blue : .primary)
        }
    }
}



