//
//  CompletionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct OneMessageListView: View {
    @ObservedObject var chatRoomType: ChatRoomType
    let messageListData: MessageListData
    var body: some View {
        VStack {
            NavigationLink {
                if chatRoomType.messageListStyle == .completion {
                    OneClassDetailView(lessonImageURLString: messageListData.lessonImage, mentorIconImageURLString: messageListData.senderIconImage, lessonId: messageListData.lessonID, mentorName: messageListData.senderName, mentorUid: messageListData.senderUid, lessonTitle: messageListData.lessonName, lessonContent: messageListData.lessonContents, budgets: messageListData.lessonBudgets)
                } else {
                    ChatView(messageListData: messageListData, chatRoomType: chatRoomType)
                }
            } label: {
                VStack(alignment: .leading){
                    Divider()
                    HStack(alignment: .top){
                        WebImage(url: URL(string: messageListData.lessonImage)).resizable().frame(width:60, height: 50).cornerRadius(5)
                        Text(messageListData.lessonName).bold()
                    }.padding(.horizontal, 16)
                    HStack{
                        WebImage(url: URL(string: messageListData.senderIconImage)).resizable().frame(width: 20, height:20).clipShape(Circle())
                        Text(messageListData.senderName).font(.caption).foregroundColor(.black)
                        Spacer()
                        Text(chatRoomType.messageListStyle.rawValue).foregroundColor(Color.customBlue).font(.system(size: 12)).padding(.horizontal, 10).padding(.vertical, 5).background(.gray.opacity(0.2)).background(RoundedRectangle(cornerRadius: 20).stroke(Color.customBlue, lineWidth: 2)).cornerRadius(20)
                    }.padding(.horizontal, 16)
                    HStack(spacing: .zero){
                        Image(systemName: "calendar").foregroundColor(.gray)
                        Text("2022/01/21").font(.caption).foregroundColor(.gray).padding(.trailing, 16)
                        Image(systemName: "dollarsign.circle.fill").foregroundColor(.gray)
                        Text("\(messageListData.lessonBudgets)???").font(.caption).foregroundColor(.gray)
                    }.padding(.horizontal, 16)
                }
            }
            Divider()
        }
    }
}
