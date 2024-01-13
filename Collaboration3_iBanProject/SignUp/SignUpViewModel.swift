//
//  SignUpViewModel.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 11.01.24.
//

import Foundation
import Firebase

@MainActor
final class SignUpViewModel: ObservableObject {
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUpEnabled = false
    @Published var isMinLengthMet = false
    @Published var isCapitalLetterMet = false
    @Published var isNumberMet = false
    @Published var isUniqueCharacterMet = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    var coordinator = UIKitNavigationController.Coordinator()
    
    // MARK: - Init
    init(coordinator: UIKitNavigationController.Coordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func register() async {
        guard !email.isEmpty, !password.isEmpty else { return }
        Task {
            do {
                _ = try await
                AuthenticationManager.shared.createUser(email: email, password: password)
                navigateToMainPage()
            } catch {
                showAlert = true
                alertMessage = "Registration failed. Please try again later."
            }
        }
    }
    
    func updatePasswordCriteria(password: String) {
        isMinLengthMet = password.count >= 8
        isCapitalLetterMet = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        isNumberMet = password.rangeOfCharacter(from: .decimalDigits) != nil
        isUniqueCharacterMet = password.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%^&*")) != nil
        isSignUpEnabled = isMinLengthMet && isCapitalLetterMet && isNumberMet && isUniqueCharacterMet
    }
    
    private func navigateToMainPage() {
        coordinator.navigate(to: .successPage)
    }
}
