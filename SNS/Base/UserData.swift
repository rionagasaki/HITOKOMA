//
//  User.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/04.
//

import Foundation
import FirebaseFirestore

class UserData {

    var uid: String
    var username: String
    var email: String
    var profileImage: String
    var customerId: String
    
    init(document: QueryDocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()
        self.username = userDic["username"] as? String ?? ""
        self.email = userDic["email"] as? String ?? ""
        self.profileImage = userDic["profileImageURL"] as? String ?? ""
        self.customerId = userDic["customerId"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()!
        self.username = userDic["username"] as? String ?? ""
        self.email = userDic["email"] as? String ?? ""
        self.profileImage = userDic["profileImageURL"] as? String ?? ""
        self.customerId = userDic["customerId"] as? String ?? ""
    }
}

class LessonData: Identifiable {
    let id = UUID()
    var mentorUid: String
    var lessonId: String
    var lessonName: String
    var lessonContent: String
    var lessonImageURLString: String
    var bigCategory: String
    var category: String
    var budget: Int
    var period: String
    var userImageIconURLString: String = ""
    var username : String = ""
    
    init(document: QueryDocumentSnapshot) {
        self.lessonId = document.documentID
        let lessonDic = document.data()
        self.mentorUid = lessonDic["mentorUid"] as? String ?? ""
        self.lessonName = lessonDic["lessonName"] as? String ?? ""
        self.lessonContent = lessonDic["lessonContent"] as? String ?? ""
        self.lessonImageURLString = lessonDic["lessonImageURLString"] as? String ?? ""
        self.bigCategory = lessonDic["bigCategory"] as? String ?? ""
        self.category = lessonDic["category"] as? String ?? ""
        self.budget = lessonDic["budget"] as? Int ?? 0
        self.period = lessonDic["period"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot){
        self.lessonId = document.documentID
        let lessonDic = document.data()
        self.mentorUid = lessonDic?["mentorUid"] as? String ?? ""
        self.lessonName = lessonDic?["lessonName"] as? String ?? ""
        self.lessonContent = lessonDic?["lessonContent"] as? String ?? ""
        self.lessonImageURLString = lessonDic?["lesssonImageURLString"] as? String ?? ""
        self.bigCategory = lessonDic?["bigCategory"] as? String ?? ""
        self.category = lessonDic?["category"] as? String ?? ""
        self.budget = lessonDic?["budget"] as? Int ?? 0
        self.period = lessonDic?["period"] as? String ?? ""
    }
}

class RequestData: Identifiable {
    let id = UUID()
    var requestId: String
    var requestName: String
    var requestContent: String
    var requestImage: [String]
    var requestUserUid: String
    var bigCategory: String
    var category: String
    var userImageIconURL: String = ""
    var username : String = ""
    init(document: QueryDocumentSnapshot){
        self.requestId = document.documentID
        let requestDic = document.data()
        self.requestName = requestDic["requestName"] as? String ?? ""
        self.requestContent = requestDic["requestContents"] as? String ?? ""
        self.requestImage = requestDic["requestImage"] as? [String] ?? []
        self.bigCategory = requestDic["bigCategory"] as? String ?? ""
        self.category = requestDic["selectedCategory"] as? String ?? ""
        self.requestUserUid = requestDic["menteeUid"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot){
        self.requestId = document.documentID
        let requestDic = document.data()
        self.requestName = requestDic?["requestName"] as? String ?? ""
        self.requestContent = requestDic?["requestContents"] as? String ?? ""
        self.requestImage = requestDic?["requestImage"] as? [String] ?? []
        self.bigCategory = requestDic?["bigCategory"] as? String ?? ""
        self.category = requestDic?["selectedCategory"] as? String ?? ""
        self.requestUserUid = requestDic?["menteeUid"] as? String ?? ""
    }
}

class UserInfo: ObservableObject{
    @Published var username: String = ""
    @Published var userIconUrlString: String = ""
}
