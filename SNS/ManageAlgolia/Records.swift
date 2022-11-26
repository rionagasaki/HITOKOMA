//
//  Records.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/26.
//

import Foundation
import AlgoliaSearchClient

struct QuestionRecords: Decodable, Hashable {
    let objectID: String
    let path: String
    let lessonId: String
    let questionText: String
    let answerText: String
    let questionUserUid: String
    
}

struct LessonRecords {
    
}

struct RequestRecords {
    
}
