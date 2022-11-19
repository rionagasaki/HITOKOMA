//
//  HomeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI


enum BuyOrSell: String, CaseIterable{
    case buy = "販売中"
    case sell = "リクエスト"
}

let englishDetails = [DetailCategory(categoryName: "TOEIC", categoryImage: "TOEIC"),DetailCategory(categoryName: "TOEFL", categoryImage: "TOEFL"),DetailCategory(categoryName: "英検", categoryImage: "EnglishTest")]

let computerDetails = [DetailCategory(categoryName: "基本/応用情報", categoryImage: "basicInformation"), DetailCategory(categoryName: "プログラミング", categoryImage: "programming"), DetailCategory(categoryName: "G/E資格", categoryImage: "AI")
]

let lawDetails = [DetailCategory(categoryName: "宅建", categoryImage: "law")]

let financeDetails = [DetailCategory(categoryName: "会計士", categoryImage: "accountant"), DetailCategory(categoryName: "簿記", categoryImage: "bookKeeping")]

let investmentDetails = [DetailCategory(categoryName: "株式取引", categoryImage: ""), DetailCategory(categoryName: "為替取引", categoryImage: ""), DetailCategory(categoryName: "資産運用", categoryImage: "")]


struct HomeView:View{
    @EnvironmentObject var user: User
    @State private var contentOffSet = CGFloat(0)
    @State var selectPicker: BuyOrSell = .buy
    let requestData: [RequestData]
    let requestEnglishData: [RequestData]
    let requestComputerData: [RequestData]
    let requestLawData: [RequestData]
    let requestFinanceData: [RequestData]
    let requestInvestmentData: [RequestData]
    let lessonData: [LessonData]
    let lessonEnglishData: [LessonData]
    let lessonComputerData: [LessonData]
    let lessonLawData: [LessonData]
    let lessonFinanceData: [LessonData]
    let lessonInvestmentData: [LessonData]
    
    let categories = [
        CategoryData(categoryName: "英会話", categoryImage: "English", category: .english),
        CategoryData(categoryName: "IT", categoryImage: "computer", category: .computer),
        CategoryData(categoryName: "法律", categoryImage: "study", category: .law),
        CategoryData(categoryName: "ファイナンス", categoryImage: "coffee", category: .finance),
        CategoryData(categoryName: "投資", categoryImage: "invest", category: .investment)]
    let screenSize = UIScreen.main.bounds.width
    var body: some View {
        ZStack(alignment: .topLeading){
            Image(systemName: "")
            ScrollView {
                VStack(alignment: .center){
                    GeometryReader{ geometry in
                        Image("header").resizable().foregroundColor(.red).frame(height: geometry.frame(in: .global).minY > 0 ? 270+geometry.frame(in: .global).minY:270).overlay(LinearGradient(colors: [.white.opacity(0), .white.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                            .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY:0).padding(.top,25)
                    }.frame(height:270)
                    
                    HStack{
                        Text("カテゴリー").foregroundColor(.black).bold().font(.system(size: 18)).padding()
                        Spacer()
                        Button {
                            print("aaaa")
                        } label: {
                            Text("もっと見る").font(.subheadline).foregroundColor(.purple)
                        }.padding(.trailing,20)
                    }
                    HStack {
                        ForEach(categories) { category in
                            NavigationLink {
                                switch category.category{
                                case .english: SearchCategoryDetailView(detailCategories: englishDetails, lessonsData: lessonEnglishData, mainCategory: .english)
                                case .computer: SearchCategoryDetailView(detailCategories: computerDetails, lessonsData: lessonComputerData, mainCategory: .computer)
                                case .law: SearchCategoryDetailView(detailCategories: lawDetails, lessonsData: lessonLawData, mainCategory: .law)
                                case .finance: SearchCategoryDetailView(detailCategories: financeDetails, lessonsData: lessonFinanceData, mainCategory: .finance)
                                case .investment: SearchCategoryDetailView(detailCategories: investmentDetails, lessonsData: lessonInvestmentData, mainCategory: .investment)
                                }
                            } label: {
                                Category(category: category)
                            }
                        }
                    }
                    Picker("",selection: $selectPicker) {
                        ForEach(BuyOrSell.allCases, id:\.self) {
                            want in
                            Text(want.rawValue).tag(want)
                        }
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16).padding(.vertical,7)
                    
                    if selectPicker == .buy {
                        VStack{
                            VStack{
                                HStack{
                                    Text("話題のひとこま").foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                                    Image(systemName: "questionmark.bubble.fill").foregroundColor(.gray)
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
                                }.padding(.horizontal, 16).padding(.vertical, 7)
                            }
                            lessonList(bigCategory: "英語", categoryLessonData: lessonEnglishData, deatilCategories: englishDetails, categoryDetail: .english)
                            lessonList(bigCategory: "IT", categoryLessonData: lessonComputerData, deatilCategories: computerDetails, categoryDetail: .computer)
                            lessonList(bigCategory: "法律", categoryLessonData: lessonLawData, deatilCategories: lawDetails, categoryDetail: .law)
                            lessonList(bigCategory: "ファイナンス", categoryLessonData: lessonFinanceData, deatilCategories: financeDetails, categoryDetail: .finance)
                            lessonList(bigCategory: "投資", categoryLessonData: lessonInvestmentData, deatilCategories: investmentDetails, categoryDetail: .investment)
                        }.padding(.top,13)
                    }else if selectPicker == .sell{
                        VStack{
                            requestList(bigCategory: "リクエスト", detailsCategory: requestData).padding(.top,13)
                            requestList(bigCategory: "英語", detailsCategory: requestEnglishData)
                            requestList(bigCategory: "IT", detailsCategory: requestComputerData)
                            requestList(bigCategory: "法律", detailsCategory: requestLawData)
                            requestList(bigCategory: "ファイナンス", detailsCategory: requestFinanceData)
                            requestList(bigCategory: "投資", detailsCategory: requestInvestmentData)
                        }
                    }
                }.padding(.bottom, 150)
            }.ignoresSafeArea()
        }.onAppear{
            let foregroundColor = UIColor.systemPurple.withAlphaComponent(0.6)
            let backgroundColor = UIColor.white
                   UISegmentedControl.appearance().selectedSegmentTintColor = foregroundColor
                   UISegmentedControl.appearance().backgroundColor = backgroundColor
                   UISegmentedControl.appearance().setTitleTextAttributes([
                       .foregroundColor: foregroundColor,
                   ], for: .normal)
                   
                   UISegmentedControl.appearance().setTitleTextAttributes([
                       .foregroundColor: UIColor.white,
                   ], for: .selected)
        }
    }
    
    func lessonList(bigCategory: String, categoryLessonData: [LessonData], deatilCategories:[DetailCategory], categoryDetail: CategoryDetail) -> some View {
        VStack{
            NavigationLink {
                SearchCategoryDetailView(detailCategories: deatilCategories, lessonsData: categoryLessonData, mainCategory: categoryDetail)
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
            }.padding(.horizontal, 16).padding(.vertical, 7)
        }
    }
    
    func requestList(bigCategory: String, detailsCategory:[RequestData]) -> some View {
        VStack{
            HStack{
                Text(bigCategory).foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Spacer()
                    ForEach(detailsCategory) { request in
                        NavigationLink {
                            RequestDetailView(username: request.username, profileImage: request.userImageIconURL, shouldShowModal: false, requestTitle: request.requestName, requestContents: request.requestContent)
                        } label: {
                            OneRequestView(requestImage: request.userImageIconURL, requestTitle: request.requestName)
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }
    }
}

struct HomeHeaderView: View {
    var body: some View{
        ZStack{
            Image("header").resizable().frame(width: UIScreen.main.bounds.width-20, height: 200).overlay(LinearGradient(colors: [.white.opacity(0), .white.opacity(0.5)], startPoint: .top, endPoint: .bottom).offset(y:30))
            
        }.padding(.top,50)
    }
}


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(requestData: [], requestEnglishData: [], requestComputerData: [], requestLawData: [], requestFinanceData: [], requestInvestmentData: [], lessonData: [], lessonEnglishData: [], lessonComputerData: [], lessonLawData: [], lessonFinanceData: [], lessonInvestmentData: [])
    }
}

