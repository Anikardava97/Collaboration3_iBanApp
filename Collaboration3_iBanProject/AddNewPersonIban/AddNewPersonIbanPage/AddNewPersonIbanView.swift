//
//  AddNewPersonIbanView.swift
//  Collaboration3_iBanProject
//
//  Created by Luka Gazdeliani on 12.01.24.
//

import SwiftUI

struct AddNewPersonIbanView: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: AddNewPersonIbanViewModel
    var coordinator: UIKitNavigationController.Coordinator
    
    init(coordinator: UIKitNavigationController.Coordinator) {
        self._viewModel = StateObject(wrappedValue: AddNewPersonIbanViewModel())
        self.coordinator = coordinator
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack {
            
            pageHeaderView
            
            personNameView
            
            ibansHeaderView
            
            addIbansScrollView
            
            addPersonAndIbanButton
        }
        .background(Color.customBackgroundColor)
    }
    
    // MARK: - Views
    
    private var pageHeaderView: some View {
        Text("Add New Person and iBan")
            .foregroundStyle(.white)
            .font(.system(size: 16))
            .bold()
    }
    
    private var personNameView: some View {
        VStack(spacing: 8, content: {
            
            Text("Full Name")
                .foregroundStyle(.white)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack(alignment: .leading) {
                if viewModel.personFullName.isEmpty {
                    Text("Enter full name")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.6))
                }
                TextField("", text: $viewModel.personFullName)
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
        .padding()
    }
    
    private var ibansHeaderView: some View {
        HStack {
            
            Text("iBans")
                .foregroundStyle(.white)
                .font(.system(size: 14))
            
            Spacer()
            
            Button(action: {
                viewModel.ibanInfos.append(IbanInfo(bankName: "", iban: ""))
            }, label: {
                
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color(red: 101/255, green: 82/255, blue: 254/255))
                    .overlay(content: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 12, height: 12)
                    })
            })
        }
        .padding(.horizontal)
    }
    
    private var addIbansScrollView: some View {
        ScrollView {
            ForEach(viewModel.ibanInfos) { personIbanInfo in
                BankAndIbanComponentView(viewModel: viewModel, ibanInfo: personIbanInfo, coordinator: coordinator)
            }
        }
    }
    
    private var addPersonAndIbanButton: some View {
        Button(action: {
            viewModel.addPersonToList()
            #warning("send new person info back to previous page and go back to list page")
        }, label: {
            PrimaryButtonComponentView(text: "Add Person and iBan")
        })
        .padding()
        .foregroundStyle(.black)
    }
}

#Preview {
    AddNewPersonIbanView(coordinator: UIKitNavigationController.Coordinator())
}
