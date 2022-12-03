//
//  Firestore.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/04.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import SwiftUI

let db = Firestore.firestore()
let storage = Storage.storage()

class FetchFromFirestore{
    @EnvironmentObject var appState:AppState
    let uid = Auth.auth().currentUser?.uid
    let userPath = "User"
    let lessonPath = "Lesson"
    let chatPath = "Chat"
    let requestPath = "Request"
    
    func fetchUserInfoFromFirestore(completion: @escaping (UserData)-> Void){
        guard let uid = uid else { return }
        db.collection(userPath).document(uid).getDocument { document, error in
            if let error = error {
                print("Error=>fetchUserInfoFromFirestore:\(error)")
                return
            }
            guard let document = document else { return }
            let docRef = UserData(document: document)
            completion(docRef)
        }
    }
    func fetchOtherUserInfoFromFirestore(uid: String,completion: @escaping (UserData)-> Void){
        db.collection(userPath).document(uid).getDocument { document, error in
            if let error = error {
                print("Error=>fetchUserInfoFromFirestore:\(error)")
                return
            }
            guard let document = document else { return }
            let docRef = UserData(document: document)
            completion(docRef)
        }
    }
    
    func fetchLessonInfoFromFirestore(completion: @escaping (LessonData)-> Void){
        db.collection(lessonPath).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error=>fetchLessonInfoFromFirestore:\(error)")
                return
            }
            querySnapshot?.documentChanges.forEach({ diff in
                if (diff.type == .added){
                    let lessonData = LessonData(document: diff.document)
                    completion(lessonData)
                }
            })
        }
    }
    
    func fetchOneLessonInfoFromFirestore(lessonId: String, completion: @escaping (LessonData)-> Void){
        db.collection(lessonPath).document(lessonId).getDocument { document, error in
            if error != nil {
                print("Error=>fetchOneLessonInfoFromFirestore:\(String(describing: error))")
                return
            }
            guard let document = document else { return }
            let lessonData = LessonData(document: document)
            completion(lessonData)
        }
    }
    
    func fetchStudentMessageInfo(completion:@escaping(ChatRoomData)-> Void){
        guard let uid = uid else { return }
        db.collection("Chat").whereField("studentUid", isEqualTo: uid).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error=>fetchMessageCategoryInfo2:\(error)")
                return
            }
            querySnapshot?.documents.forEach({ document in
                let messageData =  ChatRoomData(document: document)
                completion(messageData)
            })
        }
    }
    
    func fetchMentorMessageInfo(completion:@escaping (ChatRoomData) -> Void){
        guard let uid = uid else { return }
        db.collection("Chat").whereField("mentorUid", isEqualTo: uid).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error=>fetchMessageCategoryInfo2:\(error)")
                return
            }
            querySnapshot?.documents.forEach({ document in
                let messageData =  ChatRoomData(document: document)
                completion(messageData)
            })
        }
    }
    
    func fetchRequestInfoFromFirestore(completion: @escaping (RequestData)-> Void){
        db.collection(requestPath).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error=>fetchRequestInfoFromFirestore:\(error)")
                return
            }
            querySnapshot?.documentChanges.forEach({ diff in
                if (diff.type == .added){
                    let requestData = RequestData(document: diff.document)
                    completion(requestData)
                }
            })
        }
    }
    
    func fetchChatRoomInfoFromFirestore(path: String, lessonId: String, mentorUid: String, completion: @escaping (ChatRoomData) -> Void){
        guard let studentUid = uid else { return }
        db.collection(path).document(mentorUid+studentUid).getDocument { document, error in
            if error != nil {
                return
            }
            guard let document = document else { return }
            if document.exists {
                let chatroomData = ChatRoomData(document: document)
                completion(chatroomData)
            }else{
                SetToFirestore().registerChatRoomInfo(path: path, lessonId: lessonId, mentorUid: mentorUid, studentuid:studentUid){
                    completion($0)
                }
            }
        }
    }
    
    func fetchCompletionTransactionFromFirestore(){
        
    }
    
    func fetchQuestionInfoFromFirestore(lessonId: String){
        
    }
}

class SetToFirestore{
    
    let uid = Auth.auth().currentUser?.uid
    @EnvironmentObject var user: User
    func registerUserInfoFirestore(uid: String, username: String, email: String, customerId: String, completion: @escaping ()-> Void){
        db.collection("User").document(uid).setData([
            "username": username,
            "email": email,
            "profileImageURL": "https://firebasestorage.googleapis.com/v0/b/marketsns.appspot.com/o/UserProfile%2Furban-user-3.png?alt=media&token=94166887-d8d6-4ab6-9a01-457a774ed51c",
            "customerId": customerId
        ]){ err in
            if let err = err {
                print("Error=>registerUserInfoFirestore:\(String(describing: err))")
            } else {
                completion()
            }
        }
    }
    
    func registerLessonInfoFirestore(lessonName: String, lessonContents: String,lessonImageURLString:String , bigCategory: String ,lessonCategory:String, budget: Int,period: String, completion: @escaping (String)-> Void){
        guard let uid = uid else { return }
        var ref: DocumentReference? = nil
        ref = db.collection("Lesson").addDocument(data: [
            "mentorUid": uid,
            "lessonName": lessonName,
            "lessonImageURLString": lessonImageURLString,
            "lessonContent": lessonContents,
            "bigCategory": bigCategory,
            "category": lessonCategory,
            "budget": budget,
            "period": period
        ]){err in
            if let err = err {
                print("Error=>registerLessonInfoFirestore:\(String(describing: err))")
            }else{
                completion(ref!.documentID)
            }
        }
    }
    
    func registerRequestInfoFirestore(requestName: String, requestContents: String, bigCategory: String ,selectedCategory:String, requestImageURL:String?, budget:Int, date:Date, period: String, completion: @escaping ()-> Void){
        guard let menteeUid = uid else { return }
        
        db.collection("Request").addDocument(data: [
            "menteeUid": menteeUid,
            "requestName": requestName,
            "requestContents": requestContents,
            "bigCategory": bigCategory,
            "selectedCategory": selectedCategory,
            "requestImage": requestImageURL ?? "",
            "budget": budget,
            "date": date,
            "period": period
        ]){ err in
            if let err = err {
                print("Error=>registerRequestInfoFIrestore\(err)")
            }else{
                completion()
            }
        }
    }
    
    func registerChatRoomInfo(path: String, lessonId: String, mentorUid:String, studentuid: String, completion: @escaping (ChatRoomData) -> Void){
        let chatRoomRef = db.collection(path).document(mentorUid+studentuid)
        chatRoomRef.setData([
            "lessonId": lessonId,
            "mentorUid": mentorUid,
            "studentUid": studentuid
        ]){ error in
            if let error = error {
                print("Error=>registerMessageInfo:\(error)")
            }else{
                chatRoomRef.getDocument(completion: { document, error in
                    if let error = error {
                       print("\(error)")
                        return
                    }
                    guard let document = document else {
                        print("よきせぬError")
                        return }
                    let chatroomData = ChatRoomData(document: document)
                    completion(chatroomData)
                })
            }
        }
    }
    
    func registerMessage(path: String,chatRoomId: String, messageText:String, messageDate: String){
        guard let uid = uid else { return }
        db.collection(path).document(chatRoomId).collection("Message").addDocument(data: [
            "messageText": messageText,
            "messageDate": messageDate,
            "senderUid": uid
        ]){ error in
            if let error = error {
                print("Error=>registerMessage\(error)")
            }
        }
    }
    
    func snapShotMessage(path: String,chatRoomId: String,completion: @escaping (ChatData)-> Void){
        db.collection(path).document(chatRoomId).collection("Message").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error=>registerMessageInfo:\(error)")
                return
            }
            querySnapshot?.documentChanges.forEach({ diff in
                switch diff.type{
                case .added: completion(ChatData(document: diff.document))
                case .modified, .removed: print("nothing to do")
                }
            })
        }
    }
    
    func registerQuestionToLesson(lessonId: String, questionText: String, completion:@escaping ()-> Void){
        guard let uid = uid else { return }
        db.collection("Question").addDocument(data: [
            "lessonId": lessonId,
            "questionUserUid": uid,
            "questionText": questionText,
            "answerText": ""
        ]){ error in
            if let error = error {
                print("Error=>registerQuestionToLesson:\(error)")
            }else{
                completion()
            }
        }
    }
}

class UpdateFirestore{
    let uid = Auth.auth().currentUser?.uid
    @EnvironmentObject var user: User
    
    func updatePaymentIntent(lessonId: String, completion: @escaping ()->Void){
        guard let uid = uid else { return }
        db.collection("User").document(uid).updateData([
            "purchasedLessons": FieldValue.arrayUnion([lessonId])
        ]){ error in
            if let error = error {
                print("Error=>updatePaymentIntent:\(error)")
            }else{
                completion()
            }
        }
    }
    
    func updateUsersMakeLesson(lessonId: String, completion: @escaping()->Void){
        guard let uid = uid else { return }
        db.collection("User").document(uid).updateData([
            "openingLesson": FieldValue.arrayUnion([lessonId])
        ]){ error in
            if let error = error {
                print("Error=>updateUsersMakeLesson:\(error)")
            }else{
                completion()
            }
        }
    }
    
    func updateUserInfoFirestore(profileImageURL: String, completion: @escaping () -> Void){
        
        guard let uid = uid else { return }
        db.collection("User").document(uid).updateData([
            "profileImageURL": profileImageURL
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                completion()
            }
        }
    }
    
    func updateLastMessage(lastMessageText: String, lastMessageDate: String){
        db.collection("Chat").document().updateData([
            "lastMessageText": lastMessageText,
            "lastMessageDate": lastMessageDate
        ]){ error in
            if let error = error {
                print("Error \(error)")
                return
            }
        }
    }
}

class RemoveFirestore{
    
}

class RegisterStorage{
    func refisterUserInfo(profileImage: UIImage,completion: @escaping (URL)-> Void ){
        guard let updateImage = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let userProfileRef = storage.reference().child("UserProfile").child(fileName)
        userProfileRef.putData(updateImage, metadata: nil) { metadata, error in
            if error != nil {
                print(error ?? "")
                return
            }
            guard metadata != nil else {
                return
            }
            userProfileRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    return
                }
                completion(downloadURL)
            }
        }
    }
}
