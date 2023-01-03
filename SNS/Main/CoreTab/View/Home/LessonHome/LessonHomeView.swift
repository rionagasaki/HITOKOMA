//
//  LessonHomeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

struct LessonHomeView: View {
    @StateObject private var viewModel = LessonHomeViewModel()
    var body: some View {
        ScrollView {
            HStack{
                Text("カテゴリー")
                    .foregroundColor(.black)
                    .bold()
                    .font(.system(size: 20))
                    .padding(.leading,16)
                Spacer()
            }
            HStack {
                ForEach(allCategories) { category in
                    NavigationLink {
                        switch category.category {
                        case .english:
                            SearchCategoryDetailView(
                                lessonsData: viewModel.lessonEnglishData,
                                detailCategories: englishDetails,
                                mainCategory: .english
                            )
                        case .computer:
                            SearchCategoryDetailView(
                                lessonsData: viewModel.lessonComputerData,
                                detailCategories: computerDetails,
                                mainCategory: .computer
                            )
                        case .law:
                            SearchCategoryDetailView(
                                lessonsData: viewModel.lessonLawData,
                                detailCategories: lawDetails,
                                mainCategory: .law
                            )
                        case .finance:
                            SearchCategoryDetailView(
                                lessonsData: viewModel.lessonFinanceData,
                                detailCategories: financeDetails,
                                mainCategory: .finance
                            )
                        case .investment:
                            SearchCategoryDetailView(
                                lessonsData: viewModel.lessonInvestmentData,
                                detailCategories: investmentDetails,
                                mainCategory: .investment
                            )
                        }
                    } label: {
                        Category(category: category)
                    }
                }
            }
            VStack{
                VStack(spacing: 5){
                    HStack{
                        Text("話題のひとこま")
                            .foregroundColor(.black)
                            .bold()
                            .font(.system(size: 20))
                            .padding(.leading,16)
                            .padding(.top, 16)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(viewModel.lessonData) { lesson in
                                NavigationLink {
                                    OneClassDetailView(
                                        viewModel: OneClassDetailViewModel(
                                            lessonId: lesson.lessonId))
                                } label: {
                                    OneClassView(
                                        lessonImageURLString: lesson.lessonImageURLString,
                                        lessonName: lesson.lessonName,
                                        userIconURLString: lesson.userImageIconURLString,
                                        lessonBudgets: lesson.budget
                                    )
                                }
                            }
                            
                        }
                    }.padding(.horizontal, 16)
                }
                Group{
                    lessonList(
                        bigCategory: "英語",
                        categoryLessonData: viewModel.lessonEnglishData,
                        deatilCategories: englishDetails,
                        categoryDetail: .english
                    )
                    lessonList(
                        bigCategory: "IT",
                        categoryLessonData: viewModel.lessonComputerData,
                        deatilCategories: computerDetails,
                        categoryDetail: .computer
                    )
                    lessonList(
                        bigCategory: "法律",
                        categoryLessonData: viewModel.lessonLawData,
                        deatilCategories: lawDetails,
                        categoryDetail: .law
                    )
                    lessonList(
                        bigCategory: "ファイナンス",
                        categoryLessonData: viewModel.lessonFinanceData,
                        deatilCategories: financeDetails,
                        categoryDetail: .finance
                    )
                    lessonList(
                        bigCategory: "投資",
                        categoryLessonData: viewModel.lessonInvestmentData,
                        deatilCategories: investmentDetails,
                        categoryDetail: .investment
                    )
                }
            }
        }
    }
    
    private func lessonList(bigCategory: String, categoryLessonData: [LessonData], deatilCategories:[DetailCategory], categoryDetail: CategoryDetail) -> some View {
        VStack(spacing: 5){
            NavigationLink {
                SearchCategoryDetailView(
                    lessonsData: categoryLessonData,
                    detailCategories: deatilCategories,
                    mainCategory: categoryDetail
                )
            } label: {
                HStack{
                    Text(bigCategory)
                        .foregroundColor(.black)
                        .bold()
                        .font(.system(size: 18))
                        .padding(.leading,16)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width:10, height:13)
                        .foregroundColor(.gray)
                        .font(.largeTitle.weight(.bold))
                    Spacer()
                }
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(categoryLessonData) { lesson in
                        NavigationLink {
                            OneClassDetailView(
                                viewModel: OneClassDetailViewModel(
                                    lessonId: lesson.lessonId))
                        } label: {
                            OneClassView(
                                lessonImageURLString: lesson.lessonImageURLString,
                                lessonName: lesson.lessonName,
                                userIconURLString: lesson.userImageIconURLString,
                                lessonBudgets: lesson.budget
                            )
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }.padding(.top,16)
    }
}

struct LessonHomeView_Previews: PreviewProvider {
    static var previews: some View {
        LessonHomeView()
    }
}
