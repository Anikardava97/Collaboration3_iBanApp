//
//  OnboardingButton.swift
//  Collaboration3_iBanProject
//
//  Created by IT Academy - 5  on 12.01.24.
//

import SwiftUI

struct OnboardingButton: View {
    //MARK: - Properties
    var action: () -> Void
    var actionText: String
    
    //MARK: - Body
    var body: some View {
        Button(action: action) {
            PrimaryButtonComponentView(text: actionText)
        }
    }
}
