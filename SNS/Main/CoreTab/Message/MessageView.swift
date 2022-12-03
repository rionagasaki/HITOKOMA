//
//  MessageView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/22.
//

import SwiftUI
import ComposableArchitecture

struct MessageView: View {
    public let store: Store<MessageState, MessageAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack{
                Color.black.opacity(0.03).background(.ultraThinMaterial)
                VStack(alignment:.leading ,spacing: 20){
                    Circle().size(width: 200, height: 200).blur(radius: 80).foregroundColor(.yellow)
                    HStack{
                        Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.blue).padding(.top,-120)
                        Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.orange).padding(.top,30)
                    }
                    Circle().size(width: 200, height: 200).blur(radius: 100).foregroundColor(.pink)
                }
                if viewStore.state.loadAllMessages == []{
                    VStack{
                        VStack{
                            Image("coffee").resizable().frame(width: 200, height: 200)
                            Text("まだやり取りがないよ。\n新しいひとこまを見つけに行こう！").bold().padding()
                            Button {
                                print("こちらから")
                            } label: {
                                Text("こちらから").underline()
                            }.padding(.top,16)
                            Spacer()
                        }.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30)).overlay(RoundedRectangle(cornerRadius: 30).stroke(.black,lineWidth: 0.1)).frame( height: 350)
                    }.padding(.top,30)
                }else{
                    
                }
            }.navigationBarTitleDisplayMode(.inline).onAppear {
                viewStore.send(.fetchAllMessages)
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageState.initial
    }
}
