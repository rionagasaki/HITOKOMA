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
            Color.black.opacity(0.03).background(.ultraThinMaterial)
            VStack(alignment:.leading ,spacing: 20){
                Circle().size(width: 200, height: 200).blur(radius: 80).foregroundColor(.yellow)
                HStack{
                    Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.blue).padding(.top,-120)
                    Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.orange).padding(.top,30)
                }
                Circle().size(width: 200, height: 200).blur(radius: 100).foregroundColor(.pink)
            }
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

