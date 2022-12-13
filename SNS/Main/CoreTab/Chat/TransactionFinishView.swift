//
//  TransactionFInishView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/30.
//

import SwiftUI

struct TransactionFinishView: View {
    let messageListData: MessageListData
    
    var body: some View {
        VStack(spacing: 5){
            ScrollView {
                LessonSummaryView(lessonImageURLString: messageListData.lessonImage, lessonName: messageListData.lessonName, mentorIconImageURLString: messageListData.senderIconImage, mentorName: messageListData.senderName).padding(.horizontal, 16)
                Divider()
                AfterLessonView(allSelection: -1, clearitySelection: -1, interestingSelection: -1)
                Spacer()
            }
        }
    }
}
