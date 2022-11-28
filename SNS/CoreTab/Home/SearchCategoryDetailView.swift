//
//  EnglishView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct SearchCategoryDetailView: View {
    @State private var searchText = ""
    let detailCategories:[DetailCategory]
    let lessonsData: [LessonData]
    let mainCategory:CategoryDetail
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView {
                VStack(alignment:.leading){
                    VStack(alignment: .leading){
                        Text("詳細なカテゴリー").bold().padding(.leading,16)
                        DetailCategoryView(detailCategory: detailCategories, selection: 0)
                    }
                    Text("検索結果").bold().padding(.leading,16).padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(lessonsData) { lesson in
                                OneClassView(lessonImageURLString: lesson.lessonImageURLString, lessonName: lesson.lessonName, userIconURLString: lesson.userImageIconURLString, lessonBudgets: lesson.budget)
                            }
                        }.padding(.horizontal, 16)
                    }
                    Spacer()
                }
            }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)).navigationTitle(mainCategory.rawValue)
        }
    }
}

struct EnglishView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoryDetailView(detailCategories: [], lessonsData: [], mainCategory: .english)
    }
}

