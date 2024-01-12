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
            
            DeleteComponentButton
            
            BankNameView
            
            IbanTextView
            
            ScanIbanButton
        })
        .padding()
        .overlay(content: {
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color(red: 101/255, green: 82/255, blue: 254/255))
        })
        .padding()
        .preferredColorScheme(.dark)
        .onChange(of: ibanInfo.bankName) { _ in
            viewModel.changeIbanBankName(ibanInfo: ibanInfo)
        }
        .onChange(of: ibanInfo.iban) { _ in
            viewModel.changeIbanIban(ibanInfo: ibanInfo)
        }
    }
    
    // MARK: - Views
    
    private var DeleteComponentButton: some View {
        
        HStack(spacing: 8, content: {
            
            Spacer()
            
            Button(action: {
                viewModel.deleteIban(ibanInfo: ibanInfo)
            }, label: {
                
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.red)
                    .overlay(content: {
                        
                        Image(systemName: "trash.fill")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 12, height: 15)
                    })
            })
        })
    }
    
    private var BankNameView: some View {
        
        VStack(spacing: 8, content: {
            
            Text("Bank Name")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter Bank Name", text: $ibanInfo.bankName)
                .textFieldStyle(.roundedBorder)
        })
    }
    
    private var IbanTextView: some View {
        
        VStack(spacing: 8, content: {
            
            Text("iBan")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter iBan", text: $ibanInfo.iban)
                .textFieldStyle(.roundedBorder)
        })
    }
    
    private var ScanIbanButton: some View {
        
        Button(action: {
            coordinator.navigate(to: .dataScannerView)
        }, label: {
            NavigationLink(value: "navigateToScanner") {
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
            }
        })
        .foregroundStyle(.black)
        .navigationDestination(for: String.self) { destination in
            
        }
    }
}

#Preview {
    BankAndIbanComponentView(viewModel: AddNewPersonIbanViewModel(), ibanInfo: IbanInfo(bankName: "", iban: ""), coordinator: UIKitNavigationController.Coordinator())
}
  
