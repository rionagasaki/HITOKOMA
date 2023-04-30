//
//  LessonHomeViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

class LessonHomeViewModel: ObservableObject {
    @Published var lessonData: [LessonData] = []
    @Published var lessonEnglishData: [LessonData] = []
    @Published var lessonComputerData: [LessonData] = []
    @Published var lessonLawData: [LessonData] = []
    @Published var lessonFinanceData: [LessonData] = []
    @Published var lessonInvestmentData: [LessonData] = []
    
    init(){
       fetchAllLesson()
    }
    
    func fetchAllLesson() {
        FetchFromFirestore().fetchLessonInfoFromFirestore { lesson in
            FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: lesson.mentorUid) { userInfo in
                lesson.userImageIconURLString = userInfo.profileImage
                lesson.username = userInfo.username
                self.lessonData.append(lesson)
                let bigCategory = CategoryDetail(rawValue: lesson.bigCategory)
                switch bigCategory {
                case .english: self.lessonEnglishData.append(lesson)
                case .computer: self.lessonComputerData.append(lesson)
                case .law: self.lessonLawData.append(lesson)
                case .finance: self.lessonFinanceData.append(lesson)
                case .investment: self.lessonInvestmentData.append(lesson)
                case .none:
                    print("Error_NoCategory")
                }
            }
        }
    }
}
