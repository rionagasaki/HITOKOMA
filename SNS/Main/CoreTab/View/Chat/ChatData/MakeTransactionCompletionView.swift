//
//  MakeTransactionCompletionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/06.
//

import SwiftUI

struct MakeTransactionCompletionView: View {
    
    @State var lastMessage: String = ""
    @Binding var closeScreen: SelectableContentsType?
    let messageListData: MessageListData
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                LessonSummaryView(
                    lessonImageURLString: messageListData.lessonImage,
                    lessonName: messageListData.lessonName,
                    mentorIconImageURLString: messageListData.senderIconImage,
                    mentorName: messageListData.senderName
                )
                .padding(.horizontal, 16)
                Divider()
                Text("取引終了メッセージ")
                    .bold()
                    .padding(.leading, 20)
                TextEditor(text: $lastMessage)
                    .frame(width: UIScreen.main.bounds.width-40, height: 150)
                    .background(Rectangle().stroke(.black, lineWidth: 1))
                    .padding(.leading, 20)
            }
            Button {
                SetToFirestore()
                    .registerMessage(
                        path:"Chat",
                        chatRoomId: messageListData.chatRoomData?.chatroomId ?? "" ,
                        messageText: messageListData.lastMessage,
                        messageDate: messageListData.lastMessageDate,
                        messageType: .finish) {
                    closeScreen = nil
                }
            } label: {
                Text("取引完了を申請する")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width-40, height: 40)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
            }
            Button {
                closeScreen = nil
            } label: {
                HStack{
                    Image(systemName: "xmark.square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                    Text("閉じる")
                        .foregroundColor(.black)
                        .bold()
                        .padding(.trailing, 20)
                }
                .frame(width: UIScreen.main.bounds.width-40, height: 40)
                .background(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2))
                .background(.white.opacity(0.5))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            Spacer()
        }
    }
}
