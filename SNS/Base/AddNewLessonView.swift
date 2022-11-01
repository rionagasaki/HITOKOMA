//
//  SwiftUIView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/31.
//

import SwiftUI

struct AddNewLessonView: View {
    var body: some View {
        ZStack{
            VStack(alignment:.leading ,spacing: 20){
                Circle().size(width: 200, height: 200).foregroundColor(.yellow)
                HStack{
                    Circle().size(width: 200, height: 200).foregroundColor(.blue).padding(.top,-120)
                    Circle().size(width: 200, height: 200).foregroundColor(.orange).padding(.top,30)
                }
                BackgroundView(startColor: .purple, endColor: .orange).frame(width: 300, height: 300).blur(radius: 40).rotation3DEffect(.degrees(Double(180)), axis: (x:0,y:0,z:1))
            }.blur(radius: 40)
            VStack{
               Spacer()
                    IntroduceView(mainTitle: "出品者情報の登録が必要です。", describeText: "ひとこまで、出品するためには口座情報の登録が必要になります。以下の出品ボタンより、アカウントを作成してください。", describeImage: "talk")
                Spacer()
                Button {
                } label: {
                    RichButton(buttonText: "出品", buttonImage: "arrowshape.turn.up.right.fill").padding().shadow(radius: 20, x: 20, y: 20).shadow(color: .white, radius: 20, x: -10, y: -10)
                }
            }
        }.ignoresSafeArea(edges: .top)
    }
}
    
    
    struct AddNewLesson_Previews: PreviewProvider {
        static var previews: some View {
            AddNewLessonView()
        }
    }
