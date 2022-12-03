//
//  Category.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/05.
//

import Foundation
import SwiftUI

struct CategoryData: Identifiable {
    let id = UUID()
    let categoryName: String
    let categoryImage: String
    let category: CategoryDetail
}

