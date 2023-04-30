//
//  User.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/18.
//

import Foundation

final class User: ObservableObject{
    
    static let shared: User = .init()
    
    private init() {}
    
    @Published var userID: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var profileImage: String = ""
    @Published var customerId: String = ""
    @Published var purchasedLesson: [String] = []
    @Published var selfIntroduce: String = ""
    @Published var gender: String = ""
    @Published var generation: String = ""
    @Published var career: String = ""
    @Published var skill: Skills?
    @Published var headerImage: String = ""
    @Published var schedule: String = ""
    
    func appendPurchaseLessons(lessonid: String){
        self.purchasedLesson.append(lessonid)
    }
}
