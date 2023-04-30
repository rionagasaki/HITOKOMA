//
//  MainHomeViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/15.
//

import SwiftUI
import Foundation

class MainHomeViewModel: ObservableObject {
    let headers:[Header] = [Header(headerTitle: "ひとこまから学びを始めよう", headerImageString: R.image.images.header.main_home.header_first.name), Header(headerTitle: "あなたの知識が報酬に", headerImageString: R.image.images.header.main_home.header_second.name), Header(headerTitle: "わからないことは何でも聞いてみよう", headerImageString: R.image.images.header.main_home.header_third.name)]
    
    @Published var selection: Int = 0
    @Published var isRefreshing: Bool = false
    @Published var timer: Timer?
    @Published var lessonData: [LessonData] = []
    @Published var lessonEnglishData: [LessonData] = []
    @Published var lessonComputerData: [LessonData] = []
    @Published var lessonLawData: [LessonData] = []
    @Published var lessonFinanceData: [LessonData] = []
    @Published var lessonInvestmentData: [LessonData] = []
    @Published var requestData: [RequestData] = []
    @Published var requestEnglishData: [RequestData] = []
    @Published var requestComputerData: [RequestData] = []
    @Published var requestLawData: [RequestData] = []
    @Published var requestFinanceData: [RequestData] = []
    @Published var requestInvestmentData: [RequestData] = []
    
    init(){
        fetchAll()
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
    
    func fetchAll() {
        isRefreshing = true
        fetchAllLesson()
        fetchAllRequest()
           
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
    
    func fetchAllRequest(){
        FetchFromFirestore().fetchRequestInfoFromFirestore { request in
            FetchFromFirestore().fetchOtherUserInfoFromFirestore(uid: request.requestUserUid) { userInfo in
                request.userImageIconURL = userInfo.profileImage
                request.username = userInfo.username
                self.requestData.append(request)
                let bigCategory = CategoryDetail(rawValue: request.bigCategory)
                switch bigCategory {
                case .english: self.requestEnglishData.append(request)
                case .computer: self.requestComputerData.append(request)
                case .law: self.requestLawData.append(request)
                case .finance: self.requestFinanceData.append(request)
                case .investment: self.requestInvestmentData.append(request)
                case .none:
                    print("Error_NoCategory")
                }
                self.isRefreshing = false
            }
        }
    }
}
