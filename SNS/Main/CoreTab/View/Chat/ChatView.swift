//
//  ChatView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/17.
//
import SwiftUI
import ComposableArchitecture
import FirebaseAuth
import SDWebImageSwiftUI


enum SelectableContentsType:String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case camera
    case photo
    case folder
    case finish
}

enum MessageType: String {
    case text
    case image
    case finish
}

struct ChatView:View{
    
    let messageListData: MessageListData
    let chatRoomType: ChatRoomType
    @FocusState var isClosed:Bool
    @State var height:CGFloat = 15
    @State var messageText = ""
    @State var isTextEmpty: Bool = true
    @State var messages:[Chat] = []
    @State var showingImageModal: Bool = false
    @State var sendImage: UIImage?
    @State var selectableContentsType: SelectableContentsType? = nil
    @State var messageType: MessageType = .text
    @State var topMessageBar: CGFloat = -200
    @State private var fileUrl: URL?
    // textとImageがどちらも空であるか。
    var sendabled:Bool { !(isTextEmpty && sendImage == nil) }
    
    var body: some View{
        ZStack{
            Color.white
            VStack{
                if chatRoomType.messageListStyle == .beforePurchaseChat{
                    Text("購入前チャットです。\nトラブルのないよう、事前相談をしましょう。")
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .foregroundColor(.white)
                        .background(Color.customBlue)
                        .offset(y: topMessageBar)
                        .onAppear{
                            withAnimation(Animation.easeIn(duration: 0.6)){
                            topMessageBar = 0
                        }
                    }
                }
                Spacer()
                ScrollViewReader{ reader in
                    ScrollView {
                        VStack{
                            ForEach(messages) { message in
                                switch message.messageType {
                                case .text:
                                    BubbleView(chatData: message)
                                        .id(message.id)
                                case .image:
                                    ImageBubbleView(chatData: message)
                                case .finish:
                                    CompletionMessageView(
                                        messageListData: messageListData,
                                        chatRoomType: chatRoomType
                                    )
                                }
                            }
                        }.padding(.top,20)
                    }.onChange(of: messages) { message in
                        withAnimation {
                            reader
                                .scrollTo(message.last?.id)
                        }
                    }
                }
                Spacer()
                Divider()
                    .background(.white)
                    .padding(.bottom,5)
                // 完了した取引ではチャットできない。
                if chatRoomType.messageListStyle != .completion {
                    InputView()
                }
            }
            .navigationTitle(messageListData.senderName)
            .navigationBarTitleDisplayMode(.inline)
        }.gesture(TapGesture().onEnded({ _ in
            isClosed = false
        })).onAppear{
            self.messages = []
            SetToFirestore()
                .snapShotMessage(
                    path: chatRoomType.messageListStyle == .normalChat ? "Chat":"BeforePurchaseChat",
                    chatRoomId: messageListData.chatRoomData?.chatroomId ?? ""
                ) { chat in
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let message: Chat
                let sender = chat.senderUid == uid
                let messageType = MessageType(rawValue: chat.messageType)
                switch messageType {
                case .text:
                    message = Chat(
                        messageText: chat.messageText,
                        sender: sender,
                        messageDate: chat.messageDate,
                        messageType: .text
                    )
                    messages.append(message)
                case .image:
                    message = Chat(
                        massageImageURLString: chat.messageImageURLString,
                        sender: sender,
                        messageDate: chat.messageDate,
                        messageType: .image
                    )
                    messages.append(message)
                case .finish:
                    message = Chat(
                        messageText: chat.messageText,
                        sender: sender,
                        messageDate: chat.messageDate,
                        messageType: .finish
                    )
                    messages.append(message)
                case .none:
                    print("Error")
                }
            }
        }
    }
    func InputView() -> some View{
        VStack {
            MessageTypeSelectableView(
                messageType: $selectableContentsType,
                chatRoomType: chatRoomType
            )
            HStack(alignment: .bottom){
                ZStack(alignment:.topLeading){
                    GeometryReader { geometry in
                        TextEditor(text: $messageText)
                            .focused($isClosed)
                            .frame(width: 270, height:height > 70 ? 100: 30+height)
                            .padding(.horizontal,10)
                            .background(Color.white)
                            .cornerRadius(20)
                            .onChange(of: messageText) { text in
                            height = calculateTextHeight(geometry: geometry)
                            if text != ""{
                                messageType = .text
                                isTextEmpty = false
                            }else{
                                isTextEmpty = true
                            }
                        }
                    }
                    .frame(height:height > 70 ? 100: 30+height)
                    Image(systemName: isTextEmpty ? "textformat":"")
                        .resizable()
                        .frame(width: 18, height:13)
                        .foregroundColor(.gray)
                        .padding(.leading,15)
                        .padding(.top, 10)
                    
                    if sendImage != nil {
                        Image(uiImage: sendImage!)
                            .resizable()
                            .frame(width: 200, height:150)
                            .padding(.leading, 10)
                        Button {
                            sendImage = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height:20)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.leading, 13)
                        .padding(.top, 3)
                    }
                }
                VStack{
                    Button {
                        if isTextEmpty {
                            guard let sendImage = sendImage else { return }
                            RegisterStorage()
                                .refisterImageToStorage(
                                    folderName: "MessageImage",
                                    profileImage: sendImage
                                ) { messageImage in
                                let messageImageURLString = messageImage.absoluteString
                                SetToFirestore().registerMessage(path: chatRoomType.messageListStyle == .normalChat ? "Chat":"BeforePurchaseChat", chatRoomId: messageListData.chatRoomData?.chatroomId ?? "", messageImageURLString: messageImageURLString, messageDate: dateFormat(date: Date()), messageType: .image){
                                    self.sendImage = nil
                                }
                            }
                        } else {
                            SetToFirestore()
                                .registerMessage(
                                    path: chatRoomType.messageListStyle == .normalChat ? "Chat":"BeforePurchaseChat",
                                    chatRoomId: messageListData.chatRoomData?.chatroomId ?? "",
                                    messageText:messageText,
                                    messageDate: dateFormat(date: Date()),
                                    messageType: .text
                                ){
                                  messageText = ""
                            }
                        }
                    } label: {
                        Text("送信")
                            .foregroundColor(sendabled ? Color.white : Color.gray)
                            .padding(.vertical,8)
                            .padding(.horizontal,16)
                            .background(sendabled ? Color.customBlue: Color.init(uiColor: .lightGray).opacity(0.5))
                            .cornerRadius(10)
                    }
                    .padding(.trailing,8)
                    .disabled(!sendabled)
                }
            }
            .padding(.bottom,5)
            .fullScreenCover(item: $selectableContentsType) { type in
                switch type {
                case .photo:
                    ImagePicker(
                        sourceType: .photoLibrary,
                        selectedImage: $sendImage
                    )
                    .background(Color.black).ignoresSafeArea()
                case .folder:
                    DocumentPickerView(fileUrl: $fileUrl)
                case .finish:
                    MakeTransactionCompletionView(
                        closeScreen: $selectableContentsType,
                        messageListData: messageListData
                    )
                case .camera:
                    ImagePicker(
                        sourceType: .camera,
                        selectedImage: $sendImage
                    )
                }
            }
        }.ignoresSafeArea()
    }
    private func calculateTextHeight(geometry: GeometryProxy) -> CGFloat {
        let width =  geometry.size.width - 7
        return messageText.boundingRect(
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

struct MessageTypeSelectableView: View {
    @Binding var messageType: SelectableContentsType?
    let chatRoomType: ChatRoomType
    
    var body: some View {
        HStack{
            Button {
                self.messageType = .camera
            } label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25, height: 25)
            }.padding(.leading, 20)
            Button {
                messageType = .photo
            } label: {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25, height: 25)
            }
            .padding(.leading, 16)
            Button {
                messageType = .folder
            } label: {
                Image(systemName: "folder.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25, height: 25)
            }.padding(.leading, 16)
            
            if chatRoomType.messageListStyle == .normalChat && chatRoomType.chatMode == .mentor  {
                Button {
                     messageType = .finish
                } label: {
                    Text("取引終了")
                        .foregroundColor(.white)
                        .padding(.vertical,8)
                        .padding(.horizontal,16)
                        .background(Color.black)
                        .cornerRadius(10)
                }.padding(.leading, 16)

            }
            Spacer()
        }
    }
}

enum ChatType {
    case beforePurchase
    case afterPurchase
    case completion
}
