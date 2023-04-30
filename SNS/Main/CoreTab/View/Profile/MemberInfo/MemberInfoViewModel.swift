//
//  MemberInfoViewModel.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI
import PKHUD
import SDWebImageSwiftUI

class MemberInfoViewModel: ObservableObject {
    let generations = ["10代", "20代", "30代", "40代", "50代", "60代", "未選択"]
    let genders = [
        Gender(gender: .man),
        Gender(gender: .woman),
        Gender(gender: .others)
    ]
    var currentHeaderImageURLString = User.shared.headerImage
    var currentProfileImageURLString = User.shared.profileImage
    
    @Published var user: User?
    
    @Published var usernameField:String = User.shared.username
    
    @Published var settingImage: SettingImage?
    @Published var headerImage: UIImage?
    @Published var profileImage:UIImage?
    
    @Published var skills: [Skill] = (User.shared.skill?.skills ?? [Skill(skillName: "", skillYear: 0.0)])
    
    @Published var genderField: Gender = .init(gender: AllGender(rawValue: User.shared.gender) ?? AllGender(rawValue: "男性")!)
    @Published var ageField: String = User.shared.generation
    @Published var instagramField: String = ""
    @Published var careerField: String = User.shared.career
    @Published var introduceField: String = User.shared.selfIntroduce
    @Published var displayTwitterAccount: String = ""
    @Published var displayFacebookAccount: String = ""
    
    
    var isEditIntroduceField: Bool {
        introduceField != ""
    }
    
    var isEditCareerField: Bool {
        careerField != ""
    }

    
    func updateHeaderImage(completion:@escaping () -> Void) {
        if let headerImage = headerImage {
            RegisterStorage()
                .refisterImageToStorage(
                    folderName: "UserProfile/Header",
                    profileImage: headerImage) { headerImageURL in
                        self.currentHeaderImageURLString = headerImageURL.absoluteString
                        completion()
                    }
        } else {
            completion()
        }
    }
    func  updateProfileImage(completion:@escaping () -> Void) {
        if let profileImage = profileImage {
            RegisterStorage()
                .refisterImageToStorage(
                    folderName: "UserProfile",
                    profileImage: profileImage) { profileImageURL in
                        self.currentProfileImageURLString = profileImageURL.absoluteString
                        completion()
                    }
        } else {
            completion()
        }
    }
    
    
    
    func updateProfile() {
        let skills = Skills(skills: skills)
        updateHeaderImage {
            self.updateProfileImage {
                UpdateFirestore()
                    .updateUserInfoFirestore(
                        username: self.usernameField,
                        gender: self.genderField.gender.rawValue,
                        generation: self.ageField,
                        singleIntroduction: self.introduceField,
                        profileImageURL: self.currentProfileImageURLString,
                        headerImageURL: self.currentHeaderImageURLString,
                        career: self.careerField,
                        skills: skills) {
                            User.shared.username = self.usernameField
                            User.shared.gender = self.genderField.gender.rawValue
                            User.shared.headerImage = self.currentHeaderImageURLString
                            User.shared.profileImage = self.currentProfileImageURLString
                            User.shared.selfIntroduce = self.introduceField
                            User.shared.career = self.careerField
                            User.shared.generation = self.ageField
                            User.shared.skill = Skills(skills: self.skills)
                            HUD.show(.success)
                            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                                HUD.hide()
                            }
                        }
            }
        }
    }
}

enum AllGender: String, CaseIterable, Hashable, Identifiable {
    case man = "男性"
    case woman = "女性"
    case others = "その他"
    
    var id: String { rawValue }
}

struct Gender: Equatable ,Hashable {
    let gender: AllGender
    var color: Color {
        switch gender {
        case .man:
            return Color.blue
        case .woman:
            return Color.customRed2
        case .others:
            return Color.yellow
        }
    }
    
    init(gender: AllGender) {
        self.gender = gender
    }
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
