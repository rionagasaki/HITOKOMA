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
    @Published var budget: Int = 0
    @Published var period: String = ""
    
    func makeLesson(){
        if  lessonName != ""
            && lessonContent != ""
            && lessonImage != nil
            && lessonCategory != ""
            && period != "" {
            RegisterStorage().refisterImageToStorage(folderName: "UserProfile", profileImage: lessonImage!){ imageURL in
                let lessonImageURLString = imageURL.absoluteString
                SetToFirestore().registerLessonInfoFirestore(lessonName: self.lessonName, lessonContents: self.lessonContent, lessonImageURLString: lessonImageURLString, bigCategory: self.bigCategory, lessonCategory: self.lessonCategory, budget: self.budget, period: self.period){ lessonId in
                    UpdateFirestore().updateUsersMakeLesson(lessonId: lessonId){
                        HUD.flash(.success, delay: 1.0)
                    }
                }
            }
        }
    }
}
