//
//  LessonSummaryView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/04.
//

import SwiftUI
import SDWebImageSwiftUI

struct LessonSummaryView: View {
    
    let lessonImageURLString: String
    let lessonTitle: String
    let mentorIconImageURLString: String
    let mentorName: String
    
    var body: some View {
        HStack(alignment: .top){
            WebImage(url: URL(string: lessonImageURLString)).resizable().frame(width: 80, height: 70).padding(.leading, 5)
            VStack(alignment: .leading){
                Text(lessonTitle).font(.system(size: 15)).bold()
                HStack(spacing: 2){
                    WebImage(url: URL(string: mentorIconImageURLString)).resizable().frame(width:20, height: 20).clipShape(Circle())
                    Text(mentorName).font(.caption)
                }
            }
            Spacer()
        }.padding(.vertical, 20)
    }
}

struct LessonSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        LessonSummaryView(lessonImageURLString: "", lessonTitle: "", mentorIconImageURLString: "", mentorName: "")
    }
}
