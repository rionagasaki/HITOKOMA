//
//  Firestore.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/04.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI


let db = Firestore.firestore()

class FetchFromFirestore{
    @EnvironmentObject var appState:AppState
    let uid = Auth.auth().currentUser?.uid
    let path = "User"
    func fetchUserInfoFromFirestore(completion: @escaping (UserData)-> Void){
        guard let uid = uid else { return }
        db.collection(path).document(uid).getDocument { document, error in
            if let error = error {
                print("Error=>fetchUserInfoFromFirestore:\(error)")
                return
            }
            guard let document = document else { return }
            let docRef = UserData(document: document)
            completion(docRef)
        }
    }
}

class SetToFirestore{
    func registerUserInfoFirestore(uid: String, username: String, email: String, customerId: String, completion: @escaping ()-> Void){
        
        db.collection("User").document(uid).setData([
            "username": username,
            "email": email,
            "customerId": customerId
        ]){ err in
                if let err = err {
                print("Error=>registerUserInfoFirestore:\(String(describing: err))")
            } else {
                completion()
            }
        }
    }
}


