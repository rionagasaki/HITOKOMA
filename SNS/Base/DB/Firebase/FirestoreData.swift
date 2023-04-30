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
    var headerImage: String
    var gender: String
    var generation: String
    var singleIntroduction: String
    var career: String
    var customerId: String
    var purchasedLessons: [String]
    var skills: Skills?
    
    
    init(document: QueryDocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()
        self.username = (userDic["username"] as? String).orEmpty
        self.email = (userDic["email"] as? String).orEmpty
        self.profileImage = (userDic["profileImageURL"] as? String).orEmpty
        self.customerId = (userDic["customerId"] as? String).orEmpty
        self.purchasedLessons = (userDic["purchasedLessons"] as? [String]).orEmptyArray
        self.generation = (userDic["generation"] as? String).orEmpty
        self.gender = (userDic["gender"] as? String).orEmpty
        self.career = (userDic["career"] as? String).orEmpty
        self.headerImage = (userDic["headerImageURL"] as? String).orEmpty
        self.singleIntroduction = (userDic["singleIntroduction"] as? String).orEmpty
    }
    
    init(document: DocumentSnapshot){
        self.uid = document.documentID
        let userDic = document.data()
        let skills = try? Firestore.Decoder().decode(Skills.self, from: userDic?["skills"] as? Dictionary<String, Any> as Any)
        
        self.skills = skills
        self.username = (userDic?["username"] as? String).orEmpty
        self.email = (userDic?["email"] as? String).orEmpty
        self.profileImage = (userDic?["profileImageURL"] as? String).orEmpty
        self.customerId = (userDic?["customerId"] as? String).orEmpty
        self.purchasedLessons = (userDic?["purchasedLessons"] as? [String]).orEmptyArray
        self.generation = (userDic?["generation"] as? String).orEmpty
        self.gender = (userDic?["gender"] as? String).orEmpty
        self.career = (userDic?["career"] as? String).orEmpty
        self.headerImage = (userDic?["headerImageURL"] as? String).orEmpty
        self.singleIntroduction = (userDic?["singleIntroduction"] as? String).orEmpty
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
    var completionUser: [String]
    
    init(document: QueryDocumentSnapshot) {
        self.lessonId = document.documentID
        let lessonDic = document.data()
        self.mentorUid = (lessonDic["mentorUid"] as? String).orEmpty
        self.lessonName = (lessonDic["lessonName"] as? String).orEmpty
        self.lessonContent = (lessonDic["lessonContent"] as? String).orEmpty
        self.lessonImageURLString = (lessonDic["lessonImageURLString"] as? String).orEmpty
        self.bigCategory = (lessonDic["bigCategory"] as? String).orEmpty
        self.category = (lessonDic["category"] as? String).orEmpty
        self.budget = (lessonDic["budget"] as? Int).orEmptyNum
        self.period = (lessonDic["period"] as? String).orEmpty
        self.completionUser = (lessonDic["completionUser"] as? [String]).orEmptyArray
    }
    
    init(document: DocumentSnapshot){
        self.lessonId = document.documentID
        let lessonDic = document.data()
        self.mentorUid = (lessonDic?["mentorUid"] as? String).orEmpty
        self.lessonName = (lessonDic?["lessonName"] as? String).orEmpty
        self.lessonContent = (lessonDic?["lessonContent"] as? String).orEmpty
        self.lessonImageURLString = (lessonDic?["lessonImageURLString"] as? String).orEmpty
        self.bigCategory = (lessonDic?["bigCategory"] as? String).orEmpty
        self.category = (lessonDic?["category"] as? String).orEmpty
        self.budget = (lessonDic?["budget"] as? Int).orEmptyNum
        self.period = (lessonDic?["period"] as? String).orEmpty
        self.completionUser = (lessonDic?["completionUser"] as? [String]).orEmptyArray
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
    var period: String
    var budget: Int
    var userImageIconURL: String = ""
    var username : String = ""
    
    init(document: QueryDocumentSnapshot){
        self.requestId = document.documentID
        let requestDic = document.data()
        self.requestName = (requestDic["requestName"] as? String).orEmpty
        self.requestContent = (requestDic["requestContents"] as? String).orEmpty
        self.requestImage = (requestDic["requestImage"] as? [String]).orEmptyArray
        self.bigCategory = (requestDic["bigCategory"] as? String).orEmpty
        self.category = (requestDic["selectedCategory"] as? String).orEmpty
        self.period = (requestDic["period"] as? String).orEmpty
        self.budget = (requestDic["budget"] as? Int).orEmptyNum
        self.requestUserUid = (requestDic["menteeUid"] as? String).orEmpty
    }
    
    init(document: DocumentSnapshot){
        self.requestId = document.documentID
        let requestDic = document.data()
        self.requestName = (requestDic?["requestName"] as? String).orEmpty
        self.requestContent = (requestDic?["requestContents"] as? String).orEmpty
        self.requestImage = (requestDic?["requestImage"] as? [String]).orEmptyArray
        self.bigCategory = (requestDic?["bigCategory"] as? String).orEmpty
        self.category = (requestDic?["selectedCategory"] as? String).orEmpty
        self.period = (requestDic?["period"] as? String).orEmpty
        self.budget = (requestDic?["budget"] as? Int).orEmptyNum
        self.requestUserUid = (requestDic?["menteeUid"] as? String).orEmpty
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
        self.lessonId = (messageDic["lessonId"] as? String).orEmpty
        self.mentorUid = (messageDic["mentorUid"] as? String).orEmpty
        self.studentUid = (messageDic["studentUid"] as? String).orEmpty
        self.lastMessageText = (messageDic["lastMessageText"] as? String).orEmpty
        self.lastMessageDate = (messageDic["lastMessageDate"] as? String).orEmpty
    }
    
    init(document: DocumentSnapshot){
        self.chatroomId = document.documentID
        let messageDic = document.data()
        self.lessonId = (messageDic?["lessonId"] as? String).orEmpty
        self.mentorUid = (messageDic?["mentorUid"] as? String).orEmpty
        self.studentUid = (messageDic?["studentUid"] as? String).orEmpty
        self.lastMessageText = (messageDic?["lastMessageText"] as? String).orEmpty
        self.lastMessageDate = (messageDic?["lastMessageDate"] as? String).orEmpty
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
        self.messageText = (chatDic["messageText"] as? String).orEmpty
        self.messageImageURLString = (chatDic["messageImageURLString"] as? String).orEmpty
        self.messageType = (chatDic["messageType"] as? String).orEmpty
        self.messageDate = (chatDic["messageDate"] as? String).orEmpty
        self.senderUid = (chatDic["senderUid"] as? String).orEmpty
    }
    init(document: DocumentSnapshot){
        self.chatId = document.documentID
        let chatDic = document.data()
        self.messageText = (chatDic?["messageText"] as? String).orEmpty
        self.messageImageURLString = (chatDic?["messageImageURLString"] as? String).orEmpty
        self.messageType = (chatDic?["messageType"] as? String).orEmpty
        self.messageDate = (chatDic?["messageDate"] as? String).orEmpty
        self.senderUid = (chatDic?["senderUid"] as? String).orEmpty
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
        self.lessonID = (questionDic["lessonId"] as? String).orEmpty
        self.questionUserUid = (questionDic["questionUserUid"] as? String).orEmpty
        self.questionText = (questionDic["questionText"] as? String).orEmpty
        self.answerText = (questionDic["answerText"] as? String).orEmpty
    }
    
    init(document: DocumentSnapshot){
        self.questionID = document.documentID
        let questionDic = document.data()
        self.lessonID = (questionDic?["lessonId"] as? String).orEmpty
        self.questionUserUid = (questionDic?["questionUserUid"] as? String).orEmpty
        self.questionText = (questionDic?["questionText"] as? String).orEmpty
        self.answerText = (questionDic?["answerText"] as? String).orEmpty
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
        self.lessonId = (evalutionDic["lessonId"] as? String).orEmpty
        self.evalutionUserUid = (evalutionDic["evalutionUserUid"] as? String).orEmpty
        self.allEvalution = (evalutionDic["allEvalution"] as? Int).orEmptyNum
        self.easyToUnderstand = (evalutionDic["easyToUnderstand"] as? Int).orEmptyNum
        self.interesting = (evalutionDic["interesting"] as? Int).orEmptyNum
        self.review = (evalutionDic["review"] as? String).orEmpty
    }
    
    init(document: DocumentSnapshot){
        self.evalutionId = document.documentID
        let evalutionDic = document.data()
        self.lessonId = (evalutionDic?["lessonId"] as? String).orEmpty
        self.evalutionUserUid = (evalutionDic?["evalutionUserUid"] as? String).orEmpty
        self.allEvalution = (evalutionDic?["allEvalution"] as? Int).orEmptyNum
        self.easyToUnderstand = (evalutionDic?["easyToUnderstand"] as? Int).orEmptyNum
        self.interesting = (evalutionDic?["interesting"] as? Int).orEmptyNum
        self.review = (evalutionDic?["review"] as? String).orEmpty
    }
}
