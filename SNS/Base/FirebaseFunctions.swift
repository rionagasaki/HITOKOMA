//
//  FirebaseFunctions.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/04.
//

import Foundation
import FirebaseFunctions

class callCloudFunctions{
    lazy var functions = Functions.functions()
    private let createCustomerRequest = URL(string: "https://asia-northeast1-marketsns.cloudfunctions.net/createCustomer")
    func setFunctions(email: String ,completion: @escaping (String) -> Void){
        functions.httpsCallable(createCustomerRequest!).call(["email": email]){ result, error in
            if let error = error {
                print("ERROR=>setFunctions\(error)")
                return
            }
            if let data = result?.data as? [String: Any], let customerId = data["customerId"] as? String {
                completion(customerId)
            }
        }
    }
}
