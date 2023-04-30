//
//  DraftView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/19.
//

import SwiftUI

struct DraftView: View {
    var body: some View {
        List(0..<5) { _ in
            NavigationLink {
                MakeRequestView()
            } label: {
                OneDraftView()
            }
        }
    }
}

struct DraftView_Previews: PreviewProvider {
    static var previews: some View {
        DraftView()
    }
}

struct OneDraftView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("タイトル")
                .fontWeight(.medium)
                .font(.system(size: 16))
            Text("この講座を開講する予定でした。")
                .fontWeight(.light)
                .font(.system(size: 12))
            HStack {
                Spacer()
                Text("13:06分作成")
                    .fontWeight(.light)
                    .font(.system(size: 10))
            }
            .padding(.trailing, 16)
            .foregroundColor(.gray)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
    }
}
