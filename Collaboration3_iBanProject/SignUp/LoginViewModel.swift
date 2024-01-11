//
//  LoginViewModel.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 11.01.24.
//

import Foundation
import Firebase

@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: - Properties
   // var coordinator: UIKitNavigationController.Coordinator
    
    @Published var email = ""
    @Published var password = ""
    @Published var isButtonEnabled = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    // MARK: - Methods
    func login() async {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.loginUser(email: email, password: password)
                print("Login success")
                print(returnedUserData)
                    //navigateToMainPage()
            } catch {
                print("Login error: \(error)")
                showAlert = true
                alertMessage = "Login failed. Please check your email and password."
            }
        }
    }
    
//    func navigateToMainPage() {
//        coordinator.navigate(to: .mainView)
//    }
}

