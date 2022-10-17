//
//  SwiftUIView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/07.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName = ""
    private let screenWidth = UIScreen.main.bounds.width
    private var settings = [ Setting(settingName: "会員情報", settingImage: "person"), Setting(settingName: "パスワード変更", settingImage: "lock"), Setting(settingName: "メールアドレス変更", settingImage: "mail"), Setting(settingName: "マイリスト", settingImage: "list.bullet")]
    
    var body: some View {
        ZStack{
            ZStack{
                VStack(alignment:.leading ,spacing: 20){
                    BackgroundView(startColor: .green, endColor: .purple).frame(width: 300, height: 300)
                    BackgroundView(startColor: .purple, endColor: .orange).frame(width: 300, height: 300).rotation3DEffect(.degrees(Double(180)), axis: (x:0,y:0,z:1))
                }
                Color.init(uiColor:UIColor(displayP3Red: 40/255, green: 42/255, blue: 51/255, alpha: 1)).opacity(0.3).background(.ultraThinMaterial)
            }
            VStack{
                Form{
                    HeaderView()
                    Section {
                        FavoriteView()
                    } header: {
                        HStack{
                            Image(systemName: "heart.fill").foregroundColor(Color.red)
                            Text("お気に入りサブスク").foregroundColor(Color.white)
                        }
                    }
                    Section {
                        List(self.settings){ setting in
                            SettingCellView(setting: setting)
                        }
                    } header: {
                        Text("お客様情報").foregroundColor(Color.white)
                    }
                    Section {
                        List{
                            SettingCellView(setting: Setting(settingName: "通知設定", settingImage: "bell.badge"))
                        }
                    } header: {
                        Text("アプリ設定").foregroundColor(Color.white)
                    }
                    Section {
                        List{
                            SettingCellView(setting: Setting(settingName: "ヘルプ", settingImage: "questionmark.circle")).onTapGesture {
                                print("aaaa")
                            }
                            SettingCellView(setting: Setting(settingName: "お問い合わせ", settingImage: "envelope"))
                        }
                    } header: {
                        Text("サポート").foregroundColor(Color.white)
                    }
                    Section {
                        List{
                            SettingCellView(setting: Setting(settingName: "サービス内容", settingImage: "questionmark.circle"))
                            SettingCellView(setting: Setting(settingName: "利用規約", settingImage: "doc.text"))
                            SettingCellView(setting: Setting(settingName: "プライバシーポリシー", settingImage: "lock.shield"))
                            SettingCellView(setting: Setting(settingName: "著作権情報", settingImage: "lock.square.stack"))
                            SettingCellView(setting: Setting(settingName: "アカウント削除", settingImage: "person.fill.badge.minus"))
                            
                        }
                    } header: {
                        Text("このサービスについて").foregroundColor(Color.white)
                    }
                    
                    Button {
                        print("aaa")
                    } label: {
                        Text("ログアウト").foregroundColor(.red).padding(.leading, 115)
                    }
                }.onAppear{
                    UITableView.appearance().backgroundColor = .clear
                }
            }.padding(.top,20).padding(.bottom, 55)
        }.ignoresSafeArea()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
