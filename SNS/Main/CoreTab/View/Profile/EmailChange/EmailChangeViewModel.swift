//
//  EmailChangeViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/25.
//

import SwiftUI
import FirebaseAuth

class EmailChangeViewModel: ObservableObject {
    @Published var newEmailField: String = ""
    @Published var validateFailure: Bool = false
    
    func sendChackingEmailButtonTapped(){
        if newEmailField.isCurrentEmailFormat() {
            Authentication().emailValidate {
                print("aaa")
            }
        } else {
            validateFailure = true
        }
    }
}
