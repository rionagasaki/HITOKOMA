//
//  CompletionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct OneMessageListView: View {
    let messageListStyle: MessageListStyle
    let lastMessage: String
    let talkUserUid: String
    let talkUserName: String
    let talkUserIconImageURLString: String
    let lessonId: String
    let lessonName: String
    let lessonContents: String
    let lessonBudgets: Int
    let lessonImageURLString: String
    @Binding var chatRoomData: ChatRoomData?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Divider()
                HStack(alignment: .top){
                    WebImage(url: URL(string: lessonImageURLString)).resizable().frame(width:60, height: 50).cornerRadius(5)
                    Text(lessonName).bold()
                }.padding(.horizontal, 16)
                HStack{
                    WebImage(url: URL(string: talkUserIconImageURLString)).resizable().frame(width: 20, height:20).clipShape(Circle())
                    Text(talkUserName).font(.caption).foregroundColor(.gray)
                    Spacer()
                    Text(messageListStyle.rawValue).foregroundColor(.gray).padding(.horizontal, 10).padding(.vertical, 5).background(.gray.opacity(0.2)).cornerRadius(20)
                }.padding(.horizontal, 16)
                HStack(spacing: .zero){
                    Image(systemName: "calendar").foregroundColor(.gray)
                    Text("2022/01/21").font(.caption).foregroundColor(.gray).padding(.trailing, 16)
                    Image(systemName: "dollarsign.circle.fill").foregroundColor(.gray)
                    Text("\(lessonBudgets)円").font(.caption).foregroundColor(.gray)
                }.padding(.horizontal, 16)
            }
            VStack{
                NavigationLink {
                    if messageListStyle == .completion {
                        OneClassDetailView(lessonImageURLString: lessonImageURLString, mentorIconImageURLString: talkUserIconImageURLString, lessonId: lessonId, mentorName: talkUserName, mentorUid: talkUserUid, lessonTitle: lessonName, lessonContent: lessonContents, budgets: lessonBudgets)
                    } else {
                        ChatView(chatUserName: talkUserName, chatUserUid: talkUserUid, mentorIconImageURLString: talkUserIconImageURLString, lessonImageURLString: lessonImageURLString, lessonTitle: lessonName, chatData: chatRoomData, messageListStyle: messageListStyle)
                    }
                } label: {
                    Text(messageListStyle == .completion ? "もう一度購入する": "やり取りをする").bold().frame(width: UIScreen.main.bounds.width-30, height:40 ).foregroundColor(.white).background(Color.customBlue).cornerRadius(30)
                }
            }
            Divider()
        }.onAppear{
            switch messageListStyle {
            case .beforePurchaseChat:
                FetchFromFirestore().fetchChatRoomInfoFromFirestore(path: "BeforePurchaseChat", lessonId: lessonId, mentorUid: talkUserUid) { preChatRoom in
                    self.chatRoomData = preChatRoom
                }
            case .normalChat:
                FetchFromFirestore().fetchChatRoomInfoFromFirestore(path: "Chat", lessonId: lessonId, mentorUid: talkUserUid) { chatRoom in
                    self.chatRoomData = chatRoom
                }
            case .completion:
                print("aaaa")
            }
        }
    }
}
