//
//  TransactionFInishView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/30.
//

import SwiftUI

struct TransactionFinishView: View {
    
    let lessonImageURLString: String
    let lessonTitle: String
    let mentorIconImageURLString: String
    let mentorName: String
    
    var body: some View {
        VStack(spacing: 5){
            LessonSummaryView(lessonImageURLString: lessonImageURLString, lessonTitle: lessonTitle, mentorIconImageURLString: mentorIconImageURLString, mentorName: mentorName)
            Divider()
            AfterLessonView(allSelection: -1, clearitySelection: -1, interestingSelection: -1)
            Spacer()
        }
    }
}

struct TransactionFinishView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFinishView(lessonImageURLString: "", lessonTitle: "", mentorIconImageURLString: "", mentorName: "")
    }
}
