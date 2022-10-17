//
//  Tab.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/24.
//

import Foundation

struct TabBar: Identifiable{
    var id = UUID()
    var menuTitle:String
    var menuImage:String
    var tab:Tab
}

var tabItems = [
    TabBar(menuTitle: "学ぶ", menuImage: "house", tab: Tab.home),
    TabBar(menuTitle: "探す", menuImage: "magnifyingglass", tab: Tab.search),
    TabBar(menuTitle: "マイページ", menuImage:"person", tab: Tab.profile)
]

enum Tab:String{
    case home = "home"
    case search = "search"
    case profile = "profile"
}
