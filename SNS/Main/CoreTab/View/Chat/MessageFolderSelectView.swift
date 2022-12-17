//
//  MessageFolderSelectView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/08.
//

import SwiftUI

struct MessageFolderSelectView: View {
    @Binding var closeScreen: SelectableContentsType?
    var body: some View{
        VStack{
            Button {
                self.closeScreen = nil
            } label: {
                HStack{
                    Image(systemName: "xmark.square").resizable().frame(width: 20, height: 20).foregroundColor(.red)
                    Text("閉じる").foregroundColor(.black).bold().padding(.trailing, 20)
                }.frame(width: UIScreen.main.bounds.width-40, height: 40).background(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2)).background(.white.opacity(0.5)).cornerRadius(10).padding(.horizontal, 16).padding(.top, 10)
            }
        }
    }
}
