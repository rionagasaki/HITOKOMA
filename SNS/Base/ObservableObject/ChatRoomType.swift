//
//  ChatRoomType.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/11.
//

import Foundation

class ChatRoomType: ObservableObject {
    @Published var chatMode: MentorOrStudent = .student
    @Published var messageListStyle: MessageListStyle = .beforePurchaseChat
    
    init(chatMode: MentorOrStudent, messageListStyle: MessageListStyle) {
        self.chatMode = chatMode
        self.messageListStyle = messageListStyle
    }
}
