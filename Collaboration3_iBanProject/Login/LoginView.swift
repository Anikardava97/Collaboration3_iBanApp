//
//  LoginView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image("logoWithTitle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.bottom, 60)
            
            EmailTextField(email: $email)
        
            PasswordSecureField(password: $password)
            
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.white)
                
                Button(action: {
                    // Action for signup button
                }) {
                    Text("Sign Up")
                        .foregroundColor(.customAccentColor)
                }
            }
            .padding(.top, 20)
            
            Spacer()
            LoginButton(onTap: login)
            
            Spacer()
        }
        .background(Color.customBackgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

struct EmailTextField: View {
    @Binding var email: String
    
    var body: some View {
        HStack {
            Text("Email")
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
        TextField("Enter your email address", text: $email)
            .padding()
            .background(Color.customTextFieldColor)
            .tint(.white)
            .cornerRadius(8.0)
            .padding(.horizontal)
    }
}

struct PasswordSecureField: View {
    @Binding var password: String
    
    var body: some View {
        HStack {
            Text("Password")
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
        
        SecureField("Enter your password", text: $password)
            .padding()
            .background(Color.customTextFieldColor)
            .cornerRadius(8.0)
            .padding(.horizontal)
    }
}

struct LoginButton: View {
    var onTap: () -> Void

    var body: some View {
        Button(action: {
            onTap()
        }) {
            Text("Log In")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.customAccentColor)
                .cornerRadius(8.0)
                .padding(.horizontal)
        }
    }
}


#Preview {
    LoginView()
}
