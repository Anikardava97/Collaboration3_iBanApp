//
//  IbanDetailsView.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 13.01.24.
//

import SwiftUI

struct IbanDetailsView: View {
    
    // MARK: - Properties
    var coordinator: UIKitNavigationController.Coordinator
    @State var person: PersonInfoModel
    @State var sheetIsPresented: Bool = false
 
    // MARK: - body
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Color.customBackgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                titleDisplayView
                iBanList
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Private Views
    private var titleDisplayView: some View {
        
        HStack {
            Text(person.fullName)
                .font(.system(size: 18.0, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            
            addIbanButton
        }
    }
    
    private var addIbanButton: some View {
        
        Button {
            sheetIsPresented.toggle()
        } label: {
            Text("+ add iBan")
                .foregroundColor(.white)
                .frame(width: 106, height: 34)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.customAccentColor, lineWidth: 1)
                )
                .font(.system(size: 14.0, weight: .bold))
        }
        .sheet(isPresented: $sheetIsPresented) {
            AddIbanSheetView(person: $person, coordinator: coordinator)
                .presentationDetents([.fraction(0.6)])
        }
    }
    
    private var iBanList: some View {
        
        ScrollView {
            VStack(spacing: 32.0) {
                ForEach(person.ibanInfo) { iban in
                    
                    CustomIbanComponentView(iban: iban, person: $person)
                }
            }
        }
    }
}
