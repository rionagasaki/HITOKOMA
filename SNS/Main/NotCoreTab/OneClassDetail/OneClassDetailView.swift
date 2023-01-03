//
//  OneClassDetailView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct OneClassDetailView: View {
    @EnvironmentObject var user:User
    @ObservedObject private var chatRoomType = ChatRoomType(chatMode: .student, messageListStyle: .normalChat)
    @StateObject var viewModel: OneClassDetailViewModel
    
    var body: some View {
        VStack{
            if let lessonData = viewModel.lessonData, let mentorUserInfo = viewModel.mentorUserInfo {
                ZStack(alignment: .bottomLeading){
                    ScrollView {
                        VStack{
                            ZStack(alignment: .topLeading){
                                WebImage(url: URL(string: lessonData.lessonImageURLString))
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width, height: 250)
                                
                                if user.purchasedLesson.contains(viewModel.lessonId) {
                                    HStack(spacing:3){
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green).background(.white).clipShape(Circle())
                                        Text("やり取り中")
                                            .fontWeight(.semibold)
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                        
                                    }.padding()
                                        .background(LinearGradient(colors: [.customRed1, .customRed2], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .font(.system(size: 15))
                                        .cornerRadius(7)
                                        .padding(.top, 5)
                                        .padding(.leading, 5)
                                        .offset(x: viewModel.purchasedLabelOffset)
                                        .onAppear{
                                            withAnimation(Animation.easeIn(duration: 0.5)){
                                                viewModel.purchasedLabelOffset = 0
                                            }
                                        }
                                }
                            }
                            Text(lessonData.lessonName)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                            Divider()
                            NavigationLink {
                                UserProfileView(
                                    username: mentorUserInfo.username,
                                    userProfileImageURL: mentorUserInfo.profileImage,
                                    usersLessonData: [],
                                    usersRequestData: [])
                            } label: {
                                HStack{
                                    WebImage(url: URL(string: mentorUserInfo.profileImage))
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading){
                                        Text(mentorUserInfo.username)
                                            .bold()
                                            .foregroundColor(.black)
                                        Text("男性")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                        Text("20代前半")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                        HStack{
                                            Text("機密保持契約(NDA)")
                                                .foregroundColor(.black)
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.green)
                                        }
                                        .font(.caption)
                                        
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.leading,16)
                            
                            Divider()
                            PreLessonChatView(
                                messageListData: MessageListData(
                                    lessonImage: lessonData.lessonImageURLString,
                                    lessonName: lessonData.lessonName,
                                    lessonContents: lessonData.lessonContent,
                                    lessonBudgets: lessonData.budget,
                                    lessonID: lessonData.lessonId,
                                    senderIconImage: mentorUserInfo.profileImage,
                                    senderName: mentorUserInfo.username,
                                    senderUid: lessonData.mentorUid,
                                    lastMessage: "",
                                    lastMessageDate: "",
                                    chatRoomData: viewModel.preChatRoomData))
                            
                        }
                        LessonQuestionView(
                            lessonImageURLString: lessonData.lessonImageURLString,
                            lessonTitle: lessonData.lessonName,
                            lessonId: viewModel.lessonId,
                            mentorIconImageURLString: mentorUserInfo.profileImage,
                            mentorName: mentorUserInfo.username)
                        EvaluationView()
                        VStack(alignment: .leading){
                            HStack{
                                Text("レッスン内容")
                                    .bold()
                                Spacer()
                            }
                            .padding(.leading, 16)
                            HStack{
                                Text(lessonData.lessonContent)
                                Spacer()
                            }.padding(.leading, 16)
                        }
                    }
                    if viewModel.visiblePriceBubble {
                        PriceBubble(visiblePriceBubble: $viewModel.visiblePriceBubble)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(width: 150)
                            .padding(.leading, 16)
                    }
                }
                VStack(spacing: .zero){
                    GeometryReader { geometryProxy in
                        Divider()
                        HStack(alignment: .bottom){
                            DismissButtonView()
                                .padding(.leading, 16)
                            
                            ZStack(alignment: .topLeading){
                                Text("\(lessonData.budget)円/h")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.horizontal, 10)
                                    .frame(width: geometryProxy.size.width/3,height: 50)
                                    .background(.black)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        viewModel.visiblePriceBubble = true
                                    }
                                    .padding(.leading,16)
                            }
                            Spacer()
                            if user.purchasedLesson.contains(viewModel.lessonId) {
                                VStack(spacing: .zero){
                                    NavigationLink {
                                        ChatView(
                                            messageListData: MessageListData(
                                                lessonImage: lessonData.lessonImageURLString,
                                                lessonName: lessonData.lessonName,
                                                lessonContents: lessonData.lessonContent,
                                                lessonBudgets: viewModel.lessonData?.budget ?? 0,
                                                lessonID: viewModel.lessonId,
                                                senderIconImage: viewModel.mentorUserInfo?.profileImage ?? "",
                                                senderName: viewModel.mentorUserInfo?.username ?? "",
                                                senderUid: viewModel.lessonData?.mentorUid ?? "",
                                                lastMessage: "",
                                                lastMessageDate: "",
                                                chatRoomData: viewModel.chatroomData), chatRoomType: chatRoomType).onAppear{
                                                    chatRoomType.messageListStyle = .normalChat
                                                    chatRoomType.chatMode = .student
                                                }
                                    } label: {
                                        Text("やり取りする")
                                            .foregroundColor(.white)
                                            .bold()
                                            .frame(width: geometryProxy.size.width/3,height: 50)
                                            .background(Color.customBlue)
                                            .cornerRadius(10)
                                            .padding(.trailing, 16)
                                    }
                                }
                            } else {
                                VStack(spacing: .zero){
                                    NavigationLink {
                                        PurchaseView(
                                            lessonId: viewModel.lessonId,
                                            amount: lessonData.budget,
                                            lessonImageURLString: lessonData.lessonImageURLString,
                                            lessonName: lessonData.lessonName,
                                            mentorIconImageURLString: mentorUserInfo.profileImage,
                                            mentorName: mentorUserInfo.username)
                                    } label: {
                                        Text("購入画面へ")
                                            .foregroundColor(.white)
                                            .bold()
                                            .frame(width:geometryProxy.size.width/3, height: 50)
                                            .background(Color.customBlue)
                                            .cornerRadius(10)
                                            .padding(.trailing, 16)
                                    }
                                }
                            }
                        }
                        .padding(.top,20)
                        .background(.ultraThinMaterial)
                    }
                    .frame(height: 70)
                }
                .offset(y: viewModel.underBarOffset)
                .onAppear{
                    withAnimation(Animation.easeIn(duration: 0.5)) {
                        viewModel.underBarOffset = 0
                    }
                }
            } else {
                ProgressView()
            }
        }.onAppear{
            UITabBar.appearance().isHidden = true
        }.navigationBarHidden(true)
    }
}

struct EvaluationView:View {
    var body: some View{
        Divider()
        HStack{
            VStack(alignment: .leading){
                Text("評価とレビュー")
                    .bold()
                HStack(spacing: 3){
                    Text("総評価")
                        .font(.caption)
                    ForEach(0..<5){ _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.orange)
                    }
                    Text("(3)")
                }
                .padding(.leading, 16)
            }
            .padding(.leading, 16)
            Spacer()
        }
        Divider()
    }
}

enum QuestionNextScereen: String ,Identifiable {
    var id: String { rawValue }
    case noContent
    case moreQuestion
}


struct PreLessonChatView: View {
    let messageListData: MessageListData
    @ObservedObject var chatRoomType = ChatRoomType(chatMode: .student, messageListStyle: .beforePurchaseChat)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("購入前チャット")
                .bold()
                .padding(.leading, 16)
            Text("*この講座は購入前に事前チャットする必要があります。")
                .font(.caption)
                .padding(.leading, 16)
            NavigationLink {
                ChatView(messageListData: messageListData, chatRoomType: chatRoomType)
            } label: {
                HStack{
                    Text("購入前チャットはこちら")
                        .font(.system(size: 13))
                        .foregroundColor(Color.customBlue)
                        .bold()
                    Spacer()
                }
                .padding(.leading, 16)
            }
        }
    }
}

struct LessonQuestionView: View {
    
    @State var lessonQuestions: [QuestionRecords] = []
    @State var modalContents: QuestionNextScereen?
    @State var shouldOpenMoreQuestionScreen:Bool = false
    @State var shouldOpenMakeQuestionScreen: Bool = false
    
    let lessonImageURLString: String
    let lessonTitle: String
    let lessonId: String
    let mentorIconImageURLString: String
    let mentorName: String
    var body: some View{
        VStack{
            Divider()
            VStack {
                VStack(alignment: .leading){
                    HStack{
                        Text("講座に関する質問")
                            .bold()
                        Spacer()
                        if lessonQuestions.count != 0 {
                            Button {
                                withAnimation {
                                    shouldOpenMoreQuestionScreen = true
                                }
                            } label: {
                                Text("詳細を見る")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color.customBlue)
                                    .bold()
                                    .padding(.trailing, 16)
                            }
                        }else{
                            Button {
                                shouldOpenMakeQuestionScreen = true
                            } label: {
                                Text("質問をする")
                                    .font(.system(size: 13))
                                    .foregroundColor(.customBlue)
                                    .bold()
                                    .padding(.trailing, 16)
                            }
                        }
                    }
                    .padding(.leading,16)
                    if lessonQuestions.count == 0 {
                        Text("この講座にはまだ質問がありません。質問してみましょう。")
                            .font(.caption)
                            .padding(.leading, 16)
                    } else {
                        ForEach(lessonQuestions, id: \.self) { question in
                            HStack{
                                Text("Q:")
                                    .foregroundColor(.gray)
                                Text(question.questionText)
                                    .font(.caption)
                            }
                        }
                        .padding(.leading,16)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $shouldOpenMoreQuestionScreen, content: {
            MoreQuestionView(questionRecords: lessonQuestions, mentorIconImageURLString: mentorIconImageURLString, mentorName: mentorName, lessonImageURL: lessonImageURLString, lessonTitle: lessonTitle, lessonID: lessonId, dismiss: $shouldOpenMoreQuestionScreen).transition(.scale)
        })
        .sheet(isPresented: $shouldOpenMakeQuestionScreen, content: {
            MakeQuestionView(lessonImageURLString: lessonImageURLString, lessonName: lessonTitle, mentorIconImageURLString: lessonImageURLString, mentorName: mentorName, lessonID: lessonId)
        }).onAppear{
            lessonQuestions = []
            SearchByAlgolia().searchQuestionData(keyword: lessonId) { result in
                self.lessonQuestions.append(result)
            }
        }
    }
}
