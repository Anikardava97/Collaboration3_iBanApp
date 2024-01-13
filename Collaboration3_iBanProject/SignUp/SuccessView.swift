//
//  SuccessView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI
import SPConfetti

struct SuccessView: View {
    // MARK: - Properties
    var coordinator: UIKitNavigationController.Coordinator
    @State private var isPresenting = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.customBackgroundColor.ignoresSafeArea()
            content
        }
        .onAppear {
            isPresenting.toggle()
        }
        .confetti(isPresented: $isPresenting,
                  animation: .fullWidthToDown,
                  particles: [.triangle, .arc],
                  duration: 6.0)
    }
    
    // MARK: - Content
    private var content: some View {
        VStack(spacing: 40) {
            Spacer()
            confettiView
            congratulationsTextView
            returnButton
            Spacer()
        }
    }
    
    private var confettiView: some View {
        Image.confetti
            .resizable()
            .frame(width: 200, height: 200)
    }
    
    private var congratulationsTextView: some View {
        VStack(spacing: 24) {
            Text("Congratulations!")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
            VStack(spacing: 10) {
                Text("You have successfully registered with iBan Saver.")
                Text("Login now to start managing your iBans effortlessly.")
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var returnButton: some View {
        Button {
            coordinator.navigate(to: .loginPage)
        } label: {
            PrimaryButtonComponentView(text: "Back to Login")
        }
    }
}
//TODO: REMOVE COMMENT
//#Preview {
//    SuccessView(coordinator: UIKitNavigationController.Coordinator())
//}
