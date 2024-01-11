//
//  SignUpView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    // MARK: - Properties
    var coordinator: UIKitNavigationController.Coordinator

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignUpEnabled: Bool = false
    @State private var isMinLengthMet: Bool = false
    @State private var isCapitalLetterMet: Bool = false
    @State private var isNumberMet: Bool = false
    @State private var isUniqueCharacterMet: Bool = false
    
    // MARK: - Body
    var body: some View {
        content
    }
    
    // MARK: - Content
    private var content: some View {
        components
            .background(Color.customBackgroundColor)
            .edgesIgnoringSafeArea(.all)
            .onChange(of: password) { newValue in
                isMinLengthMet = newValue.count >= 8
                isCapitalLetterMet = newValue.rangeOfCharacter(from: .uppercaseLetters) != nil
                isNumberMet = newValue.rangeOfCharacter(from: .decimalDigits) != nil
                isUniqueCharacterMet = newValue.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%^&*")) != nil
                
                isSignUpEnabled = isMinLengthMet && isCapitalLetterMet && isNumberMet && isUniqueCharacterMet
            }
    }
    
    private var components: some View {
        VStack(spacing: 20) {
            Spacer()
            LogoImage()
            EmailTextField(email: $email)
            PasswordSecureField(password: $password)
            
            PasswordStrengthChecklist(
                isMinLengthMet: isMinLengthMet,
                isCapitalLetterMet: isCapitalLetterMet,
                isNumberMet: isNumberMet,
                isUniqueCharacterMet: isUniqueCharacterMet
            )
            Spacer()
            AuthActionButtonView(actionText: "Sign Up",
                                 isEnabled: isSignUpEnabled,
                                 onTap: register,
                                 onNavigate: { coordinator.navigate(to: .successPage) }
            )
            Spacer()
        }
    }
    
    // MARK: - Register
    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SignUpView(coordinator: UIKitNavigationController.Coordinator())
}
