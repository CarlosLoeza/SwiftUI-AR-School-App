//
//  DestinationPickerWheel.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/8/24.
//

import SwiftUI

struct DestinationPickerWheel: View {
    @Binding var selectedText: String
    var placeHolderText: String
    var destinations: [String]
    
    var body: some View {
        Picker("Selection", selection: $selectedText){
            ForEach(0 ..< destinations.count) {
                if destinations[$0] == "-- Select One --" {
                    Text(self.destinations[$0]).tag(placeHolderText)
                } else {
                    Text(self.destinations[$0]).tag(destinations[$0])
                }
            }
        }
    }
}
