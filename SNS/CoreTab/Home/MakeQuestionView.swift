//
//  MakeQuestionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MakeQuestionView: View {
    let lessonImageURL:String
    let lessonTitle: String
    let lessonID: String
    @State var questionText: String = ""
    var body: some View {
        VStack{
            VStack(alignment: .leading,spacing: 0){
                HStack{
                    WebImage(url: URL(string: lessonImageURL)).resizable().frame(width: 70, height: 70).padding(.leading, 16).padding(.vertical, 20)
                    Text(lessonTitle).bold()
                    Spacer()
                }
                Divider()
                HStack{
                    Image(systemName: "questionmark.square.fill").resizable().frame(width:20, height: 20)
                    Text("Question").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                }.padding(.leading,16).padding(.top, 16)
                Text("質問文を入力してください。").font(.system(size: 15)).bold().padding(.leading, 16).padding(.top,7)
                TextEditor(text: $questionText).frame(width: UIScreen.main.bounds.width-32, height: 200).overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 2)).padding(.leading, 16).padding(.top,7)
                Spacer()
            }
            VStack{
                Button {
                    SetToFirestore().registerQuestionToLesson(lessonId: lessonID, questionText: questionText)
                } label: {
                    RichButton(buttonText: "質問する", buttonImage: "")
                }
            }
        }
    }
}

struct MakeQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        MakeQuestionView(lessonImageURL: "", lessonTitle: "", lessonID: "")
    }
}
