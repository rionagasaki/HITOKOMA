//
//  SearchByAlgolia.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/26.
//

import Foundation
import AlgoliaSearchClient

struct SearchByAlgolia {
    
   
    let client = SearchClient(appID: "0RBIQR42FK", apiKey: "44d22136147208c68e2075c66f221f9a")
    
    
    func searchQuestionData(keyword: String, completion: @escaping (QuestionRecords) -> Void){
        let index = client.index(withName: "Question")
        index.search(query: Query(keyword)) { result in
            if case .success(let response) = result {
                if response.hits.count == 0 { return }
                response.hits.forEach { hit in
                    guard let object = hit.object.object(),
                          let data = try? JSONSerialization.data(withJSONObject: object),
                          let questionRecord = try? JSONDecoder().decode(QuestionRecords.self, from: data)
                    else { return }
                    completion(questionRecord)
                }
            }
        }
    }
}
