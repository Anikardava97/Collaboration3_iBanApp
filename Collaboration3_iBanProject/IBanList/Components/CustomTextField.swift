//
//  CustomTextField.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 13.01.24.
//

import SwiftUI

struct CustomTextField: View {
    // MARK: - Properties
    @State var titleText: String
    @State var displayText: String
    @Binding var textfieldText: String
    
    // MARK: - body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titleText)
                .font(.system(size: 16.0, weight: .bold))
            TextField(displayText, text: $textfieldText)
                .frame(minHeight: 48)
                .padding(.leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.customTextFieldColor, lineWidth: 1)
                }
        }
    }
}
