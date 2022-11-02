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
    
    private var baseSettings = [ Setting(settingName: "会員情報", settingImage: "person", handler: AnyView(MemberInfoView())), Setting(settingName: "パスワード変更", settingImage: "lock", handler:AnyView(PasswordChangeView(oldPasswordField: "", newPasswordField: "", newConfirmationPasswordTextFIeld: ""))), Setting(settingName: "メールアドレス変更", settingImage: "mail", handler: AnyView(EmailChangeView(oldEmailField: "", newEmailField: "", newConfirmationEmailTextFIeld: ""))), Setting(settingName: "マイリスト", settingImage: "list.bullet", handler: AnyView(WrappaerDashBoardCall()))
    ]
    
    private var sellerSettings = [  Setting(settingName: "売上管理", settingImage: "personalhotspot.circle", handler:AnyView(WrappaerDashBoardCall())),
                                    Setting(settingName: "ひとこまを販売する", settingImage: "checkmark.seal", handler: AnyView(ConnectAccountView()))
    ]
    
    private var supportSettings = [ Setting(settingName: "ヘルプ", settingImage: "questionmark.circle", handler: AnyView(InquiryView())) ,Setting(settingName: "お問い合わせ", settingImage: "envelope", handler:AnyView(InquiryView()))
    ]
    
    private var aboutService = [ Setting(settingName: "サービス内容", settingImage: "questionmark.circle", handler: AnyView(InquiryView())), Setting(settingName: "利用規約", settingImage: "doc.text", handler: AnyView(InquiryView())), Setting(settingName: "プライバシーポリシー", settingImage: "lock.shield", handler: AnyView(InquiryView())), Setting(settingName: "オープンソースライセンス", settingImage: "lock.square.stack", handler: AnyView(InquiryView())), Setting(settingName: "アカウント削除", settingImage: "person.fill.badge.minus", handler:AnyView(InquiryView()))
    ]
    
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
                        List(self.baseSettings){ setting in
                            NavigationLink {
                                setting.handler
                            } label: {
                                SettingCellView(setting: setting)
                            }
                        }
                    } header: {
                        Text("お客様情報").foregroundColor(Color.white)
                    }
                    Section {
                        List(self.sellerSettings){ setting in
                            NavigationLink {
                                setting.handler
                            } label: {
                                SettingCellView(setting: setting)
                            }
                        }
                    } header: {
                        Text("出品者").foregroundColor(Color.white)
                    }
                    Section {
                        List{
                            SettingCellView(setting: Setting(settingName: "通知設定", settingImage: "bell.badge", handler: AnyView(WrappaerDashBoardCall())))
                        }
                    } header: {
                        Text("アプリ設定").foregroundColor(Color.white)
                    }
                    Section {
                        List(self.supportSettings){ setting in
                            NavigationLink {
                                setting.handler
                            } label: {
                                SettingCellView(setting: setting)
                            }
                        }
                    } header: {
                        Text("サポート").foregroundColor(Color.white)
                    }
                    Section {
                        List(self.aboutService){ setting in
                            NavigationLink {
                                setting.handler
                            } label: {
                                SettingCellView(setting: setting)
                            }
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
