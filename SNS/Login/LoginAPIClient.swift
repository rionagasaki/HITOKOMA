//
//  LoginAPIClient.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/26.
//

import Foundation
import Combine
import ComposableArchitecture
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import FirebaseAuthCombineSwift

struct LoginAPIClient {
    let cancellables = Set<AnyCancellable>()
    var login: (String, String) -> Void
}

extension LoginAPIClient {
    
    
    
//    static func signIn(email:String, password:String) -> Result<Void,Error>{
//        Auth.auth().signInAnonymously().sink { completion in
//            switch completion{
//            case let .failure(error):
//                print(error.localizedDescription)
//                return .failure(error)
//            case .finished:
//                return Result.success
//            }
//        } receiveValue: { authResult in
//            authResult.user.uid
//        }
//    }
//
     static let createAccount = LoginAPIClient { email, password in
        Auth.auth().createUser(withEmail: email, password: password).sink { completion in
            switch completion{
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("all success!!")
            }
        } receiveValue: { authResult in
            
        }.cancel()
    }
    
    func registerFirestore(email:String, uid:String, completionHandler: @escaping()->Void){
        Firestore.firestore().collection("User").document(uid).setData([
            "name": email,
            "email": email
        ]).sink { completion in
            switch completion{
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                completionHandler()
            }
        } receiveValue: { result in
            print(result)
        }.cancel()
    }
}

enum LoginApiError: Error {
    case badRequest(Int)
    case changeError(Error)
}
