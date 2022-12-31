//
//  ForgetPasswordViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI
import PKHUD

class ForgetPasswordViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var isVisibleAlert: Bool = false
    
    func sendPasswordResetMail(){
        Authentication().resetPassword(email: emailText) { isSuccess in
            if isSuccess {
                HUD.show(.success)
                HUD.hide(afterDelay: 1)
            } else {
                self.isVisibleAlert = true
            }
        }
    }
}
