//
//  ImageBubbleView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/04.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageBubbleView: View {
    let message: Chat
    @State var showFullImage: Bool = false
    var body: some View {
        HStack{
            Spacer()
            Button {
                self.showFullImage = true
            } label: {
                WebImage(url: URL(string: message.massageImageURLString ?? "")).resizable().scaledToFit().frame(width: 250, height: 250).cornerRadius(10).padding(.trailing, 16)
            }.sheet(isPresented: self.$showFullImage) {
                FullImageView(messageImageURLString: message.massageImageURLString ?? "")
            }
        }
    }
}

