//
//  SearchView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI
import Combine

struct SearchView:View {
    @State private var serarchWord = ""
    
    private var categories:[SearchCategory] = [
        SearchCategory(categoryName: "店名から探す", categoryImageName: "house"),
        SearchCategory(categoryName: "場所から探す", categoryImageName: "map"),
        SearchCategory(categoryName: "投稿から探す", categoryImageName: "photo"),
        SearchCategory(categoryName: "ユーザーから探す", categoryImageName: "person"),
        SearchCategory(categoryName: "友達から探す", categoryImageName: "person.2"),
    ]
    
    var body: some View{
        NavigationView{
            ZStack{
                
                Form {
                    Section {
                        Text("aaa")
                    }
                }
            }.searchable(text: $serarchWord,placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search All")).ignoresSafeArea(edges: .bottom)
        }
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchCategoriesCellView:View {
    
    let searchCategory:SearchCategory
    var body: some View{
        HStack{
            Image(systemName:searchCategory.categoryImageName).foregroundColor(Color.white)
            Text(searchCategory.categoryName).foregroundColor(Color.white)
        }
    }
}

struct SearchCategory:Identifiable{
    var id = UUID()
    var categoryName:String
    var categoryImageName: String
    var rightArrowsImageName:String = ""
}
