//
//  AdjustmentViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/20.
//

import SwiftUI

class SuggestOnRequestViewModel: ObservableObject {
    @Published var budgeText: String = ""
    @Published var dateText: String = ""
    @Published var periodText: String = ""
    @Published var appealText: String = ""
    var requestData: RequestData
    
    init(requestData: RequestData){
        self.requestData = requestData
    }
    
}
