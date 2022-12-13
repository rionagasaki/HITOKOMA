//
//  SwiftUIView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/07.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    let username:String
    let email: String
    let profileImage: String
    @EnvironmentObject var appState:AppState
    @EnvironmentObject var user: User
    private let screenWidth = UIScreen.main.bounds.width
    
    private let baseSettings = [ Setting(settingName: "会員情報", settingImage: "person", handler: AnyView(MemberInfoView(displayName: "", displayGender: "", displayAge: "", profileImageURLString: ""))), Setting(settingName: "パスワード変更", settingImage: "lock", handler:AnyView(PasswordChangeView(currentPasswordField: "", newPasswordField: "", newConfirmationPasswordTextFIeld: ""))), Setting(settingName: "メールアドレス変更", settingImage: "mail", handler: AnyView(EmailChangeView(newEmailField: ""))), Setting(settingName: "マイリスト", settingImage: "list.bullet", handler: AnyView(MyListView()))
    ]
    
    private let sellerSettings = [Setting(settingName: "売上管理", settingImage: "personalhotspot.circle", handler:AnyView(WrappaerDashBoardCall())),
                                    Setting(settingName: "ひとこまを販売する", settingImage: "checkmark.seal", handler: AnyView(MakeLessonView()))
    ]
    
    private let buyerSettings = [Setting(settingName: "リクエスト", settingImage: "hand.raised", handler: AnyView(MakeRequestView( requestTitle: "", requestContents: "", selectedDate: Date(), numberPicker: 0, period: "", bigCategory: "", selectedCategory: "", dropDownList:[])))]
    
    private let applicationSetting = [Setting(settingName: "通知設定", settingImage: "bell.badge", handler: AnyView(SettingNotificationView()))]
    
    private let supportSettings = [ Setting(settingName: "ヘルプ", settingImage: "questionmark.circle", handler: AnyView(HelpView())) ,Setting(settingName: "お問い合わせ", settingImage: "envelope", handler:AnyView(InquiryView()))
    ]
    
    private let aboutService = [ Setting(settingName: "サービス内容", settingImage: "questionmark.circle", handler: AnyView(InquiryView())), Setting(settingName: "利用規約", settingImage: "doc.text", handler: AnyView(InquiryView())), Setting(settingName: "プライバシーポリシー", settingImage: "lock.shield", handler: AnyView(InquiryView())), Setting(settingName: "オープンソースライセンス", settingImage: "lock.square.stack", handler: AnyView(InquiryView())), Setting(settingName: "退会について", settingImage: "person.fill.badge.minus", handler:AnyView(InquiryView()))
    ]
    
    var body: some View {
        ZStack{
            Form {
                HeaderView(username: user.username, userProfileImage: user.profileImage)
//                Section {
//                    FavoriteView()
//                } header: {
//                    HStack{
//                        Image(systemName: "heart.fill").foregroundColor(Color.red)
//                        Text("お気に入りなひとこま。").foregroundColor(Color.black)
//                    }
//                }
                Section {
                    List(self.baseSettings){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("お客様情報").foregroundColor(Color.black)
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
                    Text("出品者").foregroundColor(Color.black)
                }
                
                Section {
                    List(self.buyerSettings){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("購入者").foregroundColor(Color.black)
                }
                
                Section {
                    List(self.applicationSetting){ setting in
                        NavigationLink {
                            setting.handler
                        } label: {
                            SettingCellView(setting: setting)
                        }
                    }
                } header: {
                    Text("アプリ設定").foregroundColor(Color.black)
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
                    Text("サポート").foregroundColor(Color.black)
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
                    Text("このサービスについて").foregroundColor(Color.black)
                }
                Button {
                    try? Auth.auth().signOut()
                    self.appState.isLogin = false
                } label: {
                    Text("ログアウト").foregroundColor(.red).padding(.leading, 115)
                }
            }.onAppear{
                UITableView.appearance().backgroundColor = .clear
            }.padding(.top,20)
        }.ignoresSafeArea().navigationBarHidden(true)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
       ProfileView(username: "", email: "", profileImage: "")
    }
}
