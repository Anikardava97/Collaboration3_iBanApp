//
//  AuthenticationManager.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 11.01.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct AuthorizationDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString ?? ""
    }
}

final class AuthenticationManager {
    //MARK: - Properties
    static let shared = AuthenticationManager()
    private init() { }
    
    //MARK: - Methods
    func createUser(email: String, password: String) async throws -> AuthorizationDataResultModel {
        let authorizationDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthorizationDataResultModel(user: authorizationDataResult.user)
    }
    
    func loginUser(email: String, password: String) async throws -> AuthorizationDataResultModel {
        let authorizationDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthorizationDataResultModel(user: authorizationDataResult.user)
    }
    
    func addPerson(person: PersonInfoModel) {
        let dataBase = Firestore.firestore()
        let reference = dataBase.collection("Persons").document(person.fullName)
        
        var ibanInfoArray = [[String: Any]]()
        for ibanInfo in person.ibanInfo {
            let ibanInfoDict: [String: Any] = [
                "id": ibanInfo.id.uuidString,
                "bankName": ibanInfo.bankName,
                "iban": ibanInfo.iban
            ]
            ibanInfoArray.append(ibanInfoDict)
        }
        
        let data: [String: Any] = [
            "fullName": person.fullName,
            "ibanInfo": ibanInfoArray
        ]
        
        reference.setData(data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
            }
        }
    }

    func fetchPersonData(completion: @escaping ([PersonInfoModel]) -> Void) {
        let dataBase = Firestore.firestore()
        let reference = dataBase.collection("Persons")
        
        reference.getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print("Error fetching documents: \(String(describing: error))")
                completion([])
                return
            }
            
            var personInfoArray = [PersonInfoModel]()
            
            for document in snapshot.documents {
                let data = document.data()
                let fullName = data["fullName"] as? String ?? ""
                
                var ibanInfoArray = [IbanInfo]()
                if let ibans = data["ibanInfo"] as? [[String: Any]] {
                    for ibanData in ibans {
                        let id = UUID(uuidString: ibanData["id"] as? String ?? "") ?? UUID()
                        let bankName = ibanData["bankName"] as? String ?? ""
                        let iban = ibanData["iban"] as? String ?? ""
                        let ibanInfo = IbanInfo(id: id, bankName: bankName, iban: iban)
                        ibanInfoArray.append(ibanInfo)
                    }
                }
                
                let person = PersonInfoModel(id: UUID(), fullName: fullName, ibanInfo: ibanInfoArray)
                personInfoArray.append(person)
            }
            
            completion(personInfoArray)
        }
    }
}
