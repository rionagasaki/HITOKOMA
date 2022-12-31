//
//  MemberInfoViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

class MemberInfoViewModel: ObservableObject {
    @Published var usernameField:String = ""
    @Published var genderField: Gender = .others
    @Published var ageField: String = ""
    @Published var instagramField: String = ""
    @Published var displayTwitterAccount: String = ""
    @Published var displayFacebookAccount: String = ""
    @Published var showImageModal: Bool = false
    @Published var profileImageURLString: String = ""
}

enum Gender:String {
    case man = "男性"
    case woman = "女性"
    case others = "未選択"
}
