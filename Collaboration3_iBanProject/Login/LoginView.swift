//
//  LoginView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    // MARK: - Properties
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginEnabled: Bool = false
    
    // MARK: - Body
    var body: some View {
        content
    }
    
    // MARK: - Content
    private var content: some View {
        VStack(spacing: 20) {
            Spacer()
            LogoImage()
            EmailTextField(email: $email)
            PasswordSecureField(password: $password)
            accountCheckView
            Spacer()
            AuthActionButtonView(actionText: "Log In", isEnabled: isLoginEnabled, onTap: login)
            Spacer()
        }
        .background(Color.customBackgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
    
    private var accountCheckView: some View {
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
    }
    
    // MARK: - Methods
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

#Preview {
    LoginView()
}
