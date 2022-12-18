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

let allCategories = [
    CategoryData(categoryName: "英会話", categoryImage: "English", category: .english),
    CategoryData(categoryName: "IT", categoryImage: "computer", category: .computer),
    CategoryData(categoryName: "法律", categoryImage: "study", category: .law),
    CategoryData(categoryName: "ファイナンス", categoryImage: "coffee", category: .finance),
    CategoryData(categoryName: "投資", categoryImage: "invest", category: .investment)]

let englishDetails = [DetailCategory(categoryName: "全て", categoryImage: "English"),DetailCategory(categoryName: "TOEIC", categoryImage: "TOEIC"),DetailCategory(categoryName: "TOEFL", categoryImage: "TOEFL"),DetailCategory(categoryName: "英検", categoryImage: "EnglishTest"), DetailCategory(categoryName: "その他", categoryImage: "")]

let computerDetails = [DetailCategory(categoryName: "全て", categoryImage: "computer"),DetailCategory(categoryName: "基本/応用情報", categoryImage: "basicInformation"), DetailCategory(categoryName: "プログラミング", categoryImage: "programming"), DetailCategory(categoryName: "G/E資格", categoryImage: "AI"),DetailCategory(categoryName: "その他", categoryImage: "")
]

let lawDetails = [DetailCategory(categoryName: "全て", categoryImage: "study"),DetailCategory(categoryName: "宅建", categoryImage: "law"), DetailCategory(categoryName: "その他", categoryImage: "")]

let financeDetails = [DetailCategory(categoryName: "全て", categoryImage: "coffee"),DetailCategory(categoryName: "会計士", categoryImage: "accountant"), DetailCategory(categoryName: "簿記", categoryImage: "bookKeeping"),DetailCategory(categoryName: "その他", categoryImage: "")]

let investmentDetails = [DetailCategory(categoryName: "全て", categoryImage: "invest"),DetailCategory(categoryName: "株式取引", categoryImage: ""), DetailCategory(categoryName: "為替取引", categoryImage: ""), DetailCategory(categoryName: "資産運用", categoryImage: ""), DetailCategory(categoryName: "その他", categoryImage: "")]
