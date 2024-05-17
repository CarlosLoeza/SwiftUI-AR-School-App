//
//  MapImageButton.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 4/9/24.
//

import SwiftUI

struct MapImageButton: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .padding(5)
            .background(.regularMaterial)
    }
}

#Preview {
    MapImageButton(imageName: "figure.dress.line.vertical.figure")
}
