//
//  CustomIbanComponentView.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 13.01.24.
//

import SwiftUI


struct CustomIbanComponentView: View {
    
    // MARK: - Properties
    var iban: IbanInfo
    @Binding var person: PersonInfoModel

    // MARK: - body
    var body: some View {
        HStack(spacing: 20) {
            bankAndIbanDisplayText
            copyShareDeleteButtons
        }
    }
    
    // MARK: - Private Views and Methods
    private var bankAndIbanDisplayText: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(iban.bankName)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.customAccentColor)
            
            Text(iban.iban)
                .font(.system(size: 14))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.customAccentColor, lineWidth: 2)
        )
    }
    
    private var copyShareDeleteButtons: some View {
                
                HStack(spacing: 24) {
                    Button {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = iban.iban
                    } label: {
                        customImageButton(systemImageName: "doc.on.doc.fill")
                    }

                    ShareLink(item: iban.iban) {
                        customImageButton(systemImageName: "square.and.arrow.up.fill")
                    }
                   
                    Button {
                        guard let index = person.ibanInfo.firstIndex(where: { $0.id == iban.id }) else { return }
                        person.ibanInfo.remove(at: index)
                        AuthenticationManager.shared.updateIban(person: person)
                    } label: {
                        customImageButton(systemImageName: "trash.fill")
                    }
                }
                .frame(height: 56.0)
                .foregroundColor(.gray)
            }
    
    private func customImageButton(systemImageName: String) -> some View {
        Image(systemName: systemImageName)
            .resizable()
            .scaledToFit()
            .frame(height: 24.0)
    }
}

