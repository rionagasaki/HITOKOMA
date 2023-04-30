//
//  UserProfileView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/27.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfileView: View {
    
    @StateObject var viewModel = UserProfileViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ScrollView{
                VStack(alignment: .leading, spacing: .zero){
                    UserBaseProfileView(userProfileImageURL: User.shared.profileImage, username: User.shared.username)
                    
                    CustomDivider()
                        .padding(.bottom, 10)
                    
                    Text(User.shared.selfIntroduce)
                        .font(.caption)
                        .padding(.horizontal,16)
                    
                    CustomDivider()
                        .padding(.vertical, 10)
                    UserSubBaseProfileView(viewModel: viewModel)
                    Spacer()
                }
            }
            DismissButtonView()
                .padding(.bottom, 30)
                .padding(.leading, 30)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct UserBaseProfileView: View {
    let userProfileImageURL: String
    let username: String
    
    var body: some View{
        VStack(alignment: .leading, spacing: .zero){
            WebImage(url: URL(string: User.shared.headerImage))
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 150)
            
            HStack{
                WebImage(url: URL(string: User.shared.profileImage))
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .background(Circle().stroke(.white, lineWidth: 5))
                    .padding(.leading, 16)
                    .padding(.top, -35)
                
                Spacer()
                
                Button {
                    print("aaa")
                } label: {
                    Text("フォローする")
                        .padding(.all, 5)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
                .padding(.trailing, 16)
            }
            
            Text(User.shared.username)
                .bold()
                .padding(.leading, 16)
                .padding(.top, 5)
            
            Text("\(User.shared.generation)/\(User.shared.gender)/千葉県")
                .foregroundColor(.init(uiColor: .lightGray))
                .font(.caption)
                .font(.system(size: 12))
                .padding(.leading, 16)
            
            HStack(spacing: .zero){
                Image(systemName: "link")
                    .foregroundColor(.init(uiColor: .lightGray))
                    .font(.caption)
                    .font(.system(size: 12))
                    .padding(.leading,16)
                
                Text("https://default.html")
                    .foregroundColor(.init(uiColor: .lightGray))
                    .font(.caption)
                    .font(.system(size: 12))
            }
            
            HStack{
                Text("機密保持契約(NDA)")
                    .foregroundColor(.black)
                    .font(.caption)
                
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
            }
            .font(.caption)
            .padding(.leading, 16)
            Spacer()
        }
    }
}

struct UserSubBaseProfileView: View {
    
    @StateObject var viewModel: UserProfileViewModel
    
    var body: some View{
        Text("得意分野")
            .font(.system(size: 18))
            .bold()
            .padding(.leading, 16)
        VStack {
            if let skills = User.shared.skill?.skills {
                ForEach(skills) { skill in
                    HStack {
                        Text(skill.skillName)
                            .fontWeight(.medium)
                            .font(.system(size: 16))
                            .padding(.leading, 32)
                        Spacer()
                        VisibleSkillBar()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 16)
                    }
                    .padding(.top, 16)
                    
                }
            }
        }
        
        CustomDivider()
            .padding(.vertical, 10)
        Text("経歴・資格等")
            .font(.system(size: 18))
            .bold()
            .padding(.leading, 16)
            .padding(.top, 8)
        
        Text(User.shared.career)
            .fontWeight(.regular)
            .font(.system(size: 13))
            .padding(.horizontal,32)
            .padding(.top, 8)
        
        
        CustomDivider()
            .padding(.vertical, 10)
        
        VStack(alignment: .leading){
            Text("公開済みのレッスン")
                .font(.system(size: 18))
                .bold()
                .padding(.leading, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.usersLessons) { lesson in
                        OneClassView(
                            lessonImageURLString: lesson.lessonImageURLString,
                            lessonName: lesson.lessonName,
                            userIconURLString: User.shared.profileImage,
                            lessonBudgets: lesson.budget)
                    }
                }
                .padding(.horizontal, 16)
            }
            
            CustomDivider()
                .padding(.vertical, 10)
            
        }
        ScrollView(.horizontal){
            HStack{
                
            }
        }
        Text("このユーザーのリクエスト")
            .font(.system(size: 18))
            .bold()
            .padding(.leading, 16)
        
        CustomDivider()
            .padding(.vertical, 10)
    }
}

struct UserSNSView: View {
    var body: some View {
        VStack {
            HStack {
                
            }
        }
    }
}
