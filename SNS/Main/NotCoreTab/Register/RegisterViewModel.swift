//
//  RegisterViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var usernameText: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var isNotEmptyUsername: Bool = false
    @Published var isCurrentEmail: Bool = false
    @Published var isCurrentPassword: Bool = false
    var isEnabledTappedRegisterButton: Bool { isNotEmptyUsername && isCurrentEmail && isCurrentPassword }
    
    func signUp(){
        Authentication().signUp(
            email: usernameText,
            password: passwordText,
            username: usernameText) { isSuccessRegister in
                if isSuccessRegister {
                    
                } else {
                    
                }
            }
    }
    
//    func isEmpty(text:String, isEmpty: inout Bool){
//        isEmpty = text == ""
//    }
    
    func validateEmail(){
        isCurrentEmail = emailText.isCurrentEmailFormat()
    }
    func validatePassword(){
        isCurrentPassword = passwordText.isCurrentPasswordFormat()
    }
    func validateUsername(){
        isNotEmptyUsername = usernameText != ""
    }
}
