//
//  Header.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/17.
//

import Foundation

struct Header: Hashable {
    var headerTitle: String
    var headerImageString: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(headerTitle)
        hasher.combine(headerImageString)
    }
}
