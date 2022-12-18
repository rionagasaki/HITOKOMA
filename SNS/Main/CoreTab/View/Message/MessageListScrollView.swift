//
//  MessageCompletionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/02.
//

import SwiftUI

struct MessageListScrollView: View {
    @ObservedObject var chatRoomType: ChatRoomType
    let messageListDatas:[MessageListData]
    var body: some View {
        ScrollView{
            VStack(spacing: .zero){
                if messageListDatas.count == 0 {
                    Image(systemName: "bubble.left.and.exclamationmark.bubble.right").resizable().scaledToFit().frame(width: 70, height: 70).foregroundColor(.init(uiColor: .lightGray)).padding(.top, 150)
                    Text("完了したレッスンは\nまだありません。").fontWeight(.heavy).multilineTextAlignment(.center).font(.system(size: 15))
                    Text("レッスンを探す・リクエストをする").foregroundColor(.white).bold().frame(width: UIScreen.main.bounds.width-100, height: 40).background(Color.customBlue).cornerRadius(10).padding(.top, 10)
                } else {
                    ForEach(messageListDatas) { messageList in
                        OneMessageListView(chatRoomType: chatRoomType, messageListData: messageList)
                    }
                }
            }
        }
    }
}

