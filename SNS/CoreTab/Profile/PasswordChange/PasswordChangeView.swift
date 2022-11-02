//
//  PasswordChangeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import SwiftUI

struct PasswordChangeView: View {
    @State var oldPasswordField: String
    @State var newPasswordField: String
    @State var newConfirmationPasswordTextFIeld: String
    
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
                TextField("古いパスワード", text: $oldPasswordField).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16).padding(.top,16)
                TextField("新しいパスワード", text: $newPasswordField).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                TextField("新しいパスワード(確認)", text: $newConfirmationPasswordTextFIeld).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                Spacer()
            }.navigationTitle("パスワードを変更").navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView(oldPasswordField: "", newPasswordField: "", newConfirmationPasswordTextFIeld: "")
    }
}
