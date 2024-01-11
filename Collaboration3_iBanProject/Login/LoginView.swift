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
    var coordinator: UIKitNavigationController.Coordinator
    @StateObject private var viewModel: LoginViewModel
    
    // MARK: - Init
    init(coordinator: UIKitNavigationController.Coordinator) {
        self.coordinator = coordinator
        self._viewModel = StateObject(wrappedValue: LoginViewModel(coordinator: coordinator))
    }
    
    // MARK: - Body
    var body: some View {
        content
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Login Error"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    
    // MARK: - Content
    private var content: some View {
        VStack(spacing: 20) {
            Spacer()
            LogoImage()
            EmailTextField(email: $viewModel.email)
            PasswordSecureField(password: $viewModel.password)
            accountCheckView
            Spacer()
            AuthActionButtonView(actionText: "Log In", onTap: viewModel.login)
            Spacer()
        }
        .background(Color.customBackgroundColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
    
    private var accountCheckView: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundColor(.white)
            
            Button(action: {
                coordinator.navigate(to: .signupPage)
            }) {
                Text("Sign Up")
                    .foregroundColor(.customAccentColor)
            }
        }
        .padding(.top, 20)
    }
}

#Preview {
    LoginView(coordinator: UIKitNavigationController.Coordinator())
}
