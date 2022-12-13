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
    var purchasedLessons: [String]
    
    init(document: QueryDocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()
        self.username = userDic["username"] as? String ?? ""
        self.email = userDic["email"] as? String ?? ""
        self.profileImage = userDic["profileImageURL"] as? String ?? ""
        self.customerId = userDic["customerId"] as? String ?? ""
        self.purchasedLessons = userDic["purchasedLessons"] as? [String] ?? []
    }
    
    init(document: DocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()
        self.username = userDic?["username"] as? String ?? ""
        self.email = userDic?["email"] as? String ?? ""
        self.profileImage = userDic?["profileImageURL"] as? String ?? ""
        self.customerId = userDic?["customerId"] as? String ?? ""
        self.purchasedLessons = userDic?["purchasedLessons"] as? [String] ?? []
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
        self.lessonImageURLString = lessonDic?["lessonImageURLString"] as? String ?? ""
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

class ChatRoomData: Identifiable{
    var id = UUID()
    var lessonId: String
    var chatroomId: String
    var mentorUid: String
    var studentUid: String
    var lastMessageText: String
    var lastMessageDate: String
    
    init(document: QueryDocumentSnapshot){
        self.chatroomId = document.documentID
        let messageDic = document.data()
        self.lessonId = messageDic["lessonId"] as? String ?? ""
        self.mentorUid = messageDic["mentorUid"] as? String ?? ""
        self.studentUid = messageDic["studentUid"] as? String ?? ""
        self.lastMessageText = messageDic["lastMessageText"] as? String ?? ""
        self.lastMessageDate = messageDic["lastMessageDate"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot){
        self.chatroomId = document.documentID
        let messageDic = document.data()
        self.lessonId = messageDic?["lessonId"] as? String ?? ""
        self.mentorUid = messageDic?["mentorUid"] as? String ?? ""
        self.studentUid = messageDic?["studentUid"] as? String ?? ""
        self.lastMessageText = messageDic?["lastMessageText"] as? String ?? ""
        self.lastMessageDate = messageDic?["lastMessageDate"] as? String ?? ""
    }
}

class ChatData: Identifiable{
    var id = UUID()
    var chatId: String
    var messageText: String
    var messageType: String
    var messageImageURLString: String
    var messageDate: String
    var senderUid: String
    
    init(document: QueryDocumentSnapshot){
        self.chatId = document.documentID
        let chatDic = document.data()
        // TextかImageかのどちらかが入る。
        self.messageText = chatDic["messageText"] as? String ?? ""
        self.messageImageURLString = chatDic["messageImageURLString"] as? String ?? ""
        self.messageType = chatDic["messageType"] as? String ?? ""
        self.messageDate = chatDic["messageDate"] as? String ?? ""
        self.senderUid = chatDic["senderUid"] as? String ?? ""
    }
    init(document: DocumentSnapshot){
        self.chatId = document.documentID
        let chatDic = document.data()
        self.messageText = chatDic?["messageText"] as? String ?? ""
        self.messageImageURLString = chatDic?["messageImageURLString"] as? String ?? ""
        self.messageType = chatDic?["messageType"] as? String ?? ""
        self.messageDate = chatDic?["messageDate"] as? String ?? ""
        self.senderUid = chatDic?["senderUid"] as? String ?? ""
    }
}

class QuestionToMentorData: Identifiable{
    var id = UUID()
    var questionID: String
    var lessonID: String
    var questionUserUid: String
    var questionText:String
    var answerText:String
    
    init(document: QueryDocumentSnapshot){
        self.questionID = document.documentID
        let questionDic = document.data()
        self.lessonID = questionDic["lessonId"] as? String ?? ""
        self.questionUserUid = questionDic["questionUserUid"] as? String ?? ""
        self.questionText = questionDic["questionText"] as? String ?? ""
        self.answerText = questionDic["answerText"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot){
        self.questionID = document.documentID
        let questionDic = document.data()
        self.lessonID = questionDic?["lessonId"] as? String ?? ""
        self.questionUserUid = questionDic?["questionUserUid"] as? String ?? ""
        self.questionText = questionDic?["questionText"] as? String ?? ""
        self.answerText = questionDic?["answerText"] as? String ?? ""
    }
}

class LessonEvalution: Identifiable {
    var id = UUID()
    var evalutionId: String
    var lessonId: String
    var evalutionUserUid: String
    var allEvalution: Int
    var easyToUnderstand: Int
    var interesting: Int
    var review: String
    
    init(document: QueryDocumentSnapshot){
        self.evalutionId = document.documentID
        let evalutionDic = document.data()
        self.lessonId = evalutionDic["lessonId"] as? String ?? ""
        self.evalutionUserUid = evalutionDic["evalutionUserUid"] as? String ?? ""
        self.allEvalution = evalutionDic["allEvalution"] as? Int ?? 0
        self.easyToUnderstand = evalutionDic["easyToUnderstand"] as? Int ?? 0
        self.interesting = evalutionDic["interesting"] as? Int ?? 0
        self.review = evalutionDic["review"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot){
        self.evalutionId = document.documentID
        let evalutionDic = document.data()
        self.lessonId = evalutionDic?["lessonId"] as? String ?? ""
        self.evalutionUserUid = evalutionDic?["evalutionUserUid"] as? String ?? ""
        self.allEvalution = evalutionDic?["allEvalution"] as? Int ?? 0
        self.easyToUnderstand = evalutionDic?["easyToUnderstand"] as? Int ?? 0
        self.interesting = evalutionDic?["interesting"] as? Int ?? 0
        self.review = evalutionDic?["review"] as? String ?? ""
    }
}
