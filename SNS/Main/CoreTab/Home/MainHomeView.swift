//
//  MainHomeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/22.
//

import SwiftUI

struct MainHomeView: View {
    
    let categories = [
        CategoryData(categoryName: "英会話", categoryImage: "English", category: .english),
        CategoryData(categoryName: "IT", categoryImage: "computer", category: .computer),
        CategoryData(categoryName: "法律", categoryImage: "study", category: .law),
        CategoryData(categoryName: "ファイナンス", categoryImage: "coffee", category: .finance),
        CategoryData(categoryName: "投資", categoryImage: "invest", category: .investment)]
    
    let englishDetails = [DetailCategory(categoryName: "全て", categoryImage: "English"),DetailCategory(categoryName: "TOEIC", categoryImage: "TOEIC"),DetailCategory(categoryName: "TOEFL", categoryImage: "TOEFL"),DetailCategory(categoryName: "英検", categoryImage: "EnglishTest"), DetailCategory(categoryName: "その他", categoryImage: "")]
    
    let computerDetails = [DetailCategory(categoryName: "全て", categoryImage: "computer"),DetailCategory(categoryName: "基本/応用情報", categoryImage: "basicInformation"), DetailCategory(categoryName: "プログラミング", categoryImage: "programming"), DetailCategory(categoryName: "G/E資格", categoryImage: "AI"),DetailCategory(categoryName: "その他", categoryImage: "")
    ]
    
    let lawDetails = [DetailCategory(categoryName: "全て", categoryImage: "study"),DetailCategory(categoryName: "宅建", categoryImage: "law"), DetailCategory(categoryName: "その他", categoryImage: "")]
    
    let financeDetails = [DetailCategory(categoryName: "全て", categoryImage: "coffee"),DetailCategory(categoryName: "会計士", categoryImage: "accountant"), DetailCategory(categoryName: "簿記", categoryImage: "bookKeeping"),DetailCategory(categoryName: "その他", categoryImage: "")]
    
    let investmentDetails = [DetailCategory(categoryName: "全て", categoryImage: "invest"),DetailCategory(categoryName: "株式取引", categoryImage: ""), DetailCategory(categoryName: "為替取引", categoryImage: ""), DetailCategory(categoryName: "資産運用", categoryImage: ""), DetailCategory(categoryName: "その他", categoryImage: "")]
    
    let lessonData: [LessonData]
    let lessonEnglishData: [LessonData]
    let lessonComputerData: [LessonData]
    let lessonLawData: [LessonData]
    let lessonFinanceData: [LessonData]
    let lessonInvestmentData: [LessonData]
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ScrollView {
                VStack(alignment: .center){
                    TabView {
                        Image("header").resizable()
                        Image("header").resizable()
                    }.tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }.frame(width: UIScreen.main.bounds.width-60,height:200).cornerRadius(15).padding(.top,15).shadow(radius: 10)
                
                HStack{
                    Text("カテゴリー").foregroundColor(.black).bold().font(.system(size: 20)).padding(.top, 16).padding(.leading,16)
                    Spacer()
                    Button {
                        print("aaaa")
                    } label: {
                        Text("全てを表示").font(.system(size: 13)).foregroundColor(.customBlue).bold().padding(.top, 16)
                    }.padding(.trailing,20)
                }
                HStack {
                    ForEach(categories) { category in
                        NavigationLink {
                            switch category.category{
                            case .english: SearchCategoryDetailView(lessonsData: lessonEnglishData, detailCategories: englishDetails, mainCategory: .english)
                            case .computer: SearchCategoryDetailView(lessonsData: lessonComputerData, detailCategories: computerDetails, mainCategory: .computer)
                            case .law: SearchCategoryDetailView(lessonsData: lessonLawData, detailCategories: lawDetails, mainCategory: .law)
                            case .finance: SearchCategoryDetailView(lessonsData: lessonFinanceData, detailCategories: financeDetails, mainCategory: .finance)
                            case .investment: SearchCategoryDetailView(lessonsData: lessonInvestmentData, detailCategories: investmentDetails, mainCategory: .investment)
                            }
                        } label: {
                            Category(category: category)
                        }
                    }
                }
                VStack{
                    VStack(spacing: 5){
                        HStack{
                            Text("話題のひとこま").foregroundColor(.black).bold().font(.system(size: 20)).padding(.leading,16).padding(.top, 16)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(lessonData) { lesson in
                                    NavigationLink {
                                        OneClassDetailView(lessonImageURLString: lesson.lessonImageURLString, mentorIconImageURLString: lesson.userImageIconURLString, lessonId: lesson.lessonId, mentorName: lesson.username, mentorUid: lesson.mentorUid, lessonTitle: lesson.lessonName, lessonContent: lesson.lessonContent, budgets: lesson.budget)
                                    } label: {
                                        OneClassView(lessonImageURLString: lesson.lessonImageURLString, lessonName: lesson.lessonName, userIconURLString: lesson.userImageIconURLString, lessonBudgets: lesson.budget)
                                    }
                                }
                            }
                        }.padding(.horizontal, 16)
                    }
                    lessonList(bigCategory: "英語", categoryLessonData: lessonEnglishData, deatilCategories: englishDetails, categoryDetail: .english)
                    lessonList(bigCategory: "IT", categoryLessonData: lessonComputerData, deatilCategories: computerDetails, categoryDetail: .computer)
                    lessonList(bigCategory: "法律", categoryLessonData: lessonLawData, deatilCategories: lawDetails, categoryDetail: .law)
                    lessonList(bigCategory: "ファイナンス", categoryLessonData: lessonFinanceData, deatilCategories: financeDetails, categoryDetail: .finance)
                    lessonList(bigCategory: "投資", categoryLessonData: lessonInvestmentData, deatilCategories: investmentDetails, categoryDetail: .investment)
                }
            }
        }
    }
    
    func lessonList(bigCategory: String, categoryLessonData: [LessonData], deatilCategories:[DetailCategory], categoryDetail: CategoryDetail) -> some View {
        VStack(spacing: 5){
            NavigationLink {
                SearchCategoryDetailView(lessonsData: categoryLessonData, detailCategories: deatilCategories, mainCategory: categoryDetail)
            } label: {
                HStack{
                    Text(bigCategory).foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                    Image(systemName: "chevron.right").resizable().frame(width:10, height:13).foregroundColor(.gray).font(.largeTitle.weight(.bold))
                    Spacer()
                }
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(categoryLessonData) { lesson in
                        NavigationLink {
                            OneClassDetailView(lessonImageURLString: lesson.lessonImageURLString, mentorIconImageURLString: lesson.userImageIconURLString, lessonId: lesson.lessonId, mentorName: lesson.username, mentorUid: lesson.mentorUid, lessonTitle: lesson.lessonName, lessonContent: lesson.lessonContent, budgets: lesson.budget)
                        } label: {
                            OneClassView(lessonImageURLString: lesson.lessonImageURLString, lessonName: lesson.lessonName, userIconURLString: lesson.userImageIconURLString, lessonBudgets: lesson.budget)
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }.padding(.top,16)
    }
}


struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView(lessonData: [], lessonEnglishData: [], lessonComputerData: [], lessonLawData: [], lessonFinanceData: [], lessonInvestmentData: [])
    }
}
