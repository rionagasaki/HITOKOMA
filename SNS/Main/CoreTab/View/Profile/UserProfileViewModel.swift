//
//  UserProfileViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/08.
//

import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var usersLessons: [LessonData] = []
    @Published var usersRequest: [RequestData] = []

    init(){
        FetchFromFirestore()
            .fetchLessonInfoFromFirestore { lessonData in
                self.usersLessons.append(lessonData)
            }
        FetchFromFirestore()
            .fetchRequestInfoFromFirestore { requestData in
                self.usersRequest.append(requestData)
            }
    }
    
}
