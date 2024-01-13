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
    @Published var personsArray = [PersonInfoModel]()
    @Published var dummyIbanData: [PersonInfoModel] = [
        PersonInfoModel(
            fullName: "Anri Beridze",
            ibanInfo: [
                IbanInfo(
                    id: UUID(),
                    bankName: "BOG",
                    iban: "AdnuSD123kISdf1")
            ]
        )
    ]
    
    // MARK: - Private Methods
    func fetchPersonInfo() {
        AuthenticationManager.shared.fetchPersonData { personsInfoArray in
            self.personsArray = personsInfoArray
        }
    }
}
