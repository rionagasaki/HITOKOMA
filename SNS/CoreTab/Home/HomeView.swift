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
    @State private var selection = 0
    @State private var items = ["ホーム","リクエスト","英語"]
    @State var searchWord: String = ""
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
    
    var body: some View {
        VStack{
            TabBarSliderView()
            TabView(selection: $selection) {
                ForEach(0..<3, id: \.self){ index in
                    if index == 0 {
                        MainHomeView(lessonData: lessonData, lessonEnglishData: lessonEnglishData, lessonComputerData: lessonComputerData, lessonLawData: lessonLawData, lessonFinanceData: lessonFinanceData, lessonInvestmentData: lessonInvestmentData)
                    }else if index == 1{
                        RequestHomeView(requestData: requestData, requestEnglishData: requestEnglishData, requestComputerData: requestComputerData, requestLawData: requestLawData, requestFinanceData: requestFinanceData, requestInvestmentData: requestInvestmentData)
                    }else if index == 2 {
                        Text("bbb")
                    }
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }.searchable(text: $searchWord).modifier(ToolBarviewModifier(selection: $selection, items: items)).navigationBarTitleDisplayMode(.inline)
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
