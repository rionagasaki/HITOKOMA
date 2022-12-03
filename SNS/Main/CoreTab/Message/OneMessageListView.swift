//
//  CompletionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/02.
//

import SwiftUI
import SDWebImageSwiftUI


enum MessageListStyle: String {
    case beforePurchaseChat = "事前メッセージ"
    case normalChat = "やり取り中"
    case completion = "完了"
}

struct OneMessageListView: View {
    let messageListStyle: MessageListStyle
    let talkUserIconImageURLString: String
    let talkUserName: String
    let lastMessage: String
    let lessonImageURLString: String
    let lessonName: String
    let chatRoomData: ChatRoomData?
    
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
                    Text("2000円").font(.caption).foregroundColor(.gray)
                }.padding(.horizontal, 16)
            }
            VStack{
                NavigationLink {
                    ChatView(chatUserName: talkUserName , chatUserUid: "", chatData: chatRoomData, chatStyle: messageListStyle == .beforePurchaseChat ? .beforePurchase: .afterPurchase)
                } label: {
                    Text(messageListStyle == .completion ? "もう一度購入する": "やり取りをする").bold().frame(width: UIScreen.main.bounds.width-30, height:40 ).foregroundColor(.white).background(Color.customBlue).cornerRadius(30)
                }
            }
            Divider()
        }
    }
}
