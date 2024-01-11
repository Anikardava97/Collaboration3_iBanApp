//
//  EmailTextField.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct EmailTextField: View {
    //MARK: - Properties
    @Binding var email: String
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            Text("Email")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack(alignment: .leading) {
                if email.isEmpty {
                    Text("Enter your email address")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.6))
                }
                TextField("", text: $email)
            }
            .foregroundStyle(.white)
            .tint(.white)
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.customAccentColor.opacity(0.5), lineWidth: 1.0)
            )
            .background(Color.customTextFieldColor)
            .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
    }
}
