//
//  User.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/18.
//

import Foundation

class User: ObservableObject{
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var profileImage: String = ""
    @Published var selfIntroduce: String = ""
    @Published var schedule: String = ""
}
