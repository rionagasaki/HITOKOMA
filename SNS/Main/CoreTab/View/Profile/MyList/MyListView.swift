//
//  MyListView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/11.
//

import SwiftUI

struct MyListView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text("レッスン予定")
                Text("やり取り中のレッスン")
                    .font(.system(size: 18))
                    .bold()
                    .padding(.leading, 16)
                    .padding(.top, 8)
                Divider()
                Text("お気に入り")
                    .font(.system(size: 18))
                    .bold()
                    .padding(.leading, 16)
                    .padding(.top, 8)
                Divider()
                Spacer()
            }
        }
        .navigationTitle("マイリスト")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
    }
}
