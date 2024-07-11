//
//  LocationButton.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 7/11/24.
//

import SwiftUI
import CoreLocation

struct LocationButton: View {
    let size : CGSize
    @ObservedObject var locationManagerVM : LocationManagerVM

    
    var body: some View {
        if locationManagerVM.authorizationStatus == .notDetermined || locationManagerVM.authorizationStatus == .restricted {
            Button {
                locationManagerVM.requestPermission()
            } label : {
                Image(systemName: "location")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width * 0.055, height: size.height * 0.055)
            }
        } else if locationManagerVM.locationManager.authorizationStatus == .denied {
            Button {
                locationManagerVM.showAlert = true
            } label : {
                Image(systemName: "location.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width * 0.055, height: size.height * 0.055)
            }
        } else if locationManagerVM.locationManager.authorizationStatus == .authorizedWhenInUse || locationManagerVM.locationManager.authorizationStatus == .authorizedAlways {
            Button {
                
            } label : {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width * 0.055, height: size.height * 0.055)
            }
        }
    }
}

//#Preview {
//    
//    LocationButton(size: <#CGSize#>, locationManagerVM: <#LocationManagerVM#>)
//}
