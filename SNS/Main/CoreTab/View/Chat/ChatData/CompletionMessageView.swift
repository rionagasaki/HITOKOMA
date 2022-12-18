//
//  CompletionMessageView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/06.
//

import SwiftUI
import SDWebImageSwiftUI

struct CompletionMessageView: View {
    let messageListData: MessageListData
    let chatRoomType: ChatRoomType
    var body: some View {
        VStack {
            HStack(spacing: 5){
                Image(systemName: "checkmark.circle.fill").resizable().frame(width:20, height: 20).foregroundColor(.green)
                Text("評価をしてください").bold().padding(.trailing, 25)
            }
            Text("出品者が取引完了を申請しました。\n評価をして取引を完了させてください。").font(.caption)
            Divider()
            HStack(alignment: .top){
                WebImage(url: URL(string: messageListData.lessonImage)).resizable().frame(width:30, height: 30).clipShape(Circle()).padding(.leading, 10)
                Text(messageListData.lessonName).fontWeight(.light).font(.system(size: 13)).padding(.trailing, 10)
                Spacer()
            }
            Divider()
            if chatRoomType.chatMode == .student {
                NavigationLink {
                    TransactionFinishView(messageListData: messageListData)
                } label: {
                    Text("評価をする").fontWeight(.regular).font(.system(size: 13)).foregroundColor(.customBlue)
                }
            }
        }.frame(width: 300).padding().background(.ultraThinMaterial).cornerRadius(10)
    }
}
