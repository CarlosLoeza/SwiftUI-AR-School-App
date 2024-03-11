////
////  ContentView.swift
////  SwiftUI-AR-School-App
////
////  Created by Carlos on 3/7/24.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var startingPointText = "Select Starting Point"
//    @State private var destinationPointText = "Select Destination Point"
//    @State var isStartingButtonClicked = false
//    @State var isDestinationButtonClicked = false
//    let lightPurple = Color(red: 92.0/255, green: 89.0/255, blue: 158.0/255)
//    let startingPlaceholderText = "Select Starting Point"
//    let destinationPlaceholderText = "Select Destination Point"
//    let selectText = "Select"
//    let classText = "Find Class"
//    let size = 32
//    
//    // this will eventually replace graph[] above
//    var updatedGraph: [[Int]] = [ //0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
//                                   [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //0
//                                   [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //1
//                                   [0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //2
//                                   [0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //3
//                                   [0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //4
//                                   [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //5
//                                   [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //6
//                                   [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //7
//                                   [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //8
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //9
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //10
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //11
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //12
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //13
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //14
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //15
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //16
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //17
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //18
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //19
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], //20
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //21
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0], //22
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0], //23
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0], //24
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0], //25
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0], //26
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0], //27
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0], //28
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0], //29
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1], //30
//                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], //31
//                                ]
//    
//    
//    var destinations: [String] = [ "-- Select One --",
//                                   "Admissions",
//                                   "Burk Hall",
//                                   "Business",
//                                   "Creative Arts",
//                                   "Cesar Chavez Student Center",
//                                   "Fine Arts",
//                                   "Humanities",
//                                   "J. Paul Leonard Library"
//                                 ]
//    
//    // locationVertex is a dictionary which helps translate location name to vertex number.
//    // Used for dijkstra algorithm to find shortest path.
//    var locationVertex : [String: Int] = [
//                            "Admissions": 0,
//                            "Burk Hall": 31,
//                            "Business": 1,
//                            "Creative Arts": 19,
//                            "Cesar Chavez Student Center": 13,
//                            "Fine Arts": 21,
//                            "Humanities": 0, // change this
//                            "J. Paul Leonard Library": 5
//                         ]
//    
//    var body: some View {
//        GeometryReader{ geometry in
//            VStack{
//                ZStack{
//                    // Sf State logo
//                    Image("new-state-logo")
//                        .resizable()
//                        .edgesIgnoringSafeArea(.bottom)
//                        .frame(width: geometry.size.width, height: geometry.size.height * 0.15)
//                        .padding(.bottom, geometry.size.height)
//                        .padding(.trailing, geometry.size.width * 0.02)
//                    // Campus photo
//                    Image("sf-state-day-campus")
//                        .resizable()
//                        .frame(height: geometry.size.height < 700 ? geometry.size.height * 0.85 : geometry.size.height * 0.91)
//                        .padding(.top, geometry.size.height * 0.06)
//                    // Select starting point button
//                    VStack{
//                        Spacer()
//                        HStack{
//                            Spacer()
//                            Button(action: {
//                                isStartingButtonClicked.toggle()
//                                isDestinationButtonClicked = false
//                            }, label: {
//                                
//                                Text(startingPointText)
//                                    .font(.headline)
//                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.07)
//                                    .background(RoundedRectangle(cornerRadius:8).fill(Color.white))
//                                    .foregroundColor(.black)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .stroke(Color.yellow, lineWidth: 2)
//                                    )
//                                    .padding()
//                            })
//                            Spacer()
//                        }
//                        Spacer()
//                        Spacer()
//                    }
//                    // select starting point picker wheel and select button
//                    VStack {
//                        if isStartingButtonClicked {
//                            DestinationPickerWheel(selectedText: $startingPointText, placeHolderText: "Select Starting Point", destinations: destinations)
//                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
//                            .pickerStyle(.wheel)
//                            .background(RoundedRectangle(cornerRadius:8).fill(lightPurple))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.yellow, lineWidth: 2)
//                            )
//                            Button(action: {
//                                isStartingButtonClicked = false
//                            }, label: {
//                                Text(selectText)
//                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
//                                    .foregroundColor(.black)
//                                    .background(RoundedRectangle(cornerRadius:8).fill(lightPurple))
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .stroke(Color.yellow, lineWidth: 2)
//                                    )
//
//                                    
//                            })
//                        }
//                    }
//                    .zIndex(1)
//                    .padding(.top, geometry.size.height * 0.025)
//                    Spacer()
//                    
//                    
//                    VStack{
//                        Spacer()
//                        Spacer()
//                        HStack{
//                            Spacer()
//                            Button(action: {
//                                isDestinationButtonClicked.toggle()
//                                isStartingButtonClicked = false
//                            }, label: {
//                                Text(destinationPointText)
//                                    .font(.headline)
//                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.07)
//                                    .background(RoundedRectangle(cornerRadius:8).fill(Color.white))
//                                    .foregroundColor(.black)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .stroke(Color.yellow, lineWidth: 2)
//                                    )
//                                    .padding()
//                            })
//                            Spacer()
//                        }
//                        Spacer()
//                        Spacer()
//                    }
//                    
//                    VStack {
//                        if isDestinationButtonClicked {
//                            DestinationPickerWheel(selectedText: $destinationPointText, placeHolderText: "Select Destination Point", destinations: destinations)
//                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.22)
//                            .pickerStyle(.wheel)
//                            .background(RoundedRectangle(cornerRadius:8).fill(lightPurple))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.yellow, lineWidth: 2)
//                            )
//
//                            Button(action: {
//                                isDestinationButtonClicked = false
//                            }, label: {
//                                Text(selectText)
//                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.06)
//                                    .foregroundColor(.black)
//                                    .background(RoundedRectangle(cornerRadius:8).fill(lightPurple))
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .stroke(Color.yellow, lineWidth: 2)
//                                    )
//                            })
//                        }
//                    }
//                    .zIndex(1)
//                    .padding(.top, geometry.size.height * 0.38)
//                    Spacer()
//                   
//                    VStack{
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Button(action: {
//                            // add Find Class button action here
//                            findClassAction()
//                        }, label: {
//                            Text(classText)
//                                .font(.headline)
//                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.06)
//                                .foregroundColor(.black)
//                                .background(RoundedRectangle(cornerRadius:8).fill(Color.yellow))
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(lightPurple, lineWidth: 2)
//                                )
//                        })
//                        Spacer()
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color(red: 60.0/255, green: 58.0/255, blue: 100.0/255))
//        }
//    }
//    
//}
//
//
//#Preview {
//    ContentView()
//}
