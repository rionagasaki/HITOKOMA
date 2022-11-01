//
//  DashBoardCall.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import Foundation
import FirebaseFunctions

class DashBoardCall {
    private lazy var functions = Functions.functions()
    private let urlString = "https://us-central1-marketsns.cloudfunctions.net/createDashboardLink"
    func callBackend(){
        functions.httpsCallable(URL(string: urlString)!).call { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(result?.data)
        }
    }
}
