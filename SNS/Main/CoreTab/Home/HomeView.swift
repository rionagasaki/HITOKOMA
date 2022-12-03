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
    @State private var selection = 1
    @State private var items = ["レッスン","ホーム","リクエスト"]
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
            CustomScrollView(selection: $selection).frame(height: 30)
            TabBarSliderView(width: 100.0, alignment: .top)
            TabView(selection: $selection) {
                ForEach(0..<3, id: \.self){ index in
                    if index == 0 {
                        MainHomeView(lessonData: lessonData, lessonEnglishData: lessonEnglishData, lessonComputerData: lessonComputerData, lessonLawData: lessonLawData, lessonFinanceData: lessonFinanceData, lessonInvestmentData: lessonInvestmentData)
                    }else if index == 1{
                        MainHomeView(lessonData: lessonData, lessonEnglishData: lessonEnglishData, lessonComputerData: lessonComputerData, lessonLawData: lessonLawData, lessonFinanceData: lessonFinanceData, lessonInvestmentData: lessonInvestmentData)
                    }else if index == 2{
                        RequestHomeView(requestData: requestData, requestEnglishData: requestEnglishData, requestComputerData: requestComputerData, requestLawData: requestLawData, requestFinanceData: requestFinanceData, requestInvestmentData: requestInvestmentData)
                    }
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct CustomScrollView: View {
    let menus = ["レッスン","ホーム","リクエスト"]
    @Binding var selection: Int
    private let tabButtonSize: CGSize = CGSize(width: 100.0, height: 44.0)
    
    
    private func spacerWidth(_ viewOriginX: CGFloat) -> CGFloat {
        return (UIScreen.main.bounds.width - (viewOriginX * 2) - tabButtonSize.width) / 2
    }
    
    var body: some View{
        HStack{
            Button {
            } label: {
                Image(systemName: "line.horizontal.3.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:24.0, height: 24.0)
                    .foregroundColor(.black)
            }.padding(.leading,16)
            GeometryReader { geometryProxy in
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: .zero) {
                            Spacer()
                                .frame(width: spacerWidth(geometryProxy.frame(in: .global).origin.x))
                            ForEach(menus.reversed().indices, id: \.self) { index in
                                Button {
                                    selection = index
                                    withAnimation {
                                        scrollProxy.scrollTo(selection, anchor: .center)
                                    }
                                } label: {
                                    Text(menus[index])
                                        .font(.subheadline)
                                        .fontWeight(selection == index ? .semibold: .regular)
                                        .foregroundColor(selection == index ? .primary: .gray).padding(.bottom, 7)
                                        .id(index)
                                }
                                .frame(width: tabButtonSize.width, height: tabButtonSize.height)
                            }
                            Spacer()
                                .frame(width: spacerWidth(geometryProxy.frame(in: .global).origin.x))
                        }.onChange(of: selection) { _ in
                            withAnimation {
                                scrollProxy.scrollTo(selection, anchor: .center)
                            }
                        }.onAppear{
                            withAnimation {
                                scrollProxy.scrollTo(selection, anchor: .center)
                            }
                        }
                    }
                }
            }
            Button {
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
                    .foregroundColor(.black)
            }.padding(.trailing,16)
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
