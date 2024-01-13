//
//  IbanListPageView.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 12.01.24.
//

import SwiftUI

struct IbanListPageView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel = IbanListPageViewModel()
    var coordinator: UIKitNavigationController.Coordinator
    
    // MARK: - body
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color.customBackgroundColor
                .ignoresSafeArea()
            
            personListScrollView
            
            AddPersonAndIbanButtonStack
        }
        .task {
            viewModel.fetchPersonInfo()
        }
    }
    
    // MARK: - Private Views
    private var personListScrollView: some View {
        VStack {
        Text("iBan's List")
            .foregroundStyle(.white)
            .font(.system(size: 20, weight: .bold))
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                ForEach(viewModel.personsArray) { person in
                    
                    IbanListItemView(person: person)
                        .onTapGesture {
                            coordinator.navigate(to: .ibanDetailsPage(personInfo: person))
                        }
                }
            }
        }
        .padding(.bottom, 80)
    }
}
    
    private var AddPersonAndIbanButtonStack: some View {
        
        VStack {
            Button {
                coordinator.navigate(to: .addNewPersonIbanView)
            } label: {
                PrimaryButtonComponentView(text: "Add Person and IBan")
            }
        }
        .frame(height: 60)
        .background(Color.customBackgroundColor)
    }
}
