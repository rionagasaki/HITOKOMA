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
            
            ZStack(alignment: .bottomTrailing){
                TabView(selection: $viewModel.selection){
                    MessageListScrollView(chatRoomType: chatRoomType, messageListDatas: chatRoomType.chatMode == .mentor ? viewModel.prePurchaseMentorMessages: viewModel.prePurchaseStudentsMessages).tag(0)
                    MessageListScrollView(chatRoomType: chatRoomType ,messageListDatas: chatRoomType.chatMode == .mentor ? viewModel.mentorMessages: viewModel.studentsMessages).tag(1)
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
                Button {
                    HUD.flash(.label("🔄\(chatRoomType.chatMode == .mentor ? "購入者":"出品者")モードに切り替えました。"), delay: 1.0)
                    switch chatRoomType.chatMode {
                    case .mentor:
                        self.chatRoomType.chatMode = .student
                    case .student:
                        self.chatRoomType.chatMode = .mentor
                    }
                } label: {
                    VStack(spacing: .zero){
                        Text(chatRoomType.chatMode == .mentor ? "出品者":"購入者")
                            .fontWeight(.regular)
                            .font(.system(size: 17))
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .resizable()
                            .frame(width:55, height: 55)
                            .scaledToFit().background(Color.white)
                    }
                }
                .padding(.bottom, 32)
                .padding(.trailing, 32)
            }
        }.navigationTitle(chatRoomType.chatMode == .mentor ? "出品者メッセージ":"購入者メッセージ").navigationBarTitleDisplayMode(.inline)
    }
}

