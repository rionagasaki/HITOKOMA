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
    @EnvironmentObject var app: AppState
    @State private var selection = 1
    @State private var items = ["レッスン","ホーム","リクエスト"]
    
    var body: some View {
        VStack(spacing: .zero){
            CustomScrollView(selection: $selection).frame(height: 40)
            TabBarSliderView(width: 100.0, alignment: .top)
            TabView(selection: $selection) {
                ForEach(0..<3, id: \.self){ index in
                    if index == 0 {
                        Text("aa")
                    }else if index == 1{
                        MainHomeView()
                    }else if index == 2{
                        RequestHomeView()
                    }
                }
            }
            .padding(.top, 16)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct CustomScrollView: View {
    let menus = ["レッスン","ホーム","リクエスト"]
    @Binding var selection: Int
    @State var openNotification: Bool = false
    
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
                openNotification = true
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
                    .foregroundColor(.black)
            }.padding(.trailing,16)
        }
        .background(.ultraThinMaterial)
        .fullScreenCover(isPresented: $openNotification) {
            NotificationView()
        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
