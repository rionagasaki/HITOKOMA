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
    @State private var selectedColorIndex = 0
    private var categories:[SearchCategory] = [
        SearchCategory(categoryName: "店名から探す", categoryImageName: "house"),
        SearchCategory(categoryName: "場所から探す", categoryImageName: "map"),
        SearchCategory(categoryName: "投稿から探す", categoryImageName: "photo"),
        SearchCategory(categoryName: "ユーザーから探す", categoryImageName: "person"),
        SearchCategory(categoryName: "友達から探す", categoryImageName: "person.2"),
    ]
    
    private let suggestion = [SearchSuggestion(suggestionTitle: "Hello", description: "aaaaaaaaa", suggestionImage: "rootImage"),SearchSuggestion(suggestionTitle: "Morning", description: "aaaaaaaaa", suggestionImage: "rootImage"),SearchSuggestion(suggestionTitle: "Master", description: "aaaaaaaaa", suggestionImage: "rootImage"),SearchSuggestion(suggestionTitle: "King", description: "aaaaaaaaa", suggestionImage: "rootImage")]
    
    
    var body: some View{
        ZStack {
            VStack(alignment:.leading ,spacing: 20){
                HStack{
                    Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.yellow)
                    Circle().size(width: 200, height: 200).blur(radius: 80).foregroundColor(.pink)
                }
                HStack{
                    Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.blue).padding(.top,-120)
                    Circle().size(width: 200, height: 200).blur(radius: 50).foregroundColor(.orange).padding(.top,30)
                }
            }
            ScrollView{
                VStack {
                    if suggestion.filter{ $0.suggestionTitle.contains(serarchWord) || serarchWord == "" || $0.description.contains(serarchWord)}.count == 0{
                        VStack{
                            Text("NOT FOUND").bold()
                            Image("sorry").resizable().frame(width: 100, height: 100)
                            Text("検索結果が見つかりませんでした。\n入力を変えて再度お試しください。")
                        }
                    }else{
                        ForEach(suggestion.filter({ $0.suggestionTitle.contains(serarchWord) || serarchWord == "" || $0.description.contains(serarchWord)
                        })) { suggestion in
                            Divider()
                            SuggestionView(classImage: suggestion.suggestionImage, classTitle: suggestion.suggestionTitle, classDescription: suggestion.description)
                        }
                    }
                    Divider()
                }.padding().background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20)).padding()
            }
            .searchable(text: $serarchWord,placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search All")).navigationBarTitleDisplayMode(.inline).navigationBarItems(trailing: Button(action: {
                print("aaa")
            }, label: {
                Text("Done")
            })).toolbar(content: {
                Picker("", selection: $selectedColorIndex) {
                    
                }
            }).ignoresSafeArea(edges: .bottom)
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
