//
//  ChatView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/17.
//

import SwiftUI
struct ChatView:View{
    @State var height:CGFloat = 40
    @State var text:String
    @State var messages:[Message] = []
    @State var sender:Bool = false
    @State var id:String = ""
    @FocusState var isClosed:Bool
    var body: some View{
        NavigationView{
            ZStack{
                Color.init(uiColor: UIColor(displayP3Red: 40/255, green: 42/255, blue: 51/255, alpha: 1)).ignoresSafeArea(edges: .bottom)
                VStack{
                    Spacer()
                    ScrollView {
                        VStack{
                            ForEach(messages) { message in
                                BubbleView(message: Message(messageText: message.messageText, sender: message.sender, messageDate: Date(), iconImage: "home")).id(message.id).onAppear {
                                    self.id = message.id.uuidString
                                }
                            }
                        }
                    }
                    Spacer()
                    Divider().background(.white).padding(.bottom,5)
                    InputView(text: $text, sender: $sender, messages: $messages).focused($isClosed)
                }.navigationTitle("AAAさん")
                    .navigationBarTitleDisplayMode(.inline)
            }.gesture(TapGesture().onEnded({ _ in
                self.isClosed = false
            }))
        }.onAppear {
            let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithDefaultBackground()
            
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}

struct ChatView_Preview:PreviewProvider{
    static var previews: some View{
        ChatView(text: "")
    }
}

struct InputView:View {
    @Binding var text:String
    @Binding var sender:Bool
    @Binding var messages:[Message]
    
    var body: some View{
        HStack{
            ZStack(alignment:.leading){
                TextEditor(text: $text).frame(width: 270, height: 40).padding(.horizontal,10).background(Color.white).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke()).onSubmit {
                }
                Text("Aa").foregroundColor(.gray).padding(.leading,15)
            }
            Button {
                sender.toggle()
                let message = Message(messageText: text, sender: sender, messageDate: Date(), iconImage: "home")
                messages.append(message)
            } label: {
                Image(systemName: "paperplane").foregroundColor(.white)
            }
            
        }.padding(.bottom,10)
    }
}
