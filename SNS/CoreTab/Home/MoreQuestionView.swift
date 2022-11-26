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

    var body: some View {
        List(questionRecords, id:\.self) { question in
            QuestionAndAnswearView(questionRecord: question, mentorIcon: mentorIcon)
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
    static var previews: some View {
        MoreQuestionView(questionRecords: [], mentorIcon: "")
    }
}
