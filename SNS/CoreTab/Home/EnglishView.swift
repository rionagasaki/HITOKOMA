//
//  EnglishView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct EnglishView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading){
                VStack(alignment: .leading){
                    Text("詳細なカテゴリー").bold().padding(.leading,16)
                    DetailCategoryView(detailCategory: [DetailCategory(categoryName: "TOEIC", categoryImage: "TOEIC"),DetailCategory(categoryName: "TOEFL", categoryImage: "TOEFL"),DetailCategory(categoryName: "英検", categoryImage: "EnglishTest")])
                }
                Text("検索結果").bold().padding(.leading,16).padding(.top, 10)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        SearchResultClassView()
                        SearchResultClassView()
                        SearchResultClassView()
                    }.padding(.horizontal, 16)
                }
                Spacer()
            }
        }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)).navigationTitle("英語")
    }
}

struct EnglishView_Previews: PreviewProvider {
    static var previews: some View {
        EnglishView()
    }
}
