//
//  ContentView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI
import CoreData
import Combine


struct ContentView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var app: AppState
    @State var selectedTab: Tab = .home
    @State var navigationTitle:String = ""
    @State var navigationStyle:Bool = true
    @State var mentorMessages:[MessageListData] = []
    @State var studentsMessages:[MessageListData] = []
    @State var prePurchaseMentorMessages: [MessageListData] = []
    @State var prePurchaseStudentMessages: [MessageListData] = []
    @State var completionLessonAsMentorMessages: [MessageListData] = []
    @State var completionLessonAsStudentMessages: [MessageListData] = []
    @State var searchWord = ""
    
    var loginUserIconURLString: String = ""
    var loginUsername: String = ""
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab){
                NavigationView {
                    VStack{
                        HomeView()
                        Divider()
                        CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.navigationBarTitleDisplayMode(.inline)
                }.tag(Tab.home)
                
                NavigationView {
                    VStack{
                        SearchView()
                        Divider()
                        CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.ignoresSafeArea(.keyboard, edges: .bottom)
                }.tag(Tab.search)
                
                
                NavigationView {
                    VStack{
                        MessageListView(
                            mentorMessages: mentorMessages,
                            studentsMessages: studentsMessages,
                            prePurchaseMentorMessages: prePurchaseMentorMessages,
                            prePurchaseStudentsMessages: prePurchaseStudentMessages,
                            completionLessonAsMentorMessages: completionLessonAsMentorMessages,
                            completionLessonAsStudentMessages: completionLessonAsStudentMessages
                        )
                        Divider()
                        CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }
                }.tag(Tab.message)
                
                NavigationView {
                    VStack{
                        ProfileView(username: user.username, email: user.email, profileImage: user.profileImage)
                        CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }
                }.tag(Tab.profile)
            }
        }.onAppear{
            self.app.isLoading = true
            
            // MARK: User情報を取得
            FetchFromFirestore().fetchUserInfoFromFirestore { doc in
                self.user.userID = doc.uid
                self.user.username = doc.username
                self.user.email = doc.email
                self.user.customerId = doc.customerId
                self.user.profileImage = doc.profileImage
                self.user.purchasedLesson =  doc.purchasedLessons
            }
            
            // MARK: Mentorモードの場合、自身の生徒とのチャット情報取得
            FetchFromFirestore().fetchStudentMessageInfo(path: "Chat"){ studentChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: studentChatRoom.studentUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: studentChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: studentChatRoom.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: studentChatRoom.lastMessageText, lastMessageDate: studentChatRoom.lastMessageDate, chatRoomData: studentChatRoom)
                        self.studentsMessages.append(messageData)
                    }
                    
                }
            }
            // MARK: (事前)Mentorモードの場合、自身の生徒とのチャット情報取得
            FetchFromFirestore().fetchStudentMessageInfo(path: "BeforePurchaseChat") { prePurchaseStudentChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: prePurchaseStudentChatRoom.studentUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: prePurchaseStudentChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget,lessonID: prePurchaseStudentChatRoom.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: prePurchaseStudentChatRoom.lastMessageText, lastMessageDate: prePurchaseStudentChatRoom.lastMessageDate, chatRoomData: prePurchaseStudentChatRoom)
                        self.prePurchaseStudentMessages.append(messageData)
                    }
                }
            }
            // MARK: Studentモードの場合の、自身のメンターとのチャット情報取得
            FetchFromFirestore().fetchMentorMessageInfo(path: "Chat") { mentorChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: mentorChatRoom.mentorUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: mentorChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: lessonInfo.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: mentorChatRoom.lastMessageText, lastMessageDate: mentorChatRoom.lastMessageDate, chatRoomData: mentorChatRoom)
                        if lessonInfo.completionUser.contains(userInfo.uid) {
                            self.completionLessonAsStudentMessages.append(messageData)
                        } else {
                            self.mentorMessages.append(messageData)
                        }
                    }
                }
            }
            // MARK: (事前)Studentモードの場合の、自身のメンターとのチャット情報取得
            FetchFromFirestore().fetchMentorMessageInfo(path: "BeforePurchaseChat") { prePurchaseMentorChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: prePurchaseMentorChatRoom.mentorUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: prePurchaseMentorChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: lessonInfo.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: prePurchaseMentorChatRoom.lastMessageText, lastMessageDate: prePurchaseMentorChatRoom.lastMessageDate, chatRoomData: prePurchaseMentorChatRoom)
                        if lessonInfo.completionUser.contains(userInfo.uid) {
                            self.completionLessonAsMentorMessages.append(messageData)
                        } else {
                            self.studentsMessages.append(messageData)
                        }
                    }
                }
            }
        }.accentColor(.black).background(.ultraThinMaterial)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
        
    }
}


enum CategoryDetail: String{
    case english = "英語"
    case computer = "IT"
    case law = "法律"
    case finance = "ファイナンス"
    case investment = "投資"
}
