//
//  LoginView.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 5/16/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM : LoginVM
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome")
//                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 45))
                .padding(.bottom)
            Spacer()
            // Textfield to get user email
            TextField("Email", text: $loginVM.email)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8.0)
                .padding(.horizontal)

            // Textfield to get and hide password
            PasswordInputView("Password", password: $loginVM.password)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8.0)
            .padding(.horizontal)
        
                
        
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Forgot Username?")
                        .foregroundColor(.gray)
                        .padding()
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Forgot Password?")
                        .foregroundColor(.gray)
                        .padding()
                })
            }
            
            // Login button with action
            Button(action: {
                loginVM.loginAttempt()
            }) {
                // Login button text
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8.0)
            }
            .padding()
            .alert(isPresented: $loginVM.showAlert){
                Alert(title: Text("Invalid Credentials"), message: Text(loginVM.alertMessage), dismissButton: .default(Text("OK")))
            }
            Text("- or -")
                .padding(2)
            GoogleSignInButton {
                // TODO: - Call the sign method here
                FirebAuth.share.signinWithGoogle(presenting: getRootViewController()) { error in
                    // TODO: Handle ERROR
                }
            }.padding(5)
            
            
            Spacer()
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct PasswordInputView: View {
    @Binding private var password: String
    @State private var isSecured: Bool = true
    private var placeholder: String
    
    init(_ title: String, password: Binding<String>) {
        self.placeholder = title
        self._password = password
    }
    
    var body: some View {
        ZStack(alignment: .trailing){
            Group{
                if isSecured {
                    SecureField(placeholder, text: $password)
                } else {
                    TextField(placeholder, text: $password)
                }
            }
            .padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .frame(width: 22, height: 22)
            }
        }
    }
}

#Preview {
    LoginView(loginVM: LoginVM())
}
