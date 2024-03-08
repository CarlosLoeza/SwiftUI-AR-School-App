//
//  ContentView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var startingPointText = "Select Starting Point"
    @State private var destinationPointText = "Select Destination Point"
    @State var isStartingButtonClicked = false
    @State var isDestinationButtonClicked = false
    
    var destinations: [String] = [ "-- Select One --",
                                   "Admissions",
                                   "Burk Hall",
                                   "Business",
                                   "Creative Arts",
                                   "Cesar Chavez Student Center",
                                   "Fine Arts",
                                   "Humanities",
                                   "J. Paul Leonard Library"
                                 ]
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ZStack{
                    // Sf State logo
                    Image("new-state-logo")
                        .resizable()
                        .edgesIgnoringSafeArea(.bottom)
                        .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.15)
                        .padding(.bottom, geometry.size.height)
                        .padding(.trailing, 10)
                    // Campus photo
                    Image("sf-state-day-campus")
                        .resizable()
                        .frame(height: geometry.size.height < 700 ? geometry.size.height * 0.85 : geometry.size.height * 0.91)
                        .padding(.top, geometry.size.height * 0.06)
                    // Select starting point button
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                isStartingButtonClicked.toggle()
                                isDestinationButtonClicked = false
                            }, label: {
                                
                                Text(startingPointText)
                                    .font(.headline)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.07)
                                    .background(RoundedRectangle(cornerRadius:8).fill(Color.white))
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow, lineWidth: 2)
                                    )
                                    .padding()
                            })
                            Spacer()
                        }
                        Spacer()
                        Spacer()
                    }
                    // select starting point picker wheel and select button
                    VStack {
                        if isStartingButtonClicked {
                            DestinationPickerWheel(selectedText: $startingPointText, placeHolderText: "Select Starting Point", destinations: destinations)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
                            .pickerStyle(.wheel)
                            .background(RoundedRectangle(cornerRadius:8).fill(Color(red: 92.0/255, green: 89.0/255, blue: 158.0/255)))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.yellow, lineWidth: 2)
                            )
                            Button(action: {
                                isStartingButtonClicked = false
                            }, label: {
                                Text("Select")
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
                                    .foregroundColor(.black)
                                    .background(RoundedRectangle(cornerRadius:8).fill(Color(red: 92.0/255, green: 89.0/255, blue: 158.0/255)))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow, lineWidth: 2)
                                    )

                                    
                            })
                        }
                    }
                    .zIndex(1)
                    .padding(.top, geometry.size.height * 0.025)
                    Spacer()
                    
                    
                    VStack{
                        Spacer()
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                isDestinationButtonClicked.toggle()
                                isStartingButtonClicked = false
                            }, label: {
                                Text(destinationPointText)
                                    .font(.headline)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.07)
                                    .background(RoundedRectangle(cornerRadius:8).fill(Color.white))
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow, lineWidth: 2)
                                    )
                                    .padding()
                            })
                            Spacer()
                        }
                        Spacer()
                        Spacer()
                    }
                    
                    VStack {
                        if isDestinationButtonClicked {
                            DestinationPickerWheel(selectedText: $destinationPointText, placeHolderText: "Select Destination Point", destinations: destinations)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
                            .pickerStyle(.wheel)
                            .background(RoundedRectangle(cornerRadius:8).fill(Color(red: 92.0/255, green: 89.0/255, blue: 158.0/255)))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.yellow, lineWidth: 2)
                            )

                            Button(action: {
                                isDestinationButtonClicked = false
                            }, label: {
                                Text("Select")
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
                                    .foregroundColor(.black)
                                    .background(RoundedRectangle(cornerRadius:8).fill(Color(red: 92.0/255, green: 89.0/255, blue: 158.0/255)))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow, lineWidth: 2)
                                    )
                            })
                        }
                    }
                    .zIndex(1)
                    .padding(.top, geometry.size.height * 0.38)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 60.0/255, green: 58.0/255, blue: 100.0/255))
        }
        .ignoresSafeArea(.keyboard)
    }
}

// give each region a unique identifier
public var uniqueKey: String {
    UUID().uuidString
}

// facility items used to populate facilities in the home tab
public class DestinationDropdownList: DropdownListProtocol {
    
    public init() {}
    
    public func getList(queryParam: String) -> [DropdownOption] {
        // facility list
        let facilityOptions: [DropdownOption] = [
            DropdownOption(key: uniqueKey, value: "Admissions"),
            DropdownOption(key: uniqueKey, value: "Burk Hall"),
            DropdownOption(key: uniqueKey, value: "Business"),
            DropdownOption(key: uniqueKey, value: "Creative Arts"),
            DropdownOption(key: uniqueKey, value: "Cesar Chavez Student Center"),
            DropdownOption(key: uniqueKey, value: "Fine Arts"),
            DropdownOption(key: uniqueKey, value: "Humanities"),
            DropdownOption(key: uniqueKey, value: "J. Paul Leonard Library"),
        ]
        // return filtered facility list based on user text input
        return facilityOptions.filter { option in
            return option.value.uppercased().hasPrefix(queryParam.uppercased())
        }
    }
}

#Preview {
    ContentView()
}
