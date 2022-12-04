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
    @State var selectedTab: Tab = .home
    @State var navigationTitle:String = ""
    @State var navigationStyle:Bool = true
    @State var requestData: [RequestData] = []
    @State var englishRequestData: [RequestData] = []
    @State var computerRequestData: [RequestData] = []
    @State var lawRequestData: [RequestData] = []
    @State var financeRequestData: [RequestData] = []
    @State var investmentRequestData: [RequestData] = []
    @State var lessonData:[LessonData] = []
    @State var englishLessonData: [LessonData] = []
    @State var computerLessonData: [LessonData] = []
    @State var lawLessonData:[LessonData] = []
    @State var financeLessonData: [LessonData] = []
    @State var investmentLessonData: [LessonData] = []
    @EnvironmentObject var user: User
    @State var mentorMessages:[MessageListData] = []
    @State var studentsMessages:[MessageListData] = []
    @State var prePurchaseMentorMessages: [MessageListData] = []
    @State var prePurchaseStudentMessages: [MessageListData] = []
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
                        HomeView(requestData: requestData, requestEnglishData: englishRequestData, requestComputerData: computerRequestData, requestLawData: lawRequestData, requestFinanceData: financeRequestData, requestInvestmentData: investmentRequestData, lessonData: lessonData, lessonEnglishData: englishLessonData, lessonComputerData: computerLessonData, lessonLawData: lawLessonData, lessonFinanceData: financeLessonData, lessonInvestmentData: investmentLessonData
                        )
                        Divider()
                        CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.navigationBarTitleDisplayMode(.inline)
                }.tag(Tab.home)
                
                NavigationView {
                    VStack{
                        SearchView()
                        Divider()
                        CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }
                }.tag(Tab.search)
                
                
                NavigationView {
                    VStack{
                        MessageListView(
                            mentorMessages: mentorMessages,
                            studentsMessages: studentsMessages,
                            prePurchaseMentorMessages: prePurchaseMentorMessages,
                            prePurchaseStudentsMessages: prePurchaseStudentMessages
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
            self.lessonData = []
            
            // MARK: User情報を取得
            FetchFromFirestore().fetchUserInfoFromFirestore { doc in
                self.user.userID = doc.uid
                self.user.username = doc.username
                self.user.email = doc.email
                self.user.profileImage = doc.profileImage
                self.user.purchasedLesson =  doc.purchasedLessons
            }
            
            // MARK: Request情報を取得、Categorize
            FetchFromFirestore().fetchRequestInfoFromFirestore { request in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: request.requestUserUid) { userInfo in
                    request.userImageIconURL = userInfo.profileImage
                    request.username = userInfo.username
                    requestData.append(request)
                    let bigCategory = CategoryDetail(rawValue: request.bigCategory)
                    switch bigCategory {
                    case .english: self.englishRequestData.append(request)
                    case .computer: self.computerRequestData.append(request)
                    case .law: self.lawRequestData.append(request)
                    case .finance: self.financeRequestData.append(request)
                    case .investment: self.investmentRequestData.append(request)
                    case .none:
                        print("Error_NoCategory")
                    }
                }
            }
            
            // MARK: Lesson情報を取得、Categorize
            FetchFromFirestore().fetchLessonInfoFromFirestore { lesson in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: lesson.mentorUid) { userInfo in
                    lesson.userImageIconURLString = userInfo.profileImage
                    lesson.username = userInfo.username
                    lessonData.append(lesson)
                    let bigCategory = CategoryDetail(rawValue: lesson.bigCategory)
                    switch bigCategory {
                    case .english: self.englishLessonData.append(lesson)
                    case .computer: self.computerLessonData.append(lesson)
                    case .law: self.lawLessonData.append(lesson)
                    case .finance: self.financeLessonData.append(lesson)
                    case .investment: self.investmentLessonData.append(lesson)
                    case .none:
                        print("Error_NoCategory")
                    }
                }
            }
            
            // MARK: LoginUserがMentorモードの場合、自身の生徒とのチャット情報取得
            FetchFromFirestore().fetchStudentMessageInfo(path: "Chat"){ studentChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: studentChatRoom.studentUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: studentChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: studentChatRoom.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: studentChatRoom.lastMessageText, lastMessageDate: studentChatRoom.lastMessageDate)
                        self.studentsMessages.append(messageData)
                    }
                    
                }
            }
            // MARK: LoginUserがMentorモードの場合、自身の生徒とのチャット情報取得
            FetchFromFirestore().fetchStudentMessageInfo(path: "BeforePurchaseChat") { prePurchaseStudentChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: prePurchaseStudentChatRoom.studentUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: prePurchaseStudentChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget,lessonID: prePurchaseStudentChatRoom.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: prePurchaseStudentChatRoom.lastMessageText, lastMessageDate: prePurchaseStudentChatRoom.lastMessageDate)
                        self.prePurchaseStudentMessages.append(messageData)
                    }
                }
            }
            // MARK: (取引中のチャット)LoginUserがStudentモードの場合の、自身のメンターとのチャット情報取得
            FetchFromFirestore().fetchMentorMessageInfo(path: "Chat") { mentorChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: mentorChatRoom.mentorUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: mentorChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: lessonInfo.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: mentorChatRoom.lastMessageText, lastMessageDate: mentorChatRoom.lastMessageDate)
                        self.mentorMessages.append(messageData)
                    }
                }
            }
            // MARK: (事前チャット)LoginUserがStudentモードの場合の、自身のメンターとのチャット情報取得
            FetchFromFirestore().fetchMentorMessageInfo(path: "BeforePurchaseChat") { prePurchaseMentorChatRoom in
                FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: prePurchaseMentorChatRoom.mentorUid) { userInfo in
                    FetchFromFirestore().fetchOneLessonInfoFromFirestore(lessonId: prePurchaseMentorChatRoom.lessonId) { lessonInfo in
                        let messageData = MessageListData(lessonImage: lessonInfo.lessonImageURLString, lessonName: lessonInfo.lessonName,lessonContents: lessonInfo.lessonContent, lessonBudgets: lessonInfo.budget, lessonID: lessonInfo.lessonId, senderIconImage: userInfo.profileImage, senderName: userInfo.username, senderUid: userInfo.uid, lastMessage: prePurchaseMentorChatRoom.lastMessageText, lastMessageDate: prePurchaseMentorChatRoom.lastMessageDate)
                        self.prePurchaseMentorMessages.append(messageData)
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
