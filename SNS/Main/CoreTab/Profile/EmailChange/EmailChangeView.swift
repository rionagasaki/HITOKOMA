//
//  EmailChangeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import SwiftUI

struct EmailChangeView: View {
    
    @State var oldEmailField: String
    @State var newEmailField: String
    @State var newConfirmationEmailTextFIeld: String
    
    var body: some View {
            ZStack{
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
                            Image(systemName: "mail.fill").resizable().scaledToFit().frame(width:100, height: 50).foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Text("確認メールが送られます。")
                        }.frame(width: UIScreen.main.bounds.width-100, height: 300).background(.white.opacity(0.1)).background(.ultraThinMaterial).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                        
                        VStack(alignment: .leading){
                            Text("古いメールアドレス").font(.system(size: 14)).fontWeight(.regular).padding(.leading, 20)
                            TextField("", text: $oldEmailField).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16)
                            Text("新しいメールアドレス").font(.system(size: 14)).fontWeight(.regular).padding(.leading, 20)
                            TextField("", text: $newEmailField).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,20)
                            Text("新しいメールアドレス(確認)").font(.system(size: 14)).fontWeight(.regular).padding(.leading, 20)
                            TextField("", text: $newConfirmationEmailTextFIeld).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,20)
                            Button {
                                print("aaaa")
                            } label: {
                                Text("メールアドレスを変更する").bold().foregroundColor(.white)
                            }.frame(width:UIScreen.main.bounds.width-40, height: 40).background(.blue).cornerRadius(10).padding(.horizontal,20).padding(.top, 16)
                            Spacer()
                        }
                    }.navigationTitle("メールアドレスを変更").navigationBarTitleDisplayMode(.inline)
                }
            }
    }
}

struct EmailChangeView_Previews: PreviewProvider {
    static var previews: some View {
        EmailChangeView(oldEmailField: "", newEmailField: "", newConfirmationEmailTextFIeld: "")
    }
}
