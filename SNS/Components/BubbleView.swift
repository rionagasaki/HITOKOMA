//
//  BubbleView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/12.
//

import SwiftUI

struct BubbleView: View {
    var chatData:Chat
    var body: some View {
        HStack(alignment: .bottom){
            if chatData.sender {
                HStack{
                    Spacer()
                    Text(chatData.messageDate).foregroundColor(Color.init(uiColor: .lightGray)).font(.footnote)
                    Text(chatData.messageText).padding(.all,12).background(Color.init(uiColor: .systemBlue).opacity(0.5)).cornerRadius(15).textSelection(.enabled)
                }.padding(.trailing,20)
            }else{
//                Image(message.iconImage).resizable().frame(width: 40, height: 40).scaledToFit().mask {
//                    Circle()
//                }.padding(.leading,20)
                HStack{
                    Text(chatData.messageText).padding(.all,12).background(Color.init(uiColor: .white)).background(.ultraThinMaterial).cornerRadius(15).textSelection(.enabled)
                    Text(chatData.messageDate).foregroundColor(Color.init(uiColor: .lightGray)).font(.system(size: 10)).padding(.bottom,3)
                    Spacer()
                }.padding(.leading,20)
            }
        }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(chatData: Chat(messageText: "aaaaaaaaaaacaaaaaaaaaaaa", sender: true, messageDate: "10:04"))
    }
}
