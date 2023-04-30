//
//  MakeRequestViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

class MakeRequestViewModel: ObservableObject {
    @Published var value = ""
    @Published var requestTitle: String = ""
    @Published var requestContents: String = ""
    @Published var showImageModal:Bool = false
    @Published var requestImageURL:String? = ""
    @Published var selectedDate: Date? = Date()
    @Published var budget:Int?
    @Published var period: String = ""
    @Published var shouldValidate: Bool = false
    @Published var requestImage: [UIImage?] = [UIImage()]
    @Published var bigCategory: String = ""
    @Published var selectedCategory: String = ""
    @Published var selection: Int = 0
    
    var hourCategories = ["30分","60分","90分","120分","150分","180分"]
    
}
