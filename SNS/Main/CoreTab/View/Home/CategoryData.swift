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

let image = R.image.images

let allCategories = [
    CategoryData(
        categoryName: "英会話",
        categoryImage: image.category.english.english.name,
        category: .english),
    CategoryData(
        categoryName: "IT",
        categoryImage: image.category.technology.computer.name,
        category: .computer),
    CategoryData(
        categoryName: "法律",
        categoryImage: image.category.law.law.name,
        category: .law),
    CategoryData(
        categoryName: "ファイナンス",
        categoryImage: image.category.finance.finance.name,
        category: .finance),
    CategoryData(
        categoryName: "投資",
        categoryImage: image.category.investment.invest.name,
        category: .investment)
]

let englishDetails = [
    DetailCategory(categoryName: "全て",
                   categoryImage: image.category.english.english.name),
    DetailCategory(categoryName: "TOEIC",
                   categoryImage: image.category.english.toeiC.name),
    DetailCategory(categoryName: "TOEFL",
                   categoryImage: image.category.english.toefL.name),
    DetailCategory(categoryName: "英検",
                   categoryImage: image.category.english.englishTest.name),
    DetailCategory(categoryName: "その他",
                   categoryImage: image.category.english.alphabet.name)]

let computerDetails = [
    DetailCategory(
        categoryName: "全て",
        categoryImage: image.category.technology.computer.name),
    DetailCategory(
        categoryName: "基本/応用情報",
        categoryImage: image.category.technology.basicInformation.name),
    DetailCategory(
        categoryName: "プログラミング",
        categoryImage: image.category.technology.programming.name),
    DetailCategory(
        categoryName: "G/E資格",
        categoryImage: image.category.technology.ai.name),
    DetailCategory(
        categoryName: "その他",
        categoryImage: image.category.technology.computer.name)
]

let lawDetails = [
    DetailCategory(
        categoryName: "全て",
        categoryImage: image.category.law.law.name),
    DetailCategory(
        categoryName: "宅建",
        categoryImage: image.category.law.promise.name),
    DetailCategory(
        categoryName: "その他",
        categoryImage: image.category.law.law.name)
]

let financeDetails = [
    DetailCategory(
        categoryName: "全て",
        categoryImage: image.category.finance.finance.name),
    DetailCategory(
        categoryName: "会計士",
        categoryImage: image.category.finance.accountant.name),
    DetailCategory(
        categoryName: "簿記",
        categoryImage: image.category.finance.finance.name),
    DetailCategory(
        categoryName: "その他",
        categoryImage: image.category.finance.finance.name)
]

let investmentDetails = [
    DetailCategory(
        categoryName: "全て",
        categoryImage: image.category.investment.invest.name),
    DetailCategory(
        categoryName: "株式取引",
        categoryImage: ""),
    DetailCategory(
        categoryName: "為替取引",
        categoryImage: ""),
    DetailCategory(
        categoryName: "資産運用",
        categoryImage: ""),
    DetailCategory(
        categoryName: "その他",
        categoryImage: "")
]
