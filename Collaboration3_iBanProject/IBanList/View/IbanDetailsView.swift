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
            
            Spacer()
            
            Button {
                //
            } label: {
                Text("+ add iBan")
                    .frame(width: 106, height: 34)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.customAccentColor, lineWidth: 1)
                    )
                    .font(.system(size: 14.0, weight: .bold))
            }
        }
        .foregroundColor(.white)
    }
    
    private var iBanList: some View {
        
        ScrollView {
            
            VStack(spacing: 32.0) {
                
                ForEach(person.ibanInfo) { iban in
                    
                    CustomIbanComponentView(iban: iban)
                }
            }
        }
    }
}


// MARK: - Preview
//struct IbanDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        IbanDetailsView(person: PersonInfoModel(
//            fullName: "Anri Beridze",
//            ibanInfo: [
//                IbanInfo(
//                    bankName: "BOG",
//                    iban: "AdnuSD123kISdf1"),
//                IbanInfo(
//                    bankName: "TBC",
//                    iban: "AdnuSD123kISdf1"),
//                IbanInfo(
//                    bankName: "BOG",
//                    iban: "AdnuSD123kISdf1"),
//                IbanInfo(
//                    bankName: "TBC",
//                    iban: "AdnuSD123kISdf1"),
//            ]
//        ))
//    }
//}
