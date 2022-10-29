//
//  SettingView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/18.
//

import SwiftUI

struct SettingView: View {
    private var settings = [ Setting(settingName: "名前変更", settingImage: "person", handler: {}), Setting(settingName: "パスワード変更", settingImage: "lock", handler: {}), Setting(settingName: "メールアドレス変更", settingImage: "mail", handler: {}), Setting(settingName: "マイリスト", settingImage: "list.bullet", handler: {})]
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section {
                        List(self.settings){ setting in
                            SettingCellView(setting: setting)
                        }
                    } header: {
                        Text("アカウント情報")
                    }
                    Section {
                        List(self.settings){ setting in
                            SettingCellView(setting: setting)
                        }
                    } header: {
                        Text("サポート")
                    }
                    Section {
                        List(self.settings){ setting in
                            SettingCellView(setting: setting)
                        }
                    } header: {
                        Text("このサービスについて")
                    }
                    Section {
                        List(self.settings){ setting in
                            SettingCellView(setting: setting)
                        }
                    } header: {
                        Text("アカウント情報")
                    }
                }
            }.navigationTitle("設定")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
