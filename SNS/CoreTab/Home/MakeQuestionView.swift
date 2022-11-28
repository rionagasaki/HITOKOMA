//
//  MakeQuestionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/23.
//

import SwiftUI
import SDWebImageSwiftUI
import PKHUD

struct MakeQuestionView: View {
    
    let lessonImageURL:String
    let lessonTitle: String
    let lessonID: String
    let mentorIconImageURLString: String
    let mentorName: String
    @State var questionText: String = ""
    @State var buttonEnabled: Bool = false
    @FocusState var keyboardFocus
    var body: some View {
        VStack{
            VStack(alignment: .leading,spacing: 0){
                HStack(alignment: .top){
                    WebImage(url: URL(string: lessonImageURL)).resizable().frame(width: 70, height: 70).padding(.leading, 16)
                    VStack{
                        Text(lessonTitle).font(.system(size: 15)).bold()
                        HStack{
                            WebImage(url: URL(string: mentorIconImageURLString)).resizable().frame(width:20, height: 20).clipShape(Circle())
                            Text(mentorName)
                        }
                    }
                    Spacer()
                }.padding(.vertical, 20)
                Divider()
                Text("質問は他のユーザーに公開されます。").font(.caption).padding(.leading, 16).padding(.vertical, 16)
                Divider()
                HStack{
                    Image(systemName: "questionmark.square.fill").resizable().frame(width:20, height: 20)
                    Text("Question").bold().font(.system(size: 25)).foregroundColor(.init(uiColor: .darkGray).opacity(0.8))
                }.padding(.leading,16).padding(.top, 16)
                Text("質問文を入力してください。").font(.system(size: 15)).bold().padding(.leading, 16).padding(.top,7)
                TextEditor(text: $questionText).frame(width: UIScreen.main.bounds.width-32, height: 150).overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 2)).padding(.leading, 16).padding(.top,7).focused($keyboardFocus).onChange(of: questionText) { newValue in
                    print(newValue)
                }
            }
            VStack{
                Button {
                    SetToFirestore().registerQuestionToLesson(lessonId: lessonID, questionText: questionText){
                        HUD.flash(.success, delay: 1.0)
                    }
                } label: {
                    Text("質問する").foregroundColor(.white).bold().frame(width: UIScreen.main.bounds.width-40, height: 40).background(.black).cornerRadius(10)
                }.disabled(self.buttonEnabled)
            }
            Spacer()
        }.onTapGesture {
            self.keyboardFocus = false
        }
    }
}

struct MakeQuestionView_Previews: PreviewProvider {
    @State static var closed = false
    static var previews: some View {
        MakeQuestionView(lessonImageURL: "", lessonTitle: "", lessonID: "", mentorIconImageURLString: "", mentorName: "")
    }
}
