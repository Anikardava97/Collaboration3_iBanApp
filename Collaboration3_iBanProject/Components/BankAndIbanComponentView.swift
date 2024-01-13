//
//  BankAndIbanComponentView.swift
//  Collaboration3_iBanProject
//
//  Created by Luka Gazdeliani on 12.01.24.
//

import SwiftUI

struct BankAndIbanComponentView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: AddNewPersonIbanViewModel
    @State var ibanInfo: IbanInfo
    var coordinator: UIKitNavigationController.Coordinator
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(spacing: 16, content: {
            
            if viewModel.ibanInfos.count > 1 {
                deleteComponentButton
            }
            
            bankNameView
            
            ibanTextView
            
            scanIbanButton
        })
        .padding()
        .overlay(content: {
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.customAccentColor)
        })
        .padding()
        .onChange(of: ibanInfo.bankName) { _ in
            viewModel.changeIbanBankName(ibanInfo: ibanInfo)
        }
        .onChange(of: ibanInfo.iban) { _ in
            viewModel.changeIbanIban(ibanInfo: ibanInfo)
        }
    }
    
    // MARK: - Views
    
    private var deleteComponentButton: some View {
        
        HStack(spacing: 8, content: {
            
            Spacer()
            
            Button(action: {
                viewModel.deleteIban(ibanInfo: ibanInfo)
            }, label: {
                
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.red)
                    .overlay(content: {
                        
                        Image(systemName: "minus")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 12, height: 2)
                    })
            })
        })
    }
    
    private var bankNameView: some View {
        
        VStack(spacing: 8, content: {
            
            Text("Bank Name")
                .foregroundStyle(.white)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack(alignment: .leading) {
                if ibanInfo.bankName.isEmpty {
                    Text("Enter Bank Name")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.6))
                }
                TextField("", text: $ibanInfo.bankName)
            }
            .foregroundStyle(.white)
            .tint(.white)
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.customAccentColor.opacity(0.5), lineWidth: 1))
            .background(Color.customTextFieldColor)
        })
    }
    
    private var ibanTextView: some View {
        
        VStack(spacing: 8, content: {
            
            Text("iBan")
                .foregroundStyle(.white)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)

            ZStack(alignment: .leading) {
                if ibanInfo.iban.isEmpty {
                    Text("Enter iBan")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.6))
                }
                TextField("", text: $ibanInfo.iban)
            }
            .foregroundStyle(.white)
            .tint(.white)
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.customAccentColor.opacity(0.5), lineWidth: 1))
            .background(Color.customTextFieldColor)
        })
    }
    
    private var scanIbanButton: some View {
        
        Button(action: {
            coordinator.navigate(to: .dataScannerView(ibanInfo: $ibanInfo.iban))
        }, label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundStyle(.white)
                .background(.black)
                .overlay(content: {
                    HStack {
                        
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.black)
                        
                        Text("Scan iBan")
                            .font(.system(size: 16))
                    }
                })
            
        })
        .foregroundStyle(.black)
    }
}

#Preview {
    BankAndIbanComponentView(viewModel: AddNewPersonIbanViewModel(), ibanInfo: IbanInfo(bankName: "", iban: ""), coordinator: UIKitNavigationController.Coordinator())
}
  
