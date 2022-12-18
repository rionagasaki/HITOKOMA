//
//  RequestDetailView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI
import SDWebImageSwiftUI

struct RequestDetailView: View {
    let request: RequestData
    @State var shouldShowModal: Bool = false
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    TabView{
                        ForEach(request.requestImage.indices, id: \.self) { index in
                            WebImage(url: URL(string: request.requestImage[index]))
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: 250)
                                .scaledToFit()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                    .frame(height: 250)
                    
                    HStack{
                        WebImage(url: URL(string: request.userImageIconURL))
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                        Text(request.username)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                        Spacer()
                        Text("2022/11/7 13:00に作成")
                            .fontWeight(.light)
                            .foregroundColor(.init(uiColor: .lightGray))
                            .font(.system(size: 12))
                            .padding(.trailing, 16)
                    }
                    .padding(.leading, 16)
                    
                    VStack(alignment: .center, spacing: .zero){
                        Text(request.requestName)
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                            .padding(.horizontal,8)
                        
                        RequestInfoView(request: request)
                        
                        Text(request.requestContent)
                            .foregroundColor(.black.opacity(0.8))
                            .font(.system(size: 15))
                            .padding()
                    }
                    Spacer()
                }
                
            }.sheet(isPresented: $shouldShowModal) {
                AdjustmentView()
            }
            Button {
                self.shouldShowModal = true
            } label: {
                Text("提案画面へ")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width-32, height: 50)
                    .background(Color.customBlue)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
            }.background(.ultraThinMaterial)
        }
    }
}

struct RequestInfoView:View {
    let request: RequestData
    var body: some View{
        VStack(alignment: .leading){
            requestInfoFactory(systemImage: "checkmark.square.fill", title: "予算:", info: "\(request.budget)円", color: .green)
            requestInfoFactory(systemImage: "calendar.badge.clock.rtl", title: "日時:", info: request.period, color: .customBlue)
            requestInfoFactory(systemImage: "timer", title: "時間:", info: request.period, color: .customRed2)
        }
        .frame(width: UIScreen.main.bounds.width-80, height: 100)
        .background(.white.opacity(0.1))
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
    
    private func requestInfoFactory(systemImage: String, title: String, info: String, color: Color) -> some View {
        HStack(spacing: .zero){
            Image(systemName: systemImage)
                .resizable()
                .frame(width:16, height:16)
                .foregroundColor(color)
                .padding(.leading, 8)
            Text(title)
                .fontWeight(.regular)
                .foregroundColor(.black.opacity(0.8))
                .font(.system(size: 12))
                .padding(.leading, 5)
            Spacer()
            Text(info)
                .fontWeight(.regular)
                .foregroundColor(.black.opacity(0.8))
                .font(.system(size: 12))
                .padding(.trailing, 8)
        }
        .padding(.leading, 10)
    }
}

