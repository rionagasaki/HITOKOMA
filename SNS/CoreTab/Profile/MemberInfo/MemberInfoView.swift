//
//  MemberInfoView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/15.
//

import SwiftUI
import FirebaseFirestore

struct MemberInfoView: View {
    @State var displayName:String
    @State var displayGender: String
    @State var displayAge: String
    @State var displaySNSAccount: String
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
                ZStack{
                    VStack(alignment: .center){
                        VStack{
                            Image(systemName: "person.badge.key.fill").resizable().scaledToFit().frame(width:100, height: 50).foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Text("確認メールが送られます。")
                        }.frame(width: UIScreen.main.bounds.width-100, height: 300).background(.white.opacity(0.1)).background(.ultraThinMaterial).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                        
                        VStack(alignment: .leading){
                            Text("プロフィール画像").padding(.leading, 16)
                            HStack{
                                Image("rootImage").resizable().frame(width: 80, height: 80).clipShape(Circle())
                                Spacer()
                            }.padding(.leading, 16)
                        }
                        Group{
                            Text("ユーザーネーム").padding(.leading, 16).padding(.top, 25)
                            TextField("ユーザーネーム", text: $displayName).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                        }
                        Group{
                            Text("性別(任意)").padding(.leading, 16).padding(.top, 25)
                            TextField("性別", text: $displayGender).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                            Text("年齢(任意)").padding(.leading, 16).padding(.top, 25)
                            TextField("年齢", text: $displayAge).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                            Text("SNSアカウント(任意)").padding(.leading, 16).padding(.top, 25)
                            TextField("SNSアカウント", text: $displaySNSAccount).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
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
                }
            }
        }.navigationTitle("会員情報").navigationBarTitleDisplayMode(.inline)
    }
}
struct MemberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoView(displayName: "", displayGender: "", displayAge: "", displaySNSAccount: "")
    }
}
