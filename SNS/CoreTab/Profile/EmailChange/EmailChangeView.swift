//
//  EmailChangeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import SwiftUI

struct EmailChangeView: View {
    
    @State var oldEmailField: String
    @State var newEmailField: String
    @State var newConfirmationEmailTextFIeld: String
    
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
                TextField("古いメールアドレス", text: $oldEmailField).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16).padding(.top,16)
                TextField("新しいメールアドレス", text: $newEmailField).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                TextField("新しいメールアドレス(確認)", text: $newConfirmationEmailTextFIeld).padding(.all, 7).background(.white).overlay(RoundedRectangle(cornerRadius: 5).stroke()).padding(.horizontal,16)
                Spacer()
            }.navigationTitle("メールアドレスを変更").navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EmailChangeView_Previews: PreviewProvider {
    static var previews: some View {
        EmailChangeView(oldEmailField: "", newEmailField: "", newConfirmationEmailTextFIeld: "")
    }
}
