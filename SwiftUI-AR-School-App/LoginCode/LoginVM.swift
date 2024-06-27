//
//  LoginVM.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 5/16/24.
//

import SwiftUI
import Auth0

class LoginVM: ObservableObject {
    var email = ""
    var password = ""
    @Published var isValidEmail = false
    @Published var isValidPassword = false
    @Published var isAuthenticated = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    // acceptable email formats (dummy suffixes)
    let allowedSuffixes = ["@gmail.com", "@yahoo.com"]
    
    // Function to validate password criteria
    func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,15}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func loginAttempt(){
        // check if we have a valid email and password
        isValidEmail = allowedSuffixes.contains{ email.hasSuffix($0)}
        isValidPassword = isValidPassword(password: password)
        // Perform login action here if both are valid
        if isValidEmail && isValidPassword {
            // Login logic
            print("Valid credentials")
            // in here we add code to validate email and password with server
            // ...
            //
//            Auth0
//                .webAuth()
//                .start { result in
//                    switch result{
//                        case .success(let credentials):
//                            self.isAuthenticated = true
//                            print("Credentials: \(credentials)")
//                            print("Id: \(credentials.idToken)")
//                        case .failure(let error):
//                            print("Failure with error: \(error)")
//                        }
//                    }
        } else {
            // else, show error message to handle invalid credentials
            print("Invalid credentials")
            showAlert = true
            alertMessage = "Please provide a valid email or password"
        }

    }
}
