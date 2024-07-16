//
//  MapIconBar.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 7/16/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct MapIconBar: View {
    @ObservedObject var mapVM: MapVM
    @Binding var selectedButton: String
    
    var body: some View {
        VStack {
            Spacer()
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            MapIconButton(icon: "building.2.fill", label: "Buildings", isSelected: selectedButton == "" || selectedButton == "Buildings")  {
                                selectedButton = "Buildings"
                                mapVM.vPath = mapVM.getSchoolBuildings()
                            }
                            .frame(width: 80, height: 100)
                            MapIconButton(icon: "figure.dress.line.vertical.figure", label: "Bathroom", isSelected: selectedButton == "Bathroom") {
                                selectedButton = "Bathroom"
                                mapVM.vPath = mapVM.getBathroomBuildings()
                            }
                            .frame(width: 80, height: 100)
                            MapIconButton(icon: "takeoutbag.and.cup.and.straw.fill", label: "Food", isSelected: selectedButton == "Food") {
                                selectedButton = "Food"
                            }
                            .frame(width: 80, height: 100)
                            MapIconButton(icon: "person.2.fill", label: "Events", isSelected: selectedButton == "Events") {
                                selectedButton = "Events"
                            }
                            .frame(width: 80, height: 100)
                        }
                        .padding(.leading, 15)
                        .padding(.bottom, -5)
                    }
                    .padding(5)
                    Spacer()
            }
            .background(Color(.systemGray6).opacity(0.8))
            .cornerRadius(20)
            .shadow(radius: 10)
//                .offset(y: isSlideUpViewVisible ? 0 : 300) // Adjust the offset value as needed
//                .animation(.easeInOut)
            
        }
        .padding(3)
    }
}

//#Preview {
//    @State var button : String? = nil
//    
//   
//}
