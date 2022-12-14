//
//  InquiryView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/21.
//

import SwiftUI

struct InquiryView: View {
    @State var nameFields:String = ""
    var body: some View {
        Form{
            InquiryHeaderView().padding(.top,10)
            Section {
                TextField("長崎理応", text: $nameFields)
            } header: {
                Text("お名前").foregroundColor(.black)
            }
            Section {
                TextField("naga_ri@icloud.com", text: $nameFields)
            } header: {
                Text("メールアドレス").foregroundColor(Color.black)
            }
            Section {
                TextEditor(text: $nameFields).frame(height:150)
            } header: {
                Text("お問い合わせ内容").foregroundColor(Color.black)
            }
            VStack{
                Button {
                    print("aaaa")
                } label: {
                    Text("送信する").foregroundColor(.white).font(.system(size: 17)).bold().frame(width: UIScreen.main.bounds.width-40, height: 50).background(Color.customBlue).cornerRadius(10).padding(.top, 10).padding(.horizontal,10).padding(.bottom, 20)
                }
            }
        }.navigationTitle("お問い合わせ").navigationBarTitleDisplayMode(.inline)
    }
}

struct InquiryView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryView()
    }
}
struct InquiryHeaderView: View {
    var body: some View {
        VStack{
            Text("お問い合わせの前にご確認ください。").fontWeight(.light).font(.system(size: 14)).padding(.bottom,10)
            Button {
                print("ok")
            } label: {
                Text("よくある質問").foregroundColor(Color.customBlue).font(.system(size: 16)).underline().padding(.bottom,10)
            }
        }.frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
    }
}

