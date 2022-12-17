//
//  MessageListView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/08.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageListView: View {
    
    @StateObject var chatRoomType = ChatRoomType(chatMode: .student, messageListStyle: .beforePurchaseChat)
    @State var searchWord: String = ""
    @State var selection: Int = 0
    let messageCategory = ["事前チャット", "やり取り中","完了した取引"]
    
    // ContentViewから渡ってくる。
    
    let mentorMessages: [MessageListData]
    let studentsMessages: [MessageListData]
    let prePurchaseMentorMessages: [MessageListData]
    let prePurchaseStudentsMessages: [MessageListData]
    let completionLessonAsMentorMessages: [MessageListData]
    let completionLessonAsStudentMessages: [MessageListData]
    
    
    private func selectionBarAlignment(selection: Int) -> Alignment {
        if selection == 0 {
            return .topLeading
        } else if selection == 1 {
            return .top
        } else {
            return .topTrailing
        }
    }
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    ForEach(messageCategory.indices, id: \.self) { index in
                        Button {
                            withAnimation {
                                selection = index
                            }
                        } label: {
                            Text(messageCategory[index]).fontWeight(index == selection ? .semibold: .regular).pageLabel().font(.subheadline)
                                .foregroundColor(index == selection ? .primary: .gray).padding(.bottom, 7)
                        }
                    }
                }.padding(.top, 10)
                
                TabBarSliderView(width: UIScreen.main.bounds.width/3, alignment: selectionBarAlignment(selection: selection))
            }.background(.ultraThinMaterial)
            
            ZStack(alignment: .bottomTrailing){
                TabView(selection: $selection){
                    MessageListScrollView(chatRoomType: chatRoomType, messageListDatas: chatRoomType.chatMode == .mentor ? prePurchaseMentorMessages: prePurchaseStudentsMessages).tag(0)
                    MessageListScrollView(chatRoomType: chatRoomType ,messageListDatas: chatRoomType.chatMode == .mentor ? mentorMessages: studentsMessages).tag(1)
                    MessageListScrollView(chatRoomType: chatRoomType ,messageListDatas: chatRoomType.chatMode == .mentor ? completionLessonAsStudentMessages: completionLessonAsMentorMessages).tag(2)
                }.onChange(of: selection, perform: { selection in
                    print(selection)
                    if selection == 0 {
                        chatRoomType.messageListStyle = .beforePurchaseChat
                    } else if selection == 1 {
                        chatRoomType.messageListStyle = .normalChat
                    } else if selection == 2 {
                        chatRoomType.messageListStyle = .completion
                    }
                }).tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                Button {
                    switch chatRoomType.chatMode {
                    case .mentor:
                        self.chatRoomType.chatMode = .student
                    case .student:
                        self.chatRoomType.chatMode = .mentor
                    }
                } label: {
                    VStack(spacing: .zero){
                        Text(chatRoomType.chatMode == .mentor ? "出品者":"購入者").fontWeight(.regular).font(.system(size: 17))
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill").resizable().frame(width:55, height: 55).scaledToFit().background(Color.white)
                    }
                }.padding(.bottom, 30).padding(.trailing, 30)
            }
        }.navigationTitle(chatRoomType.chatMode == .mentor ? "出品者メッセージ":"購入者メッセージ").navigationBarTitleDisplayMode(.inline)
    }
}

