//
//  RequestDetailView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/06.
//

import SwiftUI
import SDWebImageSwiftUI

struct RequestDetailView: View {
    @State var username: String
    @State var profileImage: String
    @State var shouldShowModal: Bool
    @State var requestTitle: String
    @State var requestContents: String
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    ZStack(alignment: .topLeading){
                        WebImage(url: URL(string: profileImage)).resizable().frame(width: 50, height: 50).clipShape(Circle())
                        Image(systemName: "questionmark.circle.fill").resizable().frame(width: 20, height: 20).background(.white).foregroundColor(.black).cornerRadius(20)
                    }
                    Text(username).foregroundColor(.black).font(.system(size: 15))
                    Spacer()
                    Text("2022/11/7 13:00に作成").foregroundColor(.init(uiColor: .lightGray)).font(.system(size: 15)).padding(.trailing, 10)
                }.padding(.leading, 10)
                TabView{
                    Image("suit").resizable().frame(height: 300).tag(1)
                    Image("suit").resizable().frame(height: 300).tag(2)
                }.tabViewStyle(PageTabViewStyle()).indexViewStyle(.page(backgroundDisplayMode: .always)).frame(height: 300)
                VStack(alignment: .center){
                    Text(requestTitle).bold().foregroundColor(.black).font(.system(size: 25)).padding(.horizontal,5)
                    RequestInfoView()
                    Text(requestContents).foregroundColor(.black).font(.system(size: 18)).padding()
                }
                Spacer()
            }
            Button {
                self.shouldShowModal = true
            } label: {
                RichButton(buttonText: "提案する", buttonImage: "checkmark.square.fill")
            }
        }.sheet(isPresented: $shouldShowModal) {
            AdjustmentView()
        }.navigationTitle("リクエスト")
    }
}

struct RequestDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailView(username: "", profileImage: "rootImage", shouldShowModal: false, requestTitle: "", requestContents: "")
    }
}

struct RequestInfoView:View {
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "checkmark.square.fill").foregroundColor(.green)
                Text("予算:   1000円").foregroundColor(.black).font(.system(size: 15))
                Spacer()
            }.padding(.leading, 10)
            HStack{
                Image(systemName: "calendar.badge.clock.rtl").foregroundColor(.blue)
                Text("日時:   今すぐ").foregroundColor(.black).font(.system(size: 15))
            }.padding(.leading, 10)
            HStack{
                Image(systemName: "timer").foregroundColor(.orange)
                Text("時間:   1h").foregroundColor(.black).font(.system(size: 15))
            }.padding(.leading, 10)
        }.frame(width: UIScreen.main.bounds.width-40, height: 100).background(.white.opacity(0.1)).background(.ultraThinMaterial).cornerRadius(20)
    }
}
