//
//  Stripe.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/27.
//

import Stripe
import Foundation
import FirebaseFunctions

class MyAPIClient: NSObject, STPCustomerEphemeralKeyProvider {
    
    private var baseURL = URL(string: "")!
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = baseURL.appendingPathComponent("")
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [URLQueryItem(name: "api_version", value: apiVersion)]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200, let data = data, let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??) else {
                completion(nil, error)
                return
            }
            completion(json, nil)
        }
        task.resume()
    }
}

struct StripeIndividual {
    let firstNameKanji:String
    let firstNameKana:String
    let lastNameKanji:String
    let lastNameKana:String
    let birthday: Date
    let gender: String
}
