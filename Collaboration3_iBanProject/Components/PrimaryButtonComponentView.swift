//
//  PrimaryButtonComponentView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct PrimaryButtonComponentView: View {
    // MARK: - Properties
    var text: String
    
    // MARK: - Body
    var body: some View {
            Text(text.capitalized)
                .foregroundColor(.white)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color.customAccentColor)
                .cornerRadius(12)
                .padding(.horizontal, 16)
        }
    }

