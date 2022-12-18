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
    var selectedMenuImage: String
    var tab:Tab
}

var tabItems = [
    TabBar(menuTitle: "ホーム", menuImage: "house",selectedMenuImage: "house.fill", tab: Tab.home),
    TabBar(menuTitle: "探す", menuImage: "magnifyingglass",selectedMenuImage: "magnifyingglass", tab: Tab.search),
    TabBar(menuTitle: "メッセージ", menuImage: "message",selectedMenuImage: "message.fill", tab: Tab.message),
    TabBar(menuTitle: "マイページ", menuImage:"person", selectedMenuImage: "person.fill", tab: Tab.profile)
]

enum Tab:String{
    case home = "home"
    case search = "search"
    case profile = "profile"
    case message = "message"
}
