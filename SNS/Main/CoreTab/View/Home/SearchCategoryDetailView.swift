//
//  EnglishView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI

struct SearchCategoryDetailView: View {
    @State private var searchText = ""
    @State private var selectoion = 0
    @State private var searchableLesson:[LessonData] = []
    @Namespace var namespace
    let lessonsData: [LessonData]
    let detailCategories:[DetailCategory]
    
    let mainCategory:CategoryDetail
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView {
                VStack(alignment:.leading){
                    VStack(alignment: .leading){
                        Text("詳細なカテゴリー").bold().font(.system(size: 20)).padding(.leading,16)
                        DetailCategoryView(detailCategory: detailCategories, lessonData: lessonsData, searchableLessonData: $searchableLesson, selection: $selectoion, namespace: namespace)
                    }
                    Text("検索結果").bold().font(.system(size: 20)).padding(.leading,16).padding(.top, 10)
                    if searchableLesson.count != 0 {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(searchableLesson) { lesson in
                                    NavigationLink {
                                        EmptyView()
                                    } label: {
                                        OneClassView(lessonImageURLString: lesson.lessonImageURLString, lessonName: lesson.lessonName, userIconURLString: lesson.userImageIconURLString, lessonBudgets: lesson.budget)
                                    }

                                }
                            }.padding(.horizontal, 16)
                        }
                    } else {
                        VStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.init(uiColor: .lightGray))
                            
                            Text("申し訳ありません。\n指定されたレッスンは現在ありません。")
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 15))
                            Spacer()
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                    }
                    Spacer()
                }
            }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)).navigationTitle(mainCategory.rawValue)
        }.onAppear{
            self.searchableLesson = lessonsData
        }
    }
}

struct EnglishView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoryDetailView(lessonsData: [], detailCategories: [], mainCategory: .english)
    }
}


