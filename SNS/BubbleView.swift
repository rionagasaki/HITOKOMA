//
//  BubbleView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/12.
//

import SwiftUI

struct BubbleView: View {
    var message:Message
    var body: some View {
        
        HStack(alignment: .bottom){
            if message.sender == true{
                Spacer()
                Text(dateFormat(date:message.messageDate)).foregroundColor(Color.init(uiColor: .lightGray)).font(.footnote).padding(.leading,60)
                Text(message.messageText).padding(.all,10).background(Color.init(uiColor: .systemGreen)).cornerRadius(18).padding(.trailing,20)
            }else{
                
                Image(message.iconImage).resizable().frame(width: 40, height: 40).scaledToFit().mask {
                    Circle()
                }.padding(.leading,20)
                Text(message.messageText).padding(.all,10).background(.white).cornerRadius(18).padding(.trailing,2)
                Text(dateFormat(date:message.messageDate)).foregroundColor(Color.init(uiColor: .lightGray)).font(.footnote).padding(.trailing,60)
                Spacer()
            }
        }
    }
    
    func dateFormat(date:Date)->String{
        let dateformetter = DateFormatter()
        dateformetter.locale = Locale(identifier: "ja_JP")
        dateformetter.dateStyle = .medium
        dateformetter.dateFormat = "hh:mm"
        return dateformetter.string(from: date)
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(message:Message(messageText: "Hello!", sender: false, messageDate: Date(), iconImage: "home"))
    }
}


struct Message:Identifiable{
    var id = UUID()
    var messageText:String
    var sender:Bool
    var messageDate:Date
    var iconImage:String
}

struct ChatRoom: Identifiable{
    var id = UUID()
    var myID:String
    var partnerID:String
    var messages:[Message]
}
