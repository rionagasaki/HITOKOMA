//
//  SwiftUIView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/07.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState:AppState
    @StateObject private var viewModel = ProfileViewModel()
    private let screenWidth = UIScreen.main.bounds.width
    
    private let baseSettings = [
        
       Setting(
        settingName: "プロフィール",
        settingImage: "person",
        handler: AnyView(
            UserProfileView()
        )
       ),
       
        Setting(
            settingName: "プロフィール編集",
            settingImage: "gear",
            handler: AnyView(
                MemberInfoView()
            )
        ),
        Setting(
            settingName: "パスワード変更",
            settingImage: "lock",
            handler:AnyView(
                PasswordChangeView()
            )
        ),
        Setting(
            settingName: "メールアドレス変更",
            settingImage: "mail",
            handler: AnyView(
                EmailChangeView()
            )
        ),
        Setting(
            settingName: "マイリスト",
            settingImage: "list.bullet",
            handler: AnyView(
                MyListView()
            )
        )
    ]
    
    private let sellerSettings = [
        Setting(
            settingName: "売上管理",
            settingImage: "personalhotspot.circle",
            handler:AnyView(
                WrappaerDashBoardCall()
            )
        ),
                                    
        Setting(
            settingName: "ひとこまを販売する",
            settingImage: "checkmark.seal",
            handler: AnyView(
                MakeLessonView()
            )
        )
    ]
    
    private let buyerSettings = [
        Setting(
            settingName: "リクエストする",
            settingImage: "hand.raised",
            handler: AnyView(
                MakeRequestView()
            )
        )
    ]
    
    private let applicationSetting = [
        Setting(
            settingName: "通知設定",
            settingImage: "bell.badge",
            handler: AnyView(
                SettingNotificationView()
            )
        )
    ]
    
    private let supportSettings = [
        Setting(
            settingName: "ヘルプ",
            settingImage: "questionmark.circle",
            handler: AnyView(
                HelpView()
            )
        ) ,
        Setting(
            settingName: "お問い合わせ",
            settingImage: "envelope",
            handler:AnyView(
                InquiryView()
            )
        )
    ]
    
    private let aboutService = [
        Setting(
            settingName: "サービス内容",
            settingImage: "questionmark.circle",
            handler: AnyView(
                AboutServiceView()
            )
        ),
        Setting(
            settingName: "利用規約",
            settingImage: "doc.text",
            handler: AnyView(
                TermsOfServiceView()
            )
        ),
        Setting(
            settingName: "プライバシーポリシー",
            settingImage: "lock.shield",
            handler: AnyView(
                PrivacypolicyView()
            )
        ),
        Setting(
            settingName: "オープンソースライセンス",
            settingImage: "lock.square.stack",
            handler: AnyView(
                OpenSourceLicenSeView()
            )
        ),
        Setting(
            settingName: "退会について",
            settingImage: "person.fill.badge.minus",
            handler:AnyView(
                WithdrawalView()
            )
        )
    ]
    
    var body: some View {
        ZStack{
            Form {
                HeaderView(
                    username: User.shared.username ,
                    userProfileImage: User.shared.profileImage
                )
                
                Section {
                    List(baseSettings){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("お客様情報")
                        .foregroundColor(Color.black.opacity(0.8))
                }
                Section {
                    List(sellerSettings){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("出品者")
                        .foregroundColor(Color.black.opacity(0.8))
                }
                
                Section {
                    List(buyerSettings){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("購入者")
                        .foregroundColor(Color.black.opacity(0.8))
                }
                
                Section {
                    List(applicationSetting){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("アプリ設定")
                        .foregroundColor(Color.black.opacity(0.8))
                }
                Section {
                    List(supportSettings){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("サポート")
                        .foregroundColor(Color.black.opacity(0.8))
                }
                Section {
                    List(aboutService){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("このサービスについて")
                        .foregroundColor(Color.black.opacity(0.8))
                }
                Button {
                    try? viewModel.signOut {
                        appState.isLogin = false
                    }
                } label: {
                    Text("ログアウト")
                        .foregroundColor(.customRed2)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }.onAppear{
                UITableView
                    .appearance()
                    .backgroundColor = .clear
            }
            .padding(.top,20)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
       ProfileView()
    }
}
