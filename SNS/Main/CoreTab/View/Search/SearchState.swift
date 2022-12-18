//
//  SearchState.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/24.
//

import Foundation

struct SearchSuggestion: Equatable, Hashable, Identifiable{
    let id = UUID()
    var suggestionTitle:String
    var description:String
    var suggestionImage:String
}
