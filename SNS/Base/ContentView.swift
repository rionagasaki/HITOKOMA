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
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment:.bottom){
            TabView(selection:$selectedTab){
                NavigationView{
                    ZStack(alignment:.bottom){
                    HomeView()
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
                    MessageState.initial
                    CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.navigationTitle("メッセージ").ignoresSafeArea(edges: .bottom)
                }.tag(Tab.message)
                NavigationView{
                    ZStack(alignment:.bottom){
                    ProfileView()
                    CustomTabView(selectedTab: $selectedTab, navigationTitle: $navigationTitle)
                    }.ignoresSafeArea()
                }.tag(Tab.profile)
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
