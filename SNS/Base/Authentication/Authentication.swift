//
//  FirebaseAuthentication.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/26.
//

import Foundation
import FirebaseAuth

struct Authentication {
    func emailValidate(completion: @escaping()->()) {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                print(error)
            } else {
                completion()
            }
        }
    }
    
    func signIn(email: String, password:String, isSuccessLogin:@escaping (Bool)-> ()){
        Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
            if error != nil {
                isSuccessLogin(false)
                return
            }
            isSuccessLogin(true)
        }
    }
    
    func signUp(email: String, password: String, username: String, isSuccessRegister:@escaping (Bool)-> Void){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                isSuccessRegister(false)
                return
            }
            guard authResult != nil else {
                isSuccessRegister(false)
                return
            }
            CallCloudFunctions().setFunctions(email: authResult?.user.email ?? "") { customerId in
                SetToFirestore().registerUserInfoFirestore(uid: authResult!.user.uid, username: username, email: authResult!.user.email ?? "", customerId: customerId) {
                    isSuccessRegister(true)
                }
            }
        }
    }
    
    func resetPassword(email: String, completion:@escaping (Bool)->()){
        Auth.auth().languageCode = "ja_JP"
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if let error = error {
                print("パスワードリセットメールの送信に失敗した\(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func signOut() throws {
        try? Auth.auth().signOut()
    }
}
