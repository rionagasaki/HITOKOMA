//
//  PasswordChangeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import SwiftUI

struct PasswordChangeView: View {
    @State var oldPasswordField: String
    @State var newPasswordField: String
    @State var newConfirmationPasswordTextFIeld: String
    
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
            ScrollView {
                VStack{
                    VStack{
                        Image(systemName: "person.badge.key.fill").resizable().scaledToFit().frame(width:100, height: 50).foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        Text("確認メールが送られます。")
                    }.frame(width: UIScreen.main.bounds.width-100, height: 300).background(.white.opacity(0.1)).background(.ultraThinMaterial).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                    
                    VStack(alignment: .leading){
                        Text("古いパスワード").font(.system(size: 14)).fontWeight(.regular).padding(.leading, 20)
                        TextField("", text: $oldPasswordField).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16)
                        Text("新しいパスワード").font(.system(size: 14)).fontWeight(.regular).padding(.leading, 20)
                        TextField("", text: $newPasswordField).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16)
                        Text("古いメールアドレス").font(.system(size: 14)).fontWeight(.regular).padding(.leading, 20)
                        TextField("", text: $newConfirmationPasswordTextFIeld).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16)
                        Button {
                            print("aaaa")
                        } label: {
                            Text("パスワードを変更する").bold().foregroundColor(.white)
                        }.frame(width:UIScreen.main.bounds.width-40, height: 40).background(.blue).cornerRadius(10).padding(.horizontal,20).padding(.top, 16)
                        Spacer()
                    }
                }.navigationTitle("パスワードを変更").navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView(oldPasswordField: "", newPasswordField: "", newConfirmationPasswordTextFIeld: "")
    }
}
