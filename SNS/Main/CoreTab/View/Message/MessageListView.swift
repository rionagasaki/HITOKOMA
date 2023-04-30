//
//  MessageListView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/08.
//

import SwiftUI
import SDWebImageSwiftUI
import PKHUD

struct MessageListView: View {
    
    @StateObject var chatRoomType = ChatRoomType(chatMode: .student, messageListStyle: .beforePurchaseChat)
    @StateObject var viewModel = MessageListViewModel()
    
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
                    ForEach(viewModel.messageCategory.indices, id: \.self) { index in
                        Button {
                            withAnimation {
                                viewModel.selection = index
                            }
                        } label: {
                            Text(viewModel.messageCategory[index])
                                .fontWeight(index == viewModel.selection ? .semibold: .regular)
                                .pageLabel().font(.subheadline)
                                .foregroundColor(index == viewModel.selection ? .primary: .gray)
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.top, 10)
                TabBarSliderView(width: UIScreen.main.bounds.width/3, alignment: selectionBarAlignment(selection: viewModel.selection))
            }
            .background(.ultraThinMaterial)
            
            SwitchingServiceView(chatRoomType: chatRoomType)
        
            ZStack(alignment: .bottomTrailing){
                TabView(selection: $viewModel.selection){
                    MessageListScrollView(
                        chatRoomType: chatRoomType,
                        messageListDatas: chatRoomType.chatMode == .mentor ? viewModel.prePurchaseMentorMessages: viewModel.prePurchaseStudentsMessages
                    )
                    .tag(0)
                    MessageListScrollView(
                        chatRoomType: chatRoomType ,
                        messageListDatas: chatRoomType.chatMode == .mentor ? viewModel.mentorMessages: viewModel.studentsMessages
                    ).tag(1)
                    MessageListScrollView(chatRoomType: chatRoomType ,messageListDatas: chatRoomType.chatMode == .mentor ? viewModel.completionLessonAsStudentMessages: viewModel.completionLessonAsMentorMessages).tag(2)
                }
                .onChange(of: viewModel.selection, perform: { selection in
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
            }
        }.navigationTitle(chatRoomType.chatMode == .mentor ? "出品者メッセージ":"購入者メッセージ").navigationBarTitleDisplayMode(.inline)
    }
}


struct SwitchingServiceView: View {
    @StateObject var chatRoomType: ChatRoomType
    var body: some View {
        VStack {
            HStack {
                Button {
                    chatRoomType.chatMode = .mentor
                } label: {
                    HStack {
                        Circle()
                            .fill()
                            .frame(width: 16)
                            .foregroundColor(chatRoomType.chatMode == .mentor ? .customBlue: .customLightGray)
                        Text("サービス")
                            .fontWeight(chatRoomType.chatMode == .mentor ? .medium : .light)
                            .font(.system(size: 17))
                            .foregroundColor(chatRoomType.chatMode == .mentor ? .black.opacity(0.8): .gray)
                    }
                    .padding(.leading, 40)
                }
                Spacer()
                Button {
                    chatRoomType.chatMode = .student
                } label: {
                    HStack {
                        Circle()
                            .fill()
                            .frame(width: 16)
                            .foregroundColor(chatRoomType.chatMode == .student ? .customBlue: .customLightGray)
                        Text("リクエスト")
                            .fontWeight(chatRoomType.chatMode == .student ? .medium : .light)
                            .font(.system(size: 17))
                            .foregroundColor(chatRoomType.chatMode == .student ? .black.opacity(0.8): .gray)
                    }
                    .padding(.trailing, 40)
                }
            }
            CustomDivider()
        }
    }
}

struct SwitchingServiceView_previews: PreviewProvider {
    static var previews: some View {
        SwitchingServiceView(chatRoomType: .init(chatMode: .mentor, messageListStyle: .normalChat))
    }
}
