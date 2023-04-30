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
    let algoliaController = AlgoliaController()
    @EnvironmentObject var user: User
    @EnvironmentObject var app: AppState
    @State private var selectedTab: Tab = .home
    @State private var navigationTitle:String = ""
    @State private var navigationStyle:Bool = true
    @State private var searchWord = ""
    
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
                        CustomTabView(
                            selectedTab: $selectedTab,
                            navigationTitle: $navigationTitle
                        )
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }.tag(Tab.home)
                
                NavigationView {
                    VStack{
                        SearchView(
                            hitsController: algoliaController.hitsController,
                            searchBoxController: algoliaController.searchBoxController,
                            statsController: algoliaController.statsController,
                            facetListController: algoliaController.facetListController,
                            loadingController: algoliaController.loadingController
                        )
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                            
                        )
                        .onAppear{
                            algoliaController.searcher.search()
                        }
                        Divider()
                        CustomTabView(
                            selectedTab: $selectedTab,
                            navigationTitle: $navigationTitle
                        )
                    }.ignoresSafeArea(.keyboard, edges: .bottom)
                }.tag(Tab.search)

                NavigationView {
                    VStack{
                        MessageListView()
                        Divider()
                        CustomTabView(
                            selectedTab: $selectedTab,
                            navigationTitle: $navigationTitle
                        )
                    }
                }.tag(Tab.message)
                
                NavigationView {
                    VStack{
                        ProfileView()
                        CustomTabView(
                            selectedTab: $selectedTab,
                            navigationTitle: $navigationTitle
                        )
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
                self.user.headerImage = doc.headerImage
                self.user.selfIntroduce = doc.singleIntroduction
                self.user.career = doc.career
                self.user.gender = doc.gender
                self.user.generation = doc.generation
                self.user.skill = doc.skills
            }
        }
        .accentColor(.black)
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
