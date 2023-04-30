//
//  SearchViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/01.
//

import SwiftUI
import InstantSearchSwiftUI


class SearchViewModel: ObservableObject {
    @Published var mentorImageURLString: String = ""
    @Published var mentorName: String = ""
    @Published var budget: Int = 0
    @Published var isEditing: Bool = false
}
