//
//  SwiftUIView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/07.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var firstName = ""
    @EnvironmentObject var appState:AppState
    private let screenWidth = UIScreen.main.bounds.width
    private var settings = [ Setting(settingName: "会員情報", settingImage: "person", handler: {}), Setting(settingName: "パスワード変更", settingImage: "lock", handler:{}), Setting(settingName: "メールアドレス変更", settingImage: "mail", handler: {}), Setting(settingName: "マイリスト", settingImage: "list.bullet", handler: {})]
    
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
            VStack{
                Form{
                    HeaderView()
                    Section {
                        FavoriteView()
                    } header: {
                        HStack{
                            Image(systemName: "heart.fill").foregroundColor(Color.red)
                            Text("お気に入りなひとこま。").foregroundColor(Color.white)
                        }
                    }
                    Section {
                        List(self.settings){ setting in
                            NavigationLink {
                                InquiryView()
                            } label: {
                                SettingCellView(setting: setting)
                            }
                        }
                    } header: {
                        Text("お客様情報").foregroundColor(Color.white)
                    }
                    Section {
                        List{
                            SettingCellView(setting: Setting(settingName: "通知設定", settingImage: "bell.badge", handler:{
                                
                            }))
                        }
                    } header: {
                        Text("アプリ設定").foregroundColor(Color.white)
                    }
                    Section {
                        List{
                            SettingCellView(setting: Setting(settingName: "ヘルプ", settingImage: "questionmark.circle", handler: {
                                
                            })).onTapGesture {
                                print("aaaa")
                            }
                            SettingCellView(setting: Setting(settingName: "お問い合わせ", settingImage: "envelope", handler: {
                                
                            }))
                        }
                    } header: {
                        Text("サポート").foregroundColor(Color.white)
                    }
                    Section {
                        List{
                            SettingCellView(setting: Setting(settingName: "サービス内容", settingImage: "questionmark.circle", handler: {
                                
                            }))
                            SettingCellView(setting: Setting(settingName: "利用規約", settingImage: "doc.text", handler: {
                                
                            }))
                            SettingCellView(setting: Setting(settingName: "プライバシーポリシー", settingImage: "lock.shield", handler: {
                                
                            }))
                            SettingCellView(setting: Setting(settingName: "著作権情報", settingImage: "lock.square.stack", handler: {
                                
                            }))
                            SettingCellView(setting: Setting(settingName: "アカウント削除", settingImage: "person.fill.badge.minus", handler: {
                                
                            }))
                            
                        }
                    } header: {
                        Text("このサービスについて").foregroundColor(Color.white)
                    }
                    
                    Button {
                        try? Auth.auth().signOut()
                        appState.isLogin = false
                    } label: {
                        Text("ログアウト").foregroundColor(.red).padding(.leading, 115)
                    }
                }.onAppear{
                    UITableView.appearance().backgroundColor = .clear
                }
            }.padding(.top,20).padding(.bottom, 55)
        }.ignoresSafeArea().navigationBarHidden(true)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
