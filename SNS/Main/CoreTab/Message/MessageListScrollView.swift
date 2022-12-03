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
                    
                    OneMessageListView(messageListStyle: messageListStyle, talkUserIconImageURLString: messageList.senderIconImage, talkUserName: messageList.senderName, lastMessage: messageList.lastMessage, lessonImageURLString: messageList.lessonImage, lessonName: messageList.lessonName, chatRoomData: chatRoomData)
                }
            }
        }
    }
}

