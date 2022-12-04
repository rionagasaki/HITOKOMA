//
//  LoginReducer.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/17.
//

import SwiftUI
import ComposableArchitecture
import Combine
import CoreMedia

struct LoginReducer {
    static let reducer = Reducer<LoginState, LoginAction, LoginEnvironment>{ state, action, environment in
        switch action {
        case .enterEmailText(let email):
            state.emailText = email
            return .none
        case .enterPasswordText(let password):
            state.passwordText = password
            if password.count <= 8 {
                state.loginButtonEnabled = true
            }else{
                state.loginButtonEnabled = false
            }
            return .none
        case .loginButtonTapped(let email, let password):
            return .none
        case .loginResponse(.failure):
            state.isLoginSuccess = false
            return .none
        case .loginResponse(.success):
            state.isLoginSuccess = true
            return .none
        case .registerButtonTapped(let email, let password):
            return .none
        case .enterUsernameText(let username):
            state.usernameText = username
            return .none
        }
    }
}
