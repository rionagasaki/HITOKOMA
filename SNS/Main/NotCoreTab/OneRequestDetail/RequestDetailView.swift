//
//  RequestDetailView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI
import SDWebImageSwiftUI
import PartialSheet

struct RequestDetailView: View {
    let request: RequestData
    @State var shouldShowModal: Bool = false
    @Environment (\.dismiss) private var dismiss
    var body: some View {
        VStack {
            ScrollView {
                VStack{
                    
                    RequestHeaderView(request: request)
                    Text("希望条件")
                        .bold()
                        .padding(.leading, 16)
                        .padding(.top, 8)
                   
                    RequestInfoView(request: request)
                        .padding()
                    Divider()
                    Text("質問内容")
                        .bold()
                        .padding(.leading, 16)
                        .padding(.top, 8)
                    Text(request.requestContent)
                        .foregroundColor(.black.opacity(0.8))
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    Divider()
                }
                Spacer()
            }
            
        }.partialSheet(
            isPresented: $shouldShowModal,
            type: .scrollView(height: UIScreen.main.bounds.height/2, showsIndicators: false)
        ) {
            SuggestOnRequestView(viewModel: SuggestOnRequestViewModel(requestData: request))
        }
        
        HStack {
            
            DismissButtonView()
                .padding(.top, 16)
                .padding(.leading, 16)
            
            Button {
                shouldShowModal = true
            } label: {
                Text("提案画面へ")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width:UIScreen.main.bounds.width-76 ,height: 50)
                    .background(Color.customBlue)
                    .cornerRadius(10)
                    .padding(.leading,8)
                    .padding(.trailing,16)
            }
            .padding(.top, 16)
        }
        .background(.ultraThinMaterial)
        .navigationBarHidden(true)
    }
}


struct RequestInfoView:View {
    let request: RequestData
    var body: some View{
        VStack(alignment: .leading){
            requestInfoFactory(
                systemImage: "checkmark.square.fill",
                title: "予算:",
                info: "\(request.budget)円",
                color: .green)
            requestInfoFactory(
                systemImage: "calendar.badge.clock.rtl",
                title: "日時:",
                info: request.period,
                color: .customBlue)
            requestInfoFactory(
                systemImage: "timer",
                title: "時間:",
                info: request.period,
                color: .customRed2)
        }
        .frame(width: UIScreen.main.bounds.width-200, height: 100)
        .background(.white.opacity(0.1))
        .background(.ultraThinMaterial)
        .cornerRadius(10)
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

struct PreRequestChatView: View {
    let messageListData: MessageListData
    @ObservedObject var chatRoomType = ChatRoomType(chatMode: .student, messageListStyle: .beforePurchaseChat)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("事前チャット")
                .bold()
                .padding(.leading, 16)
            Text("*事前に条件を確認しましょう")
                .font(.caption)
                .padding(.leading, 16)
            NavigationLink {
                ChatView(
                    viewModel: ChatViewModel(
                        chatRoomId: <#T##String#>,
                        chatRoomType: .init(chatMode: .mentor, messageListStyle: .beforePurchaseChat)))
            } label: {
                HStack{
                    Text("事前前チャットはこちら")
                        .font(.system(size: 13))
                        .foregroundColor(Color.customBlue)
                        .bold()
                    Spacer()
                }
                .padding(.leading, 16)
            }
        }
    }
}


struct RequestHeaderView: View {
    let request: RequestData
    var body: some View {
        VStack {
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
            
            VStack(alignment: .leading, spacing: .zero){
                Text(request.requestName)
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                    .padding(.horizontal,8)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                Divider()
                
                HStack{
                    WebImage(url: URL(string: request.userImageIconURL))
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(request.username)
                        .bold()
                        .foregroundColor(.black)
                    Spacer()
                    Text("2022/11/7 13:00に作成")
                        .fontWeight(.light)
                        .foregroundColor(.init(uiColor: .lightGray))
                        .font(.system(size: 12))
                        .padding(.trailing, 16)
                }
                .padding(.leading, 16)
                .padding(.vertical, 8)
                
                Divider()
            }
        }
    }
}


