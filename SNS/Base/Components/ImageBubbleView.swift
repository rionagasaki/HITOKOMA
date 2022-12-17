//
//  ImageBubbleView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/04.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageBubbleView: View {
    let chatData: Chat
    @State var showFullImage: Bool = false
    var body: some View {
        HStack{
            if chatData.sender {
                Spacer()
                Button {
                    self.showFullImage = true
                } label: {
                    WebImage(url: URL(string: chatData.massageImageURLString ?? "")).resizable()
                        .placeholder(Image(systemName: "photo"))
                        .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit().frame(height: 200)
                        .background(Color.black).cornerRadius(10)
                        .padding(.trailing, 16)
                }.sheet(isPresented: self.$showFullImage) {
                    FullImageView(messageImageURLString: chatData.massageImageURLString ?? "")
                }
            } else {
                
            }
        }
    }
}

