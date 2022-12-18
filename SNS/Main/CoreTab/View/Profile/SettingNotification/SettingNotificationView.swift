//
//  SettingNotificationView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/04.
//

import SwiftUI

struct SettingNotificationView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ScrollView {
                VStack{
                    Text("🔔通知設定").font(.system(size: 25)).bold().frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 16)
                    
                    VStack{
                        Text("通知変更").fontWeight(.light).font(.system(size: 23)).padding(.top, 20)
                        Text("講座の受講情報、メッセージ情報のために、プッシュ通知の設定をオンにしてください。").fontWeight(.light).font(.system(size: 14)).padding(.horizontal, 16).padding(.top, 5)
                        
                        Button {
                            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                               UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Text("設定を開く").foregroundColor(.white).font(.system(size: 17)).bold().frame(width: UIScreen.main.bounds.width-40, height: 50).background(Color.customBlue).cornerRadius(10).padding(.top, 10).padding(.horizontal,10).padding(.bottom, 20)
                        }
                    }.background(.white)
                }
            }
            DismissButtonView().padding(.leading, 40).padding(.bottom, 40)
        }.background(.ultraThinMaterial)
    }
}

struct SettingNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SettingNotificationView()
    }
}
