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
    @State var preChatRoomData: ChatRoomData?
    @State var chatroomData:ChatRoomData?
    @State var selection: Int = 0
    let messageCategory = ["事前チャット", "やり取り中","完了した取引"]
    let mentorMessages: [MessageListData]
    let studentsMessages: [MessageListData]
    
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
            
            TabView(selection: $selection){
                MessageListScrollView(chatRoomData: $chatroomData, messageListDatas: selectPicker == .mentor ? mentorMessages: studentsMessages, messageListStyle: .beforePurchaseChat).tag(0)
                MessageListScrollView(chatRoomData: $chatroomData, messageListDatas: selectPicker == .mentor ? mentorMessages: studentsMessages, messageListStyle: .normalChat).tag(1)
                MessageListScrollView(chatRoomData: $chatroomData, messageListDatas: selectPicker == .mentor ? mentorMessages: studentsMessages, messageListStyle: .completion).tag(2)
            }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        }.navigationTitle(selectPicker == .mentor ? "購入者":"出品者").navigationBarTitleDisplayMode(.inline).toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    switch selectPicker {
                    case .mentor:
                        self.selectPicker = .student
                    case .student:
                        self.selectPicker = .mentor
                    }
                } label: {
                    VStack(spacing: .zero){
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill").resizable().frame(width:24, height: 24).scaledToFit()
                        Text(selectPicker == .mentor ? "購入者":"出品者").font(.caption).font(.system(size: 3))
                    }
                }
            }
        }
    }
}

