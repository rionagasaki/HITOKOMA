//
//  RequestHomeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/23.
//

import SwiftUI

struct RequestHomeView: View {
    
    let requestData: [RequestData]
    let requestEnglishData: [RequestData]
    let requestComputerData: [RequestData]
    let requestLawData: [RequestData]
    let requestFinanceData: [RequestData]
    let requestInvestmentData: [RequestData]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                TabView {
                    Image("requestHome").resizable()
                    Image("requestHome").resizable()
                }.tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }.frame(width: UIScreen.main.bounds.width-60,height:200).cornerRadius(15).padding(.top,15).shadow(radius: 10)
            
            VStack{
                requestList(bigCategory: "リクエスト一覧", detailsCategory: requestData)
                requestList(bigCategory: "英語", detailsCategory: requestEnglishData)
                requestList(bigCategory: "IT", detailsCategory: requestComputerData)
                requestList(bigCategory: "法律", detailsCategory: requestLawData)
                requestList(bigCategory: "ファイナンス", detailsCategory: requestFinanceData)
                requestList(bigCategory: "投資", detailsCategory: requestInvestmentData)
            }
        }
    }
    func requestList(bigCategory: String, detailsCategory:[RequestData]) -> some View {
        VStack{
            HStack{
                Text(bigCategory).foregroundColor(.black).bold().font(.system(size: 20)).padding(.leading,16)
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

struct RequestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RequestHomeView(requestData: [], requestEnglishData: [], requestComputerData: [], requestLawData: [], requestFinanceData: [], requestInvestmentData: [])
    }
}
