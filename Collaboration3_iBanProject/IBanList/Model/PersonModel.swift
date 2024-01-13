//
//  PersonModel.swift
//  Collaboration3_iBanProject
//
//  Created by Macbook Air 13 on 12.01.24.
//

import Foundation

struct PersonInfoModel: Identifiable {
    var id = UUID()
    var fullName: String
    var ibanInfo: [IbanInfo]
}

struct IbanInfo: Identifiable {
    let id: UUID
    var bankName: String
    var iban: String
}
