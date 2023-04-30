//
//  RequestHomeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/23.
//

import SwiftUI

struct RequestHomeView: View {
    @StateObject private var viewModel = RequestHomeViewModel()
    @State var visibleRequestBanner: Bool = true
    
    var body: some View {
        ScrollView{
            VStack(spacing: .zero){
                ZStack(alignment: .top){
                    Image(R.image.images.header.request_home.request_header_background)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width-30,height:200)
                        .scaledToFit()
                    VStack{
                        Text("得意なことを教え始めよう")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .font(.system(size: 24))
                            .padding(.top, 8)
                        Image(R.image.images.header.request_home.request_header)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .scaledToFit()
                            .padding(.top, 8)
                        Spacer()
                        Button {
                        } label: {
                            Text("提案する")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .bold()
                                .frame(width: UIScreen.main.bounds.width-64, height: 40)
                                .background(Color.customBlue)
                                .cornerRadius(16)
                                .padding(.bottom, 16)
                        }
                    }
                }
                .cornerRadius(16)
                .padding(.top, 16)
                if visibleRequestBanner {
                    ZStack(alignment: .topLeading){
                        NavigationLink {
                            MakeRequestView()
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: [.customRed1, .customRed2], startPoint: .leading, endPoint: .trailing))
                                .frame(width: UIScreen.main.bounds.width-25, height: 50)
                                .overlay(content: {
                                    Text("レッスンをリクエストしますか？")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                })
                                .padding(.top, 16)
                        }
                        Button(action: {
                            withAnimation {
                                visibleRequestBanner = false
                            }
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width:24, height: 24)
                                .foregroundColor(.black.opacity(0.8))
                                .scaledToFit()
                                .background(.white)
                                .clipShape(Circle())
                        })
                        .padding(.top, 8)
                        .padding(.leading, -8)
                    }
                }
                requestList(bigCategory: "リクエスト一覧", detailsCategory: viewModel.requestData)
                requestList(bigCategory: "英語", detailsCategory: viewModel.requestEnglishData)
                requestList(bigCategory: "IT", detailsCategory: viewModel.requestComputerData)
                requestList(bigCategory: "法律", detailsCategory: viewModel.requestLawData)
                requestList(bigCategory: "ファイナンス", detailsCategory: viewModel.requestFinanceData)
                requestList(bigCategory: "投資", detailsCategory: viewModel.requestInvestmentData)
            }
        }
    }
    private func requestList(bigCategory: String, detailsCategory:[RequestData]) -> some View {
        VStack{
            HStack{
                Text(bigCategory)
                    .foregroundColor(.black)
                    .bold()
                    .font(.system(size: 20))
                    .padding(.leading,16)
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width:10, height:13)
                    .foregroundColor(.gray)
                    .font(.largeTitle.weight(.bold))
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Spacer()
                    ForEach(detailsCategory) { request in
                        NavigationLink {
                            RequestDetailView(request: request)
                        } label: {
                            OneRequestView(request: request)
                        }
                    }
                }
            }.padding(.horizontal, 16)
        }.padding(.top, 16)
    }
}

struct RequestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RequestHomeView()
    }
}
