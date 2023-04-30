//
//  AboutServiceView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/03.
//

import SwiftUI

struct AboutServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text("ひとこまから始まる。\n学び、発見。")
                    .fontWeight(.heavy)
                    .font(.system(size: 25))
                    .padding(.leading, 16)
                    .padding(.top,16)
                
                Image(image.header.main_home.header_first)
                    .resizable()
                    .frame(
                        height:UIScreen.main.bounds.width-40
                    )
                    .padding(.top, 8)
                
            }
        }
        .navigationTitle("サービス内容")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AboutServiceView()
    }
}
