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

struct HomeView:View{
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
    
    let categories = [CategoryData(categoryName: "英会話", categoryImage: "English", handler: AnyView(EnglishView())), CategoryData(categoryName: "IT", categoryImage: "computer", handler: AnyView(InquiryView())), CategoryData(categoryName: "法律", categoryImage: "study", handler: AnyView(InquiryView())), CategoryData(categoryName: "ファイナンス", categoryImage: "coffee", handler: AnyView(InquiryView())), CategoryData(categoryName: "投資", categoryImage: "invest", handler: AnyView(InquiryView()))]
    let screenSize = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center){
                    GeometryReader{ geometry in
                        Image("header").resizable().foregroundColor(.red).frame(height: geometry.frame(in: .global).minY > 0 ? 270+geometry.frame(in: .global).minY:270).overlay(LinearGradient(colors: [.white.opacity(0), .white.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                            .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY:0).padding(.top,25)
                    }.frame(height:270)
                    
                    HStack{
                        Text("カテゴリー").foregroundColor(.black).bold().font(.system(size: 18)).padding()
                        Spacer()
                    }
                    HStack {
                        ForEach(categories) { category in
                            NavigationLink {
                                category.handler
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
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16).padding(.top,10)
                    
                    if selectPicker == .buy {
                        VStack{
                            VStack{
                                HStack{
                                    Text("話題のひとこま").foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                                    Spacer()
                                }
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        ForEach(lessonData) { lesson in
                                            NavigationLink {
                                                OneClassDetailView(lessonImageURLString: lesson.lessonImageURLString, mentorIconImageURLString: lesson.userImageIconURLString, mentorName: lesson.username, lessonTitle: lesson.lessonName, lessonContent: lesson.lessonContent, budgets: lesson.budget)
                                            } label: {
                                                OneClassView(lessonImageURLString: lesson.lessonImageURLString, lessonName: lesson.lessonName, userIconURLString: lesson.userImageIconURLString, lessonBudgets: lesson.budget)
                                            }
                                        }
                                    }
                                }.padding(.horizontal, 16).padding(.vertical, 7)
                            }
                            lessonList(bigCategory: "英語", categoryLessonData: lessonEnglishData)
                            lessonList(bigCategory: "IT", categoryLessonData: lessonComputerData)
                            lessonList(bigCategory: "法律", categoryLessonData: lessonLawData)
                            lessonList(bigCategory: "ファイナンス", categoryLessonData: lessonFinanceData)
                            lessonList(bigCategory: "投資", categoryLessonData: lessonInvestmentData)
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
            let font = UIFont(name: "AvenirNext-Medium", size: 16)!
            let foregroundColor = UIColor.systemPurple.withAlphaComponent(0.6)
            let backgroundColor = UIColor.white
                   UISegmentedControl.appearance().selectedSegmentTintColor = foregroundColor
                   UISegmentedControl.appearance().backgroundColor = backgroundColor
                   UISegmentedControl.appearance().setTitleTextAttributes([
                       .font: font,
                       .foregroundColor: foregroundColor,
                   ], for: .normal)
                   
                   UISegmentedControl.appearance().setTitleTextAttributes([
                       .font: font,
                       .foregroundColor: UIColor.white,
                   ], for: .selected)
        }
    }
    
    func lessonList(bigCategory: String, categoryLessonData: [LessonData]) -> some View {
        VStack{
            HStack{
                Text(bigCategory).foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                Image(systemName: "chevron.right").resizable().frame(width:10, height:13).foregroundColor(.gray).font(.largeTitle.weight(.bold))
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(categoryLessonData) { lesson in
                        NavigationLink {
                            OneClassDetailView(lessonImageURLString: lesson.lessonImageURLString, mentorIconImageURLString: lesson.userImageIconURLString, mentorName: lesson.username, lessonTitle: lesson.lessonName, lessonContent: lesson.lessonContent, budgets: lesson.budget)
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

