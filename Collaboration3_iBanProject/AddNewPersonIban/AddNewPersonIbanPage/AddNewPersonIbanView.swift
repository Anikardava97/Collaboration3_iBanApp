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
        
        PageHeaderView
        
        PersonNameView
        
        IbansHeaderView
        
        AddIbansScrollView
        
        AddPersonAndIbanButton
    }
    
    // MARK: - Views
    
    private var PageHeaderView: some View {
        Text("Add New Person and iBan")
            .font(.system(size: 16))
            .bold()
    }
    
    private var PersonNameView: some View {
        VStack(spacing: 8, content: {
            
            Text("Full Name")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter Full Name", text: $viewModel.personFullName)
                .textFieldStyle(.roundedBorder)
        })
        .padding()
    }
    
    private var IbansHeaderView: some View {
        HStack {
            
            Text("iBans")
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
        .padding()
    }
    
    private var AddIbansScrollView: some View {
        ScrollView {
            ForEach(viewModel.ibanInfos) { personIbanInfo in
                BankAndIbanComponentView(viewModel: viewModel, ibanInfo: personIbanInfo, coordinator: coordinator)
            }
        }
    }
    
    private var AddPersonAndIbanButton: some View {
        Button(action: {
            viewModel.addPersonToList()
        }, label: {
            
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(Color(red: 101/255, green: 82/255, blue: 254/255))
                .background(.black)
                .overlay(content: {
                    Text("Add Person and iBan")
                        .font(.system(size: 16))
                        .bold()
                })
            
        })
        .padding()
        .foregroundStyle(.black)
    }
}

#Preview {
    AddNewPersonIbanView(coordinator: UIKitNavigationController.Coordinator())
}
