//
//  PrivacypolicyView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/25.
//

import SwiftUI

struct PrivacypolicyView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ScrollView {
                VStack{
                    Text("プライパシーポリシー")
                        .font(.system(size: 25))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    
                    VStack{
                        Text("プライバシーポリシー")
                            .fontWeight(.light)
                            .font(.system(size: 23))
                            .padding(.top, 20)
                        Text("プライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシープライバシーポリシー")
                            .fontWeight(.light)
                            .font(.system(size: 14))
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                            .padding(.bottom, 16)
                    }.background(.white)
                }
            }
            DismissButtonView().padding(.leading, 40).padding(.bottom, 40)
        }.background(.ultraThinMaterial)
    }
}

struct PrivacypolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacypolicyView()
    }
}
