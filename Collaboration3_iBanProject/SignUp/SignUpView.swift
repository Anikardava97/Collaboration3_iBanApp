//
//  SignUpView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Properties
    @StateObject private var viewModel: SignUpViewModel
    var coordinator: UIKitNavigationController.Coordinator
    
    // MARK: - Init
    init(coordinator: UIKitNavigationController.Coordinator) {
        self.coordinator = coordinator
        self._viewModel = StateObject(wrappedValue: SignUpViewModel(coordinator: coordinator))
    }
    
    // MARK: - Body
    var body: some View {
        content
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Registration Error"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
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
                                 onTap: viewModel.register
            )
            Spacer()
        }
    }
}

