//
//  PersonInfo.swift
//  Collaboration3_iBanProject
//
//  Created by Luka Gazdeliani on 12.01.24.
//

import Foundation

struct PersonInfo {
    var fullName: String
    var ibanInfo: [IbanInfo]
}

struct IbanInfo: Identifiable {
    let id = UUID()
    var bankName: String
    var iban: String
}
