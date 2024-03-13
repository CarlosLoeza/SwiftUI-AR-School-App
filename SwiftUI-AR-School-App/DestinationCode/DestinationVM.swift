//
//  DestinationVM.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/10/24.
//

import SwiftUI

class DestinationVM: ObservableObject {
    @Published var startingPointText = "Select Starting Point"
    @Published var destinationPointText = "Select Destination Point"
    @Published var isStartingButtonClicked = false
    @Published var isDestinationButtonClicked = false
    let lightPurple = Color(red: 92.0/255, green: 89.0/255, blue: 158.0/255)
    let startingPlaceholderText = "Select Starting Point"
    let destinationPlaceholderText = "Select Destination Point"
    let selectText = "Select"
    let classText = "Find Class"
    
    let destinations: [String] = [ "-- Select One --",
                                   "Admissions",
                                   "Burk Hall",
                                   "Business",
                                   "Creative Arts",
                                   "Cesar Chavez Student Center",
                                   "Fine Arts",
                                   "J. Paul Leonard Library"
                                 ]
}
