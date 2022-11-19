//
//  MessageListView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/08.
//

import SwiftUI

struct MessageListView: View {
    @State var searchWord: String = ""
    let messages: [MessageListData] = [MessageListData(senderIconImage: "rootImage", senderName: "Rio", lastMessage: "こんにちは", lastMessageDate: "12月2日"), MessageListData(senderIconImage: "rootImage", senderName: "Rio", lastMessage: "こんにちは", lastMessageDate: "12月2日")]
    var body: some View {
        List(messages){ message in
            NavigationLink {
                ChatView(chatUserName: "", chatUserUid: "", chatData: nil)
            } label: {
                HStack{
                    Image(message.senderIconImage).resizable().frame(width:60, height: 60).clipShape(Circle())
                    VStack(alignment: .leading){
                        HStack{
                            Text(message.senderName).bold()
                            Spacer()
                            Text(message.lastMessageDate).foregroundColor(.init(uiColor: .lightGray)).font(.system(size: 12)).padding(.bottom,4)
                        }.padding(.top, 3)
                        HStack{
                            Text(message.lastMessage)
                            Spacer()
                            Text("3").font(.system(size: 14)).padding(.horizontal, 6).foregroundColor(.white).background(.red).cornerRadius(10)
                        }
                    }
                }
            }

        }.listStyle(.plain).onAppear{
        }.searchable(text: $searchWord)
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView()
    }
}

struct MessageListData: Identifiable {
    let id = UUID()
    var senderIconImage: String
    var senderName: String
    var lastMessage: String
    var lastMessageDate: String
}

