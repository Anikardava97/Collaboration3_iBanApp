//
//  ListItemComponent.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 12.01.24.
//

import SwiftUI

struct IbanListItemView: View {
    
    // MARK: - Properties
    var person: PersonInfoModel
    
    
    // MARK: - body
    var body: some View {
        
        HStack(spacing: 12) {
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(Color.customAccentColor)
            
            Text(person.fullName)
                .font(.system(size: 16.0))
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(width: .infinity, height: 72.0)
        .padding(.horizontal)
        .background(Color.customListRowBackgroundColor)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
