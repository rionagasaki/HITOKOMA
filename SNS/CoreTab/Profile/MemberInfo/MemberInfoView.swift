//
//  MemberInfoView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/15.
//

import SwiftUI
import FirebaseFirestore

struct MemberInfoView: View {
    @State private var displayName:String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("プロフィール画像").padding(.leading, 16)
                    HStack{
                        Image("rootImage").resizable().frame(width: 80, height: 80).clipShape(Circle())
                        Spacer()
                    }.padding(.leading, 16)
                }
                Group{
                    Text("ユーザーネーム").padding(.leading, 16).padding(.top, 25)
                    TextField("", text: $displayName).padding(.all, 7).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                }
                Group{
                    Text("性別(任意)").padding(.leading, 16).padding(.top, 25)
                    TextField("", text: $displayName).padding(.all, 7).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                    Text("年齢(任意)").padding(.leading, 16).padding(.top, 25)
                    TextField("", text: $displayName).padding(.all, 7).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                    Text("SNSアカウント(任意)").padding(.leading, 16).padding(.top, 25)
                    TextField("", text: $displayName).padding(.all, 7).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                }
                Text("自己紹介").padding(.leading, 16).padding(.top, 25)
                TextEditor(text: $displayName).frame(height: 150).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                Group{
                    Text("スケジュール").padding(.leading, 16).padding(.top, 25)
                    TextEditor(text: $displayName).frame(height: 150).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                }
                Button{
                    print("")
                } label: {
                    Text("更新する")
                }
            }
        }.navigationTitle("会員情報").navigationBarTitleDisplayMode(.inline)
    }
}
struct MemberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoView()
    }
}
