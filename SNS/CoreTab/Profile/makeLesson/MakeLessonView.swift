//
//  makeLessonView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/03.
//

import SwiftUI

struct MakeLessonView: View {
    @State var requestMessage: String = ""
    var body: some View {
        VStack{
            VStack {
                VStack{
                    Image("rootImage").resizable().frame(width:70, height:70).clipShape(Circle())
                    Text("確認メールが送られます。")
                }.frame(width: UIScreen.main.bounds.width-100, height: 300).background(.white.opacity(0.1)).background(.ultraThinMaterial).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                TextEditor(text: $requestMessage).frame(height: 150).overlay(RoundedRectangle(cornerRadius: 5).stroke(.black, lineWidth: 0.5)).padding(.horizontal,16)
                TextField("aaa", text: $requestMessage).frame(width: UIScreen.main.bounds.width - 120).overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1))
            }
        }
    }
}

struct MakeLessonView_Previews: PreviewProvider {
    static var previews: some View {
        MakeLessonView()
    }
}
