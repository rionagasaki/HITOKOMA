//
//  MessageCompletionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/02.
//

import SwiftUI

struct MessageListScrollView: View {
    @Binding var chatRoomData: ChatRoomData?
    let messageListDatas:[MessageListData]
    let messageListStyle: MessageListStyle
    var body: some View {
        ScrollView{
            VStack(spacing: .zero){
                ForEach(messageListDatas) { messageList in
                    OneMessageListView(messageListStyle: messageListStyle, lastMessage: messageList.lastMessage, talkUserUid: messageList.senderUid, talkUserName: messageList.senderName, talkUserIconImageURLString: messageList.senderIconImage, lessonId: messageList.lessonID, lessonName: messageList.lessonName, lessonContents: messageList.lessonContents, lessonBudgets: messageList.lessonBudgets, lessonImageURLString: messageList.lessonImage, chatRoomData: $chatRoomData)
                }
            }
        }
    }
}

