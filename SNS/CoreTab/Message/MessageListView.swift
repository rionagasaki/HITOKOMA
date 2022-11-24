//
//  MessageListView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/08.
//

import SwiftUI
import SDWebImageSwiftUI

enum MentorOrStudent: String, CaseIterable{
    case mentor = "メンターへのチャット"
    case student = "生徒へのチャット"
}

struct MessageListView: View {
    @State var searchWord: String = ""
    @State var selectPicker: MentorOrStudent = .mentor
    let mentorMessages: [MessageListData]
    let studentsMessages: [MessageListData]
    
    var body: some View {
        ScrollView{
            VStack(spacing: .zero){
                Picker("",selection: $selectPicker) {
                    ForEach(MentorOrStudent.allCases, id:\.self) {
                        mentor in
                        Text(mentor.rawValue).tag(mentor)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16).padding(.vertical,7)
                
                ForEach(self.selectPicker == .mentor ? self.mentorMessages: studentsMessages){ chatRoom in
                    NavigationLink {
                        ChatView(chatUserName: "", chatUserUid: "", chatData: nil, chatStyle: .afterPurchase)
                    } label: {
                        OneMessageListView(message: chatRoom)
                    }
                }.listStyle(.plain).padding(.horizontal,16).padding(.top,16)
                Spacer()
            }
        }.searchable(text: $searchWord).navigationTitle("メッセージ")
    }
}

struct OneMessageListView: View {
    let message: MessageListData
    
    var body: some View{
        HStack{
            WebImage(url: URL(string: message.senderIconImage)).resizable().frame(width:60, height: 60).clipShape(Circle())
            VStack(alignment: .leading){
                HStack{
                    Text(message.senderName).foregroundColor(.black).bold()
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
}


struct MessageListData: Identifiable{
    let id = UUID()
    let senderIconImage: String
    let senderName: String
    let lastMessage: String
    let lastMessageDate: String
}

