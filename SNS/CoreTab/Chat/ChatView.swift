//
//  ChatView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/17.
//
import SwiftUI
import ComposableArchitecture
import FirebaseAuth

struct ChatView:View{
    
    let chatUserName: String
    let chatUserUid: String
    let chatData: ChatRoomData?
    let chatStyle: ChatType
    
    @FocusState var isClosed:Bool
    @State var height:CGFloat = 15
    @State var text = ""
    @State var isTextEmpty: Bool = true
    @State var messages:[Chat] = []
    @State var showingImageModal: Bool = false
    @State var sendImage: UIImage?
    var body: some View{
        ZStack{
            Color.white
            VStack{
                if chatStyle == .beforePurchase{
                    Text("購入前チャットです。\nトラブルのないよう、事前相談をしましょう。").frame(width: UIScreen.main.bounds.width, height: 50).foregroundColor(.white).background(.blue.opacity(0.8))
                }
                Spacer()
                ScrollViewReader{ reader in
                    ScrollView {
                        VStack{
                            ForEach(messages) { message in
                                BubbleView(chatData: message).id(message.id)
                            }
                        }.padding(.top,20)
                    }.onChange(of: messages) { message in
                        withAnimation {
                            reader.scrollTo(message.last?.id)
                        }
                    }
                }
                Spacer()
                Divider().background(.white).padding(.bottom,5)
                InputView()
            }.navigationTitle(chatUserName)
                .navigationBarTitleDisplayMode(.inline)
        }.gesture(TapGesture().onEnded({ _ in
            self.isClosed = false
        })).onAppear{
            SetToFirestore().snapShotMessage(path: chatStyle == .afterPurchase ? "Chat":"BeforePurchaseChat",chatRoomId: chatData!.chatroomId) { chat in
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let message = Chat(messageText: chat.messageText, sender: chat.senderUId == uid, messageDate: chat.messageDate)
                messages.append(message)
                self.text = ""
            }
        }
    }
    func InputView() -> some View{
        ZStack {
            HStack(alignment: .bottom){
                ZStack(alignment:.leading){
                    GeometryReader { geometry in
                        TextEditor(text: $text).focused($isClosed).frame(width: 270, height:height > 70 ? 100: 30+height).padding(.horizontal,10).background(Color.white).cornerRadius(20).onChange(of: text) { text in
                            height = calculateTextHeight(geometry: geometry)
                            if text != ""{
                                self.isTextEmpty = false
                            }else{
                                self.isTextEmpty = true
                            }
                        }
                    }.frame(height:height > 70 ? 100: 30+height)
                    Image(systemName: isTextEmpty ? "textformat":"").resizable().frame(width: 18, height:13).foregroundColor(.gray).padding(.leading,15)
                    if sendImage != nil {
                        Image(uiImage: sendImage!).resizable().frame(width: UIScreen.main.bounds.width-100, height:200).padding(.leading, 10)
                    }
                }
                VStack{
                    Button {
                        self.showingImageModal = true
                    } label: {
                        Image(systemName: "photo.artframe")
                    }
                    
                    Button {
                        self.text = self.text.trimmingCharacters(in: .whitespaces)
                        if !isTextEmpty{
                            SetToFirestore().registerMessage(path: chatStyle == .afterPurchase ? "Chat":"BeforePurchaseChat", chatRoomId: chatData!.chatroomId, messageText:self.text, messageDate: dateFormat(date: Date()))
                        }
                    } label: {
                        if isTextEmpty && (sendImage == nil){
                            Text("送信").foregroundColor(.gray).padding(.vertical,8).padding(.horizontal,16).background(Color.init(uiColor: .lightGray).opacity(0.5)).cornerRadius(10)
                        }else{
                            Text("送信").foregroundColor(.white).padding(.vertical,8).padding(.horizontal,16).background(Color.init(uiColor: .systemBlue).opacity(0.5)).cornerRadius(10)
                        }
                    }.padding(.trailing,8)
                }
            }.padding(.bottom,5).sheet(isPresented: $showingImageModal) {
                ImagePicker(sourceType: .photoLibrary,selectedImage: $sendImage)
            }
        }.ignoresSafeArea()
    }
    private func calculateTextHeight(geometry: GeometryProxy) -> CGFloat {
        let width =  geometry.size.width - 7
        return text.boundingRect(
            with: CGSize(
                width: width,
                height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 13)],
            context: nil
        ).height
    }
    
    func dateFormat(date:Date)->String{
        let dateformetter = DateFormatter()
        dateformetter.locale = Locale(identifier: "ja_JP")
        dateformetter.dateStyle = .medium
        dateformetter.dateFormat = "hh:mm"
        return dateformetter.string(from: date)
    }
}

enum ChatType {
    case afterPurchase
    case beforePurchase
}

struct ChatView_Preview:PreviewProvider{
    static var previews: some View{
        ChatView(chatUserName: "", chatUserUid: "", chatData: nil, chatStyle: .afterPurchase, height: 0)
    }
}
