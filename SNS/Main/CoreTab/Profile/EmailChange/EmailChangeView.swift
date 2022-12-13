//
//  EmailChangeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import SwiftUI

struct EmailChangeView: View {
    @Environment(\.dismiss) var dismiss
    @State var newEmailField: String
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ScrollView {
                VStack{
                    Text("📧メール設定").font(.system(size: 25)).bold().frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 16)
                    
                    VStack{
                        Text("メールアドレス変更").fontWeight(.light).font(.system(size: 23)).padding(.top, 20)
                        Text("登録したいメールアドレスを入力し、確認メールを送信してください。").fontWeight(.light).font(.system(size: 14)).padding(.horizontal, 16).padding(.top, 5)
                        TextField("", text: $newEmailField, prompt: Text("メールアドレス")).padding(.leading, 10).frame(height: 38).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2)).padding(.horizontal, 16).padding(.top, 5)
                        Button {
                            print("aaa")
                        } label: {
                            Text("確認メールを送信する").foregroundColor(.white).font(.system(size: 17)).bold().frame(width: UIScreen.main.bounds.width-40, height: 50).background(Color.customBlue).cornerRadius(10).padding(.top, 10).padding(.horizontal,10).padding(.bottom, 20)
                        }
                    }.background(.white)
                }
            }
            DismissButtonView().padding(.leading, 40).padding(.bottom, 40)
        }.background(.ultraThinMaterial)
    }
}

struct EmailChangeView_Previews: PreviewProvider {
    static var previews: some View {
        EmailChangeView(newEmailField: "")
    }
}
