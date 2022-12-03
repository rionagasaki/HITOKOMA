//
//  MoreQuestionView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoreQuestionView: View {
    let questionRecords: [QuestionRecords]
    let mentorIcon: String
    let mentorName: String
    let lessonImageURL: String
    let lessonTitle: String
    let lessonID: String
    
    @State var openModal: Bool = false
    @Binding var dismiss: Bool
    
    var body: some View {
        VStack{
            List(questionRecords, id:\.self) { question in
                QuestionAndAnswearView(questionRecord: question, mentorIcon: mentorIcon)
            }
            Button {
                self.openModal = true
            } label: {
                Text("出品者に質問する").foregroundColor(.white).bold().frame(width: UIScreen.main.bounds.width-40, height: 40).background(.black).cornerRadius(10).padding(.top, 16)
            }
            Button {
                self.dismiss = false
            } label: {
                HStack{
                    Image(systemName: "xmark.app").foregroundColor(.red)
                    Text("閉じる").foregroundColor(.black)
                }
                .frame(width: UIScreen.main.bounds.width-40, height: 40).background(.white).cornerRadius(10).background(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2)).padding(.bottom, 16)
            }
        }.sheet(isPresented: $openModal) {
            MakeQuestionView(lessonImageURL: lessonImageURL, lessonTitle: lessonTitle, lessonID: lessonID, mentorIconImageURLString: mentorIcon, mentorName: mentorName)
        }
    }
}

struct QuestionAndAnswearView: View {
    let questionRecord: QuestionRecords
    let mentorIcon: String
    var body: some View {
        VStack(alignment: .leading){
            Text("Q.\(questionRecord.questionText)").bold()
            HStack{
                WebImage(url: URL(string: mentorIcon)).resizable().frame(width: 15, height: 15).clipShape(Circle())
                Text(questionRecord.answerText).font(.caption)
            }
        }
    }
}

struct MoreQuestionView_Previews: PreviewProvider {
    @State static var dismiss = false
    static var previews: some View {
        MoreQuestionView(questionRecords: [], mentorIcon: "", mentorName: "", lessonImageURL: "", lessonTitle: "", lessonID: "", openModal: false, dismiss: $dismiss)
    }
}
