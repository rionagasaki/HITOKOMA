//
//  WithdrawalView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/25.
//

import SwiftUI

struct WithdrawalView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ScrollView {
                VStack{
                    Text("🚶アカウント削除")
                        .font(.system(size: 25))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    VStack{
                        Text("アカウント削除について")
                            .fontWeight(.light)
                            .font(.system(size: 23))
                            .padding(.top, 20)
                        Text("アカウント削除すると、全てのアカウントデータに加えて、それにまつわる全てのレッスン情報、リクエスト情報、やり取りが削除されます。\nなお、一度アカウント削除すると、アカウントの復旧はできなくなります。")
                            .fontWeight(.light)
                            .font(.system(size: 14))
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                        Button {
                            print("aaa")
                        } label: {
                            Text("アカウントを削除する")
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .bold()
                                .frame(width: UIScreen.main.bounds.width-40, height: 50)
                                .background(Color.customRed2)
                                .cornerRadius(10)
                                .padding(.top, 10)
                                .padding(.horizontal,10)
                                .padding(.bottom, 20)
                        }
                    }.background(.white)
                }
            }
            DismissButtonView()
                .padding(.leading, 40)
                .padding(.bottom, 40)
        }.background(.ultraThinMaterial)
    }
}

struct WithdrawalView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawalView()
    }
}
