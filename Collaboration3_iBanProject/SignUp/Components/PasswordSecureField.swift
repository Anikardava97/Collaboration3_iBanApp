//
//  PasswordSecureField.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct PasswordSecureField: View {
    //MARK: - Properties
    @Binding var password: String
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            Text("Password")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack(alignment: .leading) {
                if password.isEmpty {
                    Text("Enter your password")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.6))
                }
                SecureField("", text: $password)
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
