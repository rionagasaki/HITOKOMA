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
    var loginUserIconURLString: String = ""
    var loginUsername: String = ""
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment:.bottom){
            TabView(selection:$selectedTab){
                NavigationView{
                    ZStack(alignment:.bottom){
                        HomeView(requestData: requestData, requestEnglishData: englishRequestData, requestComputerData: computerRequestData, requestLawData: lawRequestData, requestFinanceData: financeRequestData, requestInvestmentData: investmentRequestData, lessonData: lessonData, lessonEnglishData: englishLessonData, lessonComputerData: computerLessonData, lessonLawData: lawLessonData, lessonFinanceData: financeLessonData, lessonInvestmentData: investmentLessonData)
                    CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.navigationTitle("").ignoresSafeArea()
                }.tag(Tab.home)
                NavigationView{
                    ZStack(alignment:.bottom){
                    SearchView()
                    CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.navigationTitle("見つける").ignoresSafeArea(edges: .bottom)
                }.tag(Tab.search)
                NavigationView{
                    ZStack(alignment:.bottom){
                        MessageListView()
                    CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.navigationTitle("メッセージ").ignoresSafeArea(edges: .bottom)
                }.tag(Tab.message)
                NavigationView{
                    ZStack(alignment:.bottom){
                        ProfileView(username: user.username, email: user.email, profileImage: user.profileImage)
                    CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.ignoresSafeArea()
                }.tag(Tab.profile)
            }
        }.onAppear{
            self.lessonData = []
            FetchFromFirestore().fetchUserInfoFromFirestore { doc in
                self.user.username = doc.username
                self.user.email = doc.email
                self.user.profileImage = doc.profileImage
            }
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
        }
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
