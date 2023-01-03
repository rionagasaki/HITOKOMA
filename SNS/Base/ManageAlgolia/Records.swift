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

struct LessonRecords: Codable {
    let objectID: String
    let lessonName: String
    let lessonImageURLString: String
    let bigCategory: String
    let category: String
    let lessonContent: String
    let mentorUid: String
    let budget: Int
}

struct RequestRecords {
    
}
