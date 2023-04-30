//
//  MessageListViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/25.
//
import SwiftUI
import PKHUD

class MessageListViewModel: ObservableObject {
    let messageCategory = ["事前チャット", "やり取り中","完了した取引"]
    
    @Published var mentorMessages: [MessageListData] = []
    @Published var studentsMessages: [MessageListData] = []
    @Published var prePurchaseMentorMessages: [MessageListData] = []
    @Published var prePurchaseStudentsMessages: [MessageListData] = []
    @Published var completionLessonAsMentorMessages: [MessageListData] = []
    @Published var completionLessonAsStudentMessages: [MessageListData] = []
    @Published var selection = 0
    
    init(){
        HUD.flash(.progress)
        fetchAll()
    }
    
    private func fetchAll(){
        // MARK: Mentorモードの場合、自身の生徒とのチャット情報取得
        FetchFromFirestore().fetchStudentMessageInfo(path: "Chat"){ studentChatRoom in
            FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: studentChatRoom.studentUid) { userInfo in
                FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: studentChatRoom.lessonId) { lessonInfo in
                    let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: studentChatRoom.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: studentChatRoom.lastMessageText, lastMessageDate: studentChatRoom.lastMessageDate, chatRoomData: studentChatRoom)
                    self.studentsMessages.append(messageData)
                }
                
            }
        }
        // MARK: (事前)Mentorモードの場合、自身の生徒とのチャット情報取得
        FetchFromFirestore().fetchStudentMessageInfo(path: "BeforePurchaseChat") { prePurchaseStudentChatRoom in
            FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: prePurchaseStudentChatRoom.studentUid) { userInfo in
                FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: prePurchaseStudentChatRoom.lessonId) { lessonInfo in
                    let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget,lessonID: prePurchaseStudentChatRoom.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: prePurchaseStudentChatRoom.lastMessageText, lastMessageDate: prePurchaseStudentChatRoom.lastMessageDate, chatRoomData: prePurchaseStudentChatRoom)
                    self.prePurchaseStudentsMessages.append(messageData)
                }
            }
        }
        // MARK: Studentモードの場合の、自身のメンターとのチャット情報取得
        FetchFromFirestore().fetchMentorMessageInfo(path: "Chat") { mentorChatRoom in
            FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: mentorChatRoom.mentorUid) { userInfo in
                FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: mentorChatRoom.lessonId) { lessonInfo in
                    let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: lessonInfo.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: mentorChatRoom.lastMessageText, lastMessageDate: mentorChatRoom.lastMessageDate, chatRoomData: mentorChatRoom)
                    if lessonInfo.completionUser.contains(userInfo.uid) {
                        self.completionLessonAsStudentMessages.append(messageData)
                    } else {
                        self.mentorMessages.append(messageData)
                    }
                }
            }
        }
        // MARK: (事前)Studentモードの場合の、自身のメンターとのチャット情報取得
        FetchFromFirestore().fetchMentorMessageInfo(path: "BeforePurchaseChat") { prePurchaseMentorChatRoom in
            FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: prePurchaseMentorChatRoom.mentorUid) { userInfo in
                FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: prePurchaseMentorChatRoom.lessonId) { lessonInfo in
                    let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: lessonInfo.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: prePurchaseMentorChatRoom.lastMessageText, lastMessageDate: prePurchaseMentorChatRoom.lastMessageDate, chatRoomData: prePurchaseMentorChatRoom)
                    if lessonInfo.completionUser.contains(userInfo.uid) {
                        self.completionLessonAsMentorMessages.append(messageData)
                    } else {
                        self.studentsMessages.append(messageData)
                        HUD.hide()
                    }
                }
            }
        }
    }
}
