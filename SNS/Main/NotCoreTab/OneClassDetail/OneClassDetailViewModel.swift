//
//  OneClassDetailViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/03.
//

import SwiftUI

class OneClassDetailViewModel: ObservableObject {
    @Published var preChatRoomData: ChatRoomData?
    @Published var chatroomData:ChatRoomData?
    @Published var lessonData: LessonData?
    @Published var mentorUserInfo: UserData?
    @Published var underBarOffset: CGFloat = 100
    @Published var purchasedLabelOffset: CGFloat = -170
    @Published var visiblePriceBubble: Bool = false
    
    
    var lessonId: String
    
    init(lessonId: String) {
        self.lessonId = lessonId
        fetchLessonInfo()
    }
    
    private func fetchLessonInfo() {
        FetchFromFirestore()
            .fetchOneLessonInfoFromFirestore(
                lessonId: lessonId) { lessonData in
                    self.lessonData = lessonData
                    FetchFromFirestore()
                        .fetchOtherUserInfoFromFirestore(uid: lessonData.mentorUid) { userData in
                            self.mentorUserInfo = userData
                        }
                    FetchFromFirestore()
                        .fetchChatRoomInfoFromFirestore(
                            path: "Chat",
                            lessonId: lessonData.lessonId,
                            mentorUid: lessonData.mentorUid) { chatRoomData in
                                self.chatroomData = chatRoomData
                            }
                    FetchFromFirestore()
                        .fetchChatRoomInfoFromFirestore(
                            path: "BeforePurchaseChat",
                            lessonId: lessonData.lessonId,
                            mentorUid: lessonData.mentorUid) { preChatRoomData in
                                self.preChatRoomData = preChatRoomData
                            }
                }
    }
}
