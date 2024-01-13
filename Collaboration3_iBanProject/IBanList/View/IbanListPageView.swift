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
    
    
    // MARK: - body
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color.customBackgroundColor
                .ignoresSafeArea()
            
            personListScrollView
            
            AddPersonAndIbanButtonStack
        }
    }
    
    
    // MARK: - Private Views
    private var personListScrollView: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                ForEach(viewModel.dummyIbanData) { person in
                    
                    IbanListItemView(person: person)
                }
            }
        }
        .padding(.bottom, 80)
    }
    
    private var AddPersonAndIbanButtonStack: some View {
        
        VStack {
            
            PrimaryButtonComponentView(text: "Add Person and IBan")
        }
        .frame(height: 60)
        .background(Color.customBackgroundColor)
    }
}


// MARK: - Preview
struct IbanListPageView_Previews: PreviewProvider {
    static var previews: some View {
        IbanListPageView()
    }
}
