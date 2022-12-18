//
//  MainHomeViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/15.
//

import SwiftUI

class MainHomeViewModel: ObservableObject {
    let headers:[Header] = [Header(headerTitle: "ひとこまから学びを始めよう", headerImageString: "header1"), Header(headerTitle: "あなたの知識が報酬に", headerImageString: "header2"), Header(headerTitle: "わからないことは何でも聞いてみよう", headerImageString: "header3")]
    
    @Published var selection: Int = 0
    @Published var isRefreshing: Bool = false
    @Published var timer: Timer?
    @Published var lessonData: [LessonData] = []
    @Published var lessonEnglishData: [LessonData] = []
    @Published var lessonComputerData: [LessonData] = []
    @Published var lessonLawData: [LessonData] = []
    @Published var lessonFinanceData: [LessonData] = []
    @Published var lessonInvestmentData: [LessonData] = []
    
    init(){
        fetchAllLesson()
    }
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            withAnimation {
                if self.selection >= 2 {
                    self.selection = 0
                } else {
                    self.selection += 1
                }
            }
        }
    }
    
    func invalidateTimer(){
        timer?.invalidate()
    }
    
    func fetchAllLesson(){
        self.isRefreshing = true
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
                self.isRefreshing = false
            }
        }
    }
}
