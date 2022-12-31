//
//  PasswordChangeViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

class PasswordChangeViewModel: ObservableObject {
    @Published var currentPasswordField: String = ""
    @Published var newPasswordField: String = ""
    @Published var newConfirmationPasswordTextFIeld: String = ""
}
