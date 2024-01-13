//
//  CustomIbanComponentView.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 13.01.24.
//

import SwiftUI

struct CustomIbanComponentView: View {
    
    // MARK: - Properties
    @State var iban: IbanInfo
    
    
    // MARK: - body
    var body: some View {
        
        HStack(spacing: 20) {
            
            Text(iban.bankName)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: 56.0, alignment: .leading)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.customAccentColor, lineWidth: 1)
                )
            
            HStack(spacing: 24) {
                
                Button {
                    //
                } label: {
                    Image(systemName: "doc.on.doc.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24.0)
                }
                
                Button {
                    //
                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24.0)
                }
                
                Button {
                    //
                } label: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24.0)
                }
            }
            .frame(height: 56.0)
            .foregroundColor(.gray)
        }
    }
}

//
//// MARK: - Preview
//struct CustomIbanComponentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomIbanComponentView(iban: IbanInfo(bankName: "", iban: ""))
//    }
//}
