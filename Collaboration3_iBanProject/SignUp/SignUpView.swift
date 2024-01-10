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
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isSignUpEnabled: Bool = false

    @State private var isMinLengthMet: Bool = false
    @State private var isCapitalLetterMet: Bool = false
    @State private var isNumberMet: Bool = false
    @State private var isUniqueCharacterMet: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            logoImage
                        
            EmailTextField(email: $email)
            
            PasswordSecureField(password: $password)
            
            PasswordStrengthChecklist(
                isMinLengthMet: isMinLengthMet,
                isCapitalLetterMet: isCapitalLetterMet,
                isNumberMet: isNumberMet,
                isUniqueCharacterMet: isUniqueCharacterMet
            )
            
            Spacer()
            SignUpButton(isEnabled: isSignUpEnabled, onTap: register)
    
            Spacer()
        }
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
    
    // MARK: - Components
    private var logoImage: some View {
        Image.logoWithTitle
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .padding(.bottom, 60)
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



struct SignUpButton: View {
    var isEnabled: Bool
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            PrimaryButtonComponentView(text: "Sign Up")
                .opacity(isEnabled ? 1.0 : 0.3)
                .disabled(!isEnabled)
        }
    }
}

struct PasswordStrengthChecklist: View {
    var isMinLengthMet: Bool
    var isCapitalLetterMet: Bool
    var isNumberMet: Bool
    var isUniqueCharacterMet: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your password should have:")
                .foregroundColor(.white)
            
            ChecklistItem(title: "At least 8 characters", isMet: isMinLengthMet)
            ChecklistItem(title: "At least one capital letter", isMet: isCapitalLetterMet)
            ChecklistItem(title: "At least one number", isMet: isNumberMet)
            ChecklistItem(title: "At least one unique character", isMet: isUniqueCharacterMet)
        }
        .padding(.top, 20)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}

struct ChecklistItem: View {
    var title: String
    var isMet: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: isMet ? "checkmark" : "checkmark")
                .foregroundColor(isMet ? .green : .gray)
            Text(title)
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
    }
}


#Preview {
    SignUpView()
}
