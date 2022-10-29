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
        ZStack{
            ZStack{
                VStack(alignment:.leading ,spacing: 20){
                    BackgroundView(startColor: .green, endColor: .purple).frame(width: 300, height: 300)
                    BackgroundView(startColor: .purple, endColor: .orange).frame(width: 300, height: 300).rotation3DEffect(.degrees(Double(180)), axis: (x:0,y:0,z:1))
                }
                Color.init(uiColor:UIColor(displayP3Red: 40/255, green: 42/255, blue: 51/255, alpha: 1)).opacity(0.3).background(.ultraThinMaterial)
            }.ignoresSafeArea()
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
                Button {
                    print("aaaa")
                } label: {
                    Text("送信する").bold().foregroundColor(Color.white)
                }.padding(.leading,120).listRowBackground(Color.blue)
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
            Text("お問い合わせの前にご確認ください。").padding(.bottom,10)
            Button {
                print("ok")
            } label: {
                Text("よくある質問").underline().padding(.bottom,10)
            }
        }
    }
}

