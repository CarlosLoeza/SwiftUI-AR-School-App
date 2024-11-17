//
//  Settings.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 7/16/24.
//

import SwiftUI

struct Settings: View {
    @State private var items = ["Use my location", "Sign Out", "Cherry", "Date", "Elderberry"]
    @State private var toggles: [Bool] = [false, false, false, false, false]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.largeTitle) // Adjust font size as needed
                .padding()
            List {
                ForEach(items.indices, id: \.self) { index in
                    HStack {
                        Text(items[index])
                        Spacer()
                        Toggle(isOn: $toggles[index]) {
                            Text("Selected")
                        }
                        .labelsHidden() // Hides the label of the toggle switch
                    }
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    print("sign out")
                }, label: {
                    Text("Sign Out")
                        .padding()
                        .padding(.bottom, 20 )
                        
                })
                Spacer()
            }
        }
    }
}

#Preview {
    Settings()
}
