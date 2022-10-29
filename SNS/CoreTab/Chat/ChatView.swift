//
//  ChatView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/17.
//
import SwiftUI
import ComposableArchitecture

struct ChatView:View{
    @State var height:CGFloat = 40
    @FocusState var isClosed:Bool
    let store: Store<ChatState, ChatAction>
    var body: some View{
        WithViewStore(self.store) { viewStore in
            
            ZStack{
                ZStack{
                    Color.init(uiColor:UIColor(displayP3Red: 40/255, green: 42/255, blue: 51/255, alpha: 1)).opacity(0.1).background(.ultraThinMaterial)
                }.ignoresSafeArea()
                VStack{
                    Spacer()
                    ScrollView {
                        VStack{
                            ForEach(viewStore.state.allMessages) { message in
                                BubbleView(message: message)
                            }
                        }.padding(.top,20)
                    }
                    Spacer()
                    Divider().background(.white).padding(.bottom,5)
                    //                        InputView(text: viewStore.binding(get: <#T##(ChatState) -> Value#>, send: <#T##(Value) -> ChatAction#>), messages: <#T##Binding<[Chat]>#>)
                }.navigationTitle("AAAさん")
                    .navigationBarTitleDisplayMode(.inline)
            }.gesture(TapGesture().onEnded({ _ in
                self.isClosed = false
            }))
        }
    }
    
    //    func InputView(viewStore:ViewStore<ChatState,ChatAction>) -> some View{
    //        HStack{
    //            ZStack(alignment:.leading){
    //                TextEditor(text: $text).frame(width: 270, height: 40).padding(.horizontal,10).background(Color.white).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke()).onSubmit {
    //                }
    //                Text("Aa").foregroundColor(.gray).padding(.leading,15)
    //            }
    //
    //            Button {
    //                let message = Chat(messageText: text, sender:true, messageDate: Date(), iconImage: "home")
    //                messages.append(message)
    //            } label: {
    //                Text("送信").foregroundColor(.gray).padding(.vertical,8).padding(.horizontal,16).background(Color.init(uiColor: .lightGray).opacity(0.5)).cornerRadius(10)
    //            }
    //        }.padding(.bottom,10)
    //    }
}

struct ChatView_Preview:PreviewProvider{
    static var previews: some View{
        ChatState.initial
    }
}

//struct InputView:View {
//    @Binding var text:String
//    @Binding var messages:[Chat]
//    var body: some View{
//
//    }
//}
