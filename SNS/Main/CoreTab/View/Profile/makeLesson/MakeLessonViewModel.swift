//
//  MakeLessonViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/18.
//

import Foundation
import SwiftUI
import UIKit
import PKHUD

class MakeLessonViewModel: ObservableObject {
    
    @Published var lessonName: String = ""
    @Published var lessonContent: String = ""
    @Published var lessonImage: UIImage? = nil
    @Published var bigCategory: String = ""
    @Published var lessonCategory: String = ""
    @Published var budget: Int?
    @Published var lessonPeriod: String = ""
    @Published var lessonDate: Date = Date()
    @Published var showingImagePicker = false
    @Published var isFree: Bool = false
    var hourCategories = ["30分","60分","90分","120分","150分","180分"]
    
    
    func makeLesson(){
        if  lessonName != ""
            && lessonContent != ""
            && lessonImage != nil
            && lessonCategory != ""
            && lessonPeriod != "" {
            RegisterStorage().refisterImageToStorage(folderName: "UserProfile", profileImage: lessonImage!){ imageURL in
                let lessonImageURLString = imageURL.absoluteString
                SetToFirestore().registerLessonInfoFirestore(lessonName: self.lessonName, lessonContents: self.lessonContent, lessonImageURLString: lessonImageURLString, bigCategory: self.bigCategory, lessonCategory: self.lessonCategory, budget: self.budget ?? 1000, period: self.lessonPeriod){ lessonId in
                    UpdateFirestore().updateUsersMakeLesson(lessonId: lessonId){
                        HUD.flash(.success, delay: 1.0)
                    }
                }
            }
        }
    }
}
