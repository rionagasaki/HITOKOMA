//
//  RequestHomeViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/17.
//

import SwiftUI

class RequestHomeViewModel: ObservableObject {

    @Published var requestData: [RequestData] = []
    @Published var requestEnglishData: [RequestData] = []
    @Published var requestComputerData: [RequestData] = []
    @Published var requestLawData: [RequestData] = []
    @Published var requestFinanceData: [RequestData] = []
    @Published var requestInvestmentData: [RequestData] = []
    
    init(){
        
        fetchAllRequest()
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
            }
        }
    }
}
