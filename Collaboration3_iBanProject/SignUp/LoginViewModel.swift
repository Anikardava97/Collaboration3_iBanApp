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
    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    var coordinator = UIKitNavigationController.Coordinator()
    
    // MARK: - Init
    init(coordinator: UIKitNavigationController.Coordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func login() async {
        guard !email.isEmpty, !password.isEmpty else { return }
        Task {
            do {
                _ = try await AuthenticationManager.shared.loginUser(email: email, password: password)
                navigateToMainPage()
            } catch {
                showAlert = true
                alertMessage = "Login failed. Please check your email and password."
            }
        }
    }
    
    private func navigateToMainPage() {
        coordinator.navigate(to: .ibanListPage)
    }
}

