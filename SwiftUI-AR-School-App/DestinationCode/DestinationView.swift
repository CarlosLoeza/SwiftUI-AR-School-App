//
//  DestinationView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/10/24.
//

import SwiftUI

struct DestinationView: View {
    @StateObject var destinationVM = DestinationVM()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ZStack{
                    // Sf State logo
                    Image("new-state-logo")
                        .resizable()
                        .edgesIgnoringSafeArea(.bottom)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.15)
                        .padding(.bottom, geometry.size.height)
                        .padding(.trailing, geometry.size.width * 0.02)
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
                                destinationVM.isStartingButtonClicked.toggle()
                                destinationVM.isDestinationButtonClicked = false
                            }, label: {
                                
                                Text(destinationVM.startingPointText)
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
                    // UI: destination picker wheel and select button
                    VStack {
                        if destinationVM.isStartingButtonClicked {
                            DestinationPickerWheel(selectedText: $destinationVM.startingPointText, placeHolderText: "Select Starting Point", destinations: destinationVM.destinations)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
                            .pickerStyle(.wheel)
                            .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.yellow, lineWidth: 2)
                            )
                            Button(action: {
                                destinationVM.isStartingButtonClicked = false
                            }, label: {
                                Text(destinationVM.selectText)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
                                    .foregroundColor(.black)
                                    .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
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
                                destinationVM.isDestinationButtonClicked.toggle()
                                destinationVM.isStartingButtonClicked = false
                            }, label: {
                                Text(destinationVM.destinationPointText)
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
                        if destinationVM.isDestinationButtonClicked {
                            DestinationPickerWheel(selectedText: $destinationVM.destinationPointText, placeHolderText: "Select Destination Point", destinations: destinationVM.destinations)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
                            .pickerStyle(.wheel)
                            .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.yellow, lineWidth: 2)
                            )

                            Button(action: {
                                destinationVM.isDestinationButtonClicked = false
                            }, label: {
                                Text(destinationVM.selectText)
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
                                    .foregroundColor(.black)
                                    .background(RoundedRectangle(cornerRadius:8).fill(destinationVM.lightPurple))
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
                   
                    VStack{
                        Spacer()
                        Spacer()
                        Spacer()
                        Button(action: {
                            // add Find Class button action here
                            let pathResult = destinationVM.findClassAction()
                        }, label: {
                            Text(destinationVM.classText)
                                .font(.headline)
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.06)
                                .foregroundColor(.black)
                                .background(RoundedRectangle(cornerRadius:8).fill(Color.yellow))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(destinationVM.lightPurple, lineWidth: 2)
                                )
                        })
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 60.0/255, green: 58.0/255, blue: 100.0/255))
        }
    }
}


#Preview {
    DestinationView(destinationVM: DestinationVM())
}
