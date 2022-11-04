//
//  User.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/04.
//

import Foundation
import FirebaseFirestore

class UserData {

    var uid: String
    var username: String
    var email: String
    var profileImage: String
    var customerId: String
    
    init(document: QueryDocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()
        self.username = userDic["username"] as? String ?? ""
        self.email = userDic["email"] as? String ?? ""
        self.profileImage = userDic["profileImage"] as? String ?? ""
        self.customerId = userDic["customerId"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()!
        self.username = userDic["username"] as? String ?? ""
        self.email = userDic["email"] as? String ?? ""
        self.profileImage = userDic["profileImage"] as? String ?? ""
        self.customerId = userDic["customerId"] as? String ?? ""
    }
}
