//
//  AddIbanSheetView.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 13.01.24.
//

import SwiftUI

struct AddIbanSheetView: View {
    
    // MARK: - Properties
    @State var bankNameText: String = ""
    @State var ibanText: String = ""
    @Binding var person: PersonInfoModel
    @Environment(\.dismiss) private var dismiss
    var coordinator: UIKitNavigationController.Coordinator

    // MARK: - body
    var body: some View {
        
        VStack(spacing: 25) {
            
            Text("Add New iBan")
                .fontWeight(.bold)
            
            iBanDataEntryTextFields
            iBanButtonsStackView
            
            Spacer()
        }
        .padding(.top, 25)
    }
    
    
    // MARK: - Private Views
    private var iBanDataEntryTextFields: some View {
        
        VStack(spacing: 20) {
            
            CustomTextField(
                titleText: "Bank Name",
                displayText: "Enter Bank Name",
                textfieldText: $bankNameText
            )
            CustomTextField(
                titleText: "iBan",
                displayText: "Enter iBan",
                textfieldText: $ibanText
            )
        }
        .padding(.horizontal)
    }
    
    private var iBanButtonsStackView: some View {
        
            Button {
                person.ibanInfo.append(IbanInfo(id: UUID(), bankName: bankNameText, iban: ibanText))
                AuthenticationManager.shared.updateIban(person: person)
                dismiss()
            } label: {
                PrimaryButtonComponentView(text: "Add Iban")
            }
        }
    }

