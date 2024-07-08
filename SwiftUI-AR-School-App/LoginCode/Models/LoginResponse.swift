//
//  LoginResponse.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 5/16/24.
//

import Foundation

struct LoginResponse: Decodable {
    let data: LoginResponseData
}

struct LoginResponseData: Decodable {
    let accessToken: String
    let refreshToken: String
}
