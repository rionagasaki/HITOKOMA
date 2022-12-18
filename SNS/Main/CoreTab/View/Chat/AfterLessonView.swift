//
//  AfterLessonView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/28.
//

import SwiftUI

struct AfterLessonView: View {
    let lessonId: String
    @State var allSelection: Int
    @State var clearitySelection: Int
    @State var interestingSelection: Int
    @State var thoughtText: String = ""
    @FocusState var keyboardDismiss: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                Text("評価・レビューをつけて、取引を終了してください。").font(.subheadline).font(.system(size: 13))
            }.padding(.top, 10).padding(.leading, 10)
            Divider()
            Text("評価").bold().font(.system(size: 17)).padding(.leading, 10)
            StarView(selection: $allSelection, evalutionTitle: "総合評価", starSize: 25)
            StarView(selection: $clearitySelection, evalutionTitle: "わかりやすさ", starSize: 20)
            StarView(selection: $interestingSelection, evalutionTitle: "面白さ", starSize: 20)
            
            Text("レビュー").bold().font(.system(size: 17)).padding(.leading, 10)
            TextEditor(text: $thoughtText).frame(width: UIScreen.main.bounds.width-40, height: 100).background(Rectangle().stroke(.gray, lineWidth: 1)).padding(.leading, 16)
            
            Button {
                SetToFirestore().registerEvalutionToLesson(lessonId: lessonId, allEvalution: allSelection, easyToUnderstand: clearitySelection, interesting: interestingSelection, review: thoughtText) { lessonId in
                    UpdateFirestore().updateLessonCompletionUser(lessonId: lessonId){
                        dismiss()
                    }
                }
            } label: {
                Text("取引を終了する").foregroundColor(.white).bold().frame(width: UIScreen.main.bounds.width-40, height: 40).background(.black).cornerRadius(10).padding(.horizontal, 16).padding(.top, 10)
            }
            Divider()
        }.onTapGesture {
            self.keyboardDismiss = false
        }.background(.ultraThinMaterial).cornerRadius(10).padding()
    }
}

struct StarView: View {
    @Binding var selection: Int
    let evalutionTitle: String
    let starSize: CGFloat
    var body: some View{
        HStack(spacing: 2){
            Text(evalutionTitle).font(.caption).padding(.leading, 16)
            Spacer()
            ForEach(0..<5) { index in
                Button {
                    selection = index
                } label: {
                    if index <= selection{
                        Image(systemName: "star.fill").resizable().frame(width:starSize, height:starSize).foregroundColor(.orange)
                    }else{
                        Image(systemName: "star").resizable().frame(width:starSize, height:starSize).foregroundColor(.orange)
                    }
                }
            }
        }.padding(.trailing, 16)
    }
}

struct AfterLessonView_Previews: PreviewProvider {
    static var previews: some View {
        AfterLessonView(lessonId: "", allSelection: -1, clearitySelection: -1, interestingSelection: -1)
    }
}
