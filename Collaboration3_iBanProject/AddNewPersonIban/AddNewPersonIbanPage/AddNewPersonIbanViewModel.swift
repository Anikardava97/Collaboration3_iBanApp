//
//  AddNewPersonIbanViewModel.swift
//  Collaboration3_iBanProject
//
//  Created by Luka Gazdeliani on 12.01.24.
//

import Foundation

final class AddNewPersonIbanViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var mockListArray: [PersonInfo] = []
    @Published var personFullName: String = ""
    @Published var ibanInfos: [IbanInfo] = [IbanInfo(bankName: "", iban: "")]
    
    // MARK: - Methods
    func changeIbanBankName(ibanInfo: IbanInfo) {
        
        guard let index = ibanInfos.firstIndex(where: { $0.id == ibanInfo.id }) else { return }
        
        ibanInfos[index].bankName = ibanInfo.bankName
    }
    
    func changeIbanIban(ibanInfo: IbanInfo) {
        
        guard let index = ibanInfos.firstIndex(where: { $0.id == ibanInfo.id }) else { return }
        
        ibanInfos[index].iban = ibanInfo.iban
    }
    
    func deleteIban(ibanInfo: IbanInfo) {
        guard let index = ibanInfos.firstIndex(where: { $0.id == ibanInfo.id }) else { return }

        ibanInfos.remove(at: index)
    }
    
    func addPersonToList() {
        mockListArray.append(PersonInfo(fullName: personFullName, ibanInfo: ibanInfos))
    }
}
