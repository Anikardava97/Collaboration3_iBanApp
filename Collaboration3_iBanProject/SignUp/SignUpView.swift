//
//  SignUpView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Properties
    var coordinator: UIKitNavigationController.Coordinator
    @StateObject private var viewModel = SignUpViewModel()

    // MARK: - Body
    var body: some View {
        content
    }
    
    // MARK: - Content
    private var content: some View {
        components
            .background(Color.customBackgroundColor)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var components: some View {
        VStack(spacing: 20) {
            Spacer()
            LogoImage()
            EmailTextField(email: $viewModel.email)
            PasswordSecureField(password: $viewModel.password)
                .onChange(of: viewModel.password) { newValue in
                    viewModel.updatePasswordCriteria(password: newValue)
                }
            PasswordStrengthChecklist(
                isMinLengthMet: viewModel.isMinLengthMet,
                      isCapitalLetterMet: viewModel.isCapitalLetterMet,
                      isNumberMet: viewModel.isNumberMet,
                      isUniqueCharacterMet: viewModel.isUniqueCharacterMet
            )
            Spacer()
            AuthActionButtonView(actionText: "Sign Up",
                                 isEnabled: viewModel.isSignUpEnabled,
                                 onTap: viewModel.register,
                                 onNavigate: { coordinator.navigate(to: .successPage) }
            )
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    SignUpView(coordinator: UIKitNavigationController.Coordinator())
}
