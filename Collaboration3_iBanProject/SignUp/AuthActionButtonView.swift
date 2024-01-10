//
//  AuthActionButtonView.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI

struct AuthActionButtonView: View {
    //MARK: - Properties
    var actionText: String
       var isEnabled: Bool
       var onTap: () -> Void
       
    //MARK: - Body
       var body: some View {
           Button(action: {
               onTap()
           }) {
               PrimaryButtonComponentView(text: actionText)
                   .opacity(isEnabled ? 1.0 : 0.3)
                   .disabled(!isEnabled)
           }
       }
}


