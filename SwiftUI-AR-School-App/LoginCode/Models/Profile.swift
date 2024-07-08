//
//  File.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 5/16/24.
//

import SwiftUI

struct Profile {
    let id: String
    let name: String
    let email: String
    let emailVerified: String
    let picture: String
    let updatedAt: String
}

extension Profile {
    static var empty: Self {
        return Profile(id: "",
                       name: "",
                       email: "",
                       emailVerified: "",
                       picture: "",
                       updatedAt: "")
    }
}

