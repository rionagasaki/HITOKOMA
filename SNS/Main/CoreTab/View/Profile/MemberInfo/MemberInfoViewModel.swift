//
//  MemberInfoViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

class MemberInfoViewModel: ObservableObject {
    @Published var usernameField:String = ""
    @Published var genderField: Gender = .others
    @Published var ageField: String = ""
    @Published var instagramField: String = ""
    @Published var careerField: String = ""
    @Published var skillField: String = ""
    @Published var introduceField: String = ""
    @Published var displayTwitterAccount: String = ""
    @Published var displayFacebookAccount: String = ""
    @Published var showImageModal: Bool = false
    @Published var profileImageURLString: String = ""
   //  @Published var skillBar: SkillExperienceYear = (SkillExperienceYear(rawValue: 0.0) ?? 0.0)
    
//    var proficiencyOfSkill: String {
//        switch skillBar {
//        case .underQuarterYear:
//            return "3ヶ月未満"
//        case .underHalfyear:
//            return "3ヶ月~半年"
//        case .underOneyear:
//            return "半年~1年"
//        case .underOneyearAndHalfyear:
//            return "1年~1年半"
//        case .underTwoyear:
//            return "1年半~2年"
//        case .underTwoyearAndHalfyear:
//            return "2年~2年半"
//        case .underThreeyear:
//            return "2年半~3年"
//        case .overThreeyear:
//            return "3年以上"
//        }
//    }
}

enum Gender:String {
    case man = "男性"
    case woman = "女性"
    case others = "未選択"
}

enum SkillExperienceYear: Double {
    case underQuarterYear = 25
    case underHalfyear = 50
    case underOneyear = 75
    case underOneyearAndHalfyear = 100
    case underTwoyear = 125
    case underTwoyearAndHalfyear = 150
    case underThreeyear = 175
    case overThreeyear = 200
}
