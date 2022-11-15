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
}

class SetToFirestore{
    
    let uid = Auth.auth().currentUser?.uid
    
    func registerUserInfoFirestore(uid: String, username: String, email: String, customerId: String, completion: @escaping ()-> Void){
        db.collection("User").document(uid).setData([
            "username": username,
            "email": email,
            "customerId": customerId
        ]){ err in
            if let err = err {
                print("Error=>registerUserInfoFirestore:\(String(describing: err))")
            } else {
                completion()
            }
        }
    }
    
    func registerLessonInfoFirestore(lessonName: String, lessonContents: String,lessonImageURLString:String , bigCategory: String ,lessonCategory:String, budget: Int,period: String, completion: @escaping ()-> Void){
        guard let uid = uid else { return }
        db.collection("Lesson").addDocument(data: [
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
                completion()
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
    
    func registerMessageInfo(members:[String], lastMessage:String, lastMessageDate:String){
        db.collection("Chat").document().collection("Message").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
        }
    }
}

class UpdateFirestore{
    let uid = Auth.auth().currentUser?.uid
    
    func updatePaymentIntent(lessonId: String, completion: @escaping ()->Void){
        guard let uid = uid else { return }
        db.collection("User").document(uid).updateData([
            "purchasedLessons": FieldValue.arrayUnion([lessonId])
        ]){ error in
            if let error = error {
                print("Error=>updatePaymentIntent\(error)")
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
}

class RegisterStorage{
    func refisterUserInfo(profileImage: UIImage,completion: @escaping (URL)-> Void ){
        guard let updateImage = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let userProfileRef = storage.reference().child("UserProfile").child(fileName)
        let updateTask = userProfileRef.putData(updateImage, metadata: nil) { metadata, error in
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
