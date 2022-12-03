//
//  SettingNotificationView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/04.
//

import SwiftUI

struct SettingNotificationView: View {
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
                        Image(systemName: "bell.fill").resizable().scaledToFit().frame(width:100, height: 50).foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        Text("通知設定の手順は以下の通りです。")
                    }.frame(width: UIScreen.main.bounds.width-100, height: 300).background(.white.opacity(0.1)).background(.ultraThinMaterial).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                    Button {
                        print("aaaa")
                    } label: {
                        Text("設定を開く").bold().foregroundColor(.white)
                    }.frame(width:UIScreen.main.bounds.width-40, height: 40).background(.blue).cornerRadius(10).padding(.horizontal,20).padding(.top, 16)
                }.navigationTitle("通知設定").navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct SettingNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SettingNotificationView()
    }
}
