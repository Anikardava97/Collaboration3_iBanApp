//
//  IbanListPageViewModel.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 13.01.24.
//

import Foundation

final class IbanListPageViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var searchText: String = ""
    @Published var dummyIbanData: [PersonInfoModel] = [
        PersonInfoModel(
            fullName: "Anri Beridze",
            ibanInfo: [
                IbanInfo(
                    bankName: "BOG",
                    iban: "AdnuSD123kISdf1")
            ]
        )
    ]
    
    
    // MARK: - init
    
    
    // MARK: - Private Methods
}
