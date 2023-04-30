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
    @State private var isPresentingFullImageView: Bool = false
    var body: some View {
        HStack{
            if chatData.sender {
                Spacer()
                Button {
                    self.isPresentingFullImageView = true
                } label: {
                    WebImage(url: URL(string: chatData.massageImageURLString.orEmpty)).resizable()
                        .placeholder(Image(systemName: "photo"))
                        .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit().frame(height: 200)
                        .background(Color.black).cornerRadius(10)
                        .padding(.trailing, 16)
                }.sheet(isPresented: self.$isPresentingFullImageView) {
                    FullImageView(messageImageURLString: chatData.massageImageURLString.orEmpty)
                }
            } else {
                
            }
        }
    }
}

