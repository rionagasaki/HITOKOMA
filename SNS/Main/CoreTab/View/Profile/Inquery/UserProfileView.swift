//
//  UserProfileView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/27.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfileView: View {
    
    let username: String
    let userProfileImageURL: String
    let usersLessonData: [LessonData]
    let usersRequestData: [RequestData]
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: .zero){
                UserBaseProfileView(userProfileImageURL: userProfileImageURL, username: username)
                Divider().padding(.bottom, 10)
                Text("ここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テキストここに紹介テO紹介テキスト").font(.caption).padding(.horizontal,16)
                Divider().padding(.vertical, 10)
                UserSubBaseProfileView()
                Spacer()
            }
        }
    }
}

struct UserBaseProfileView: View {
    let userProfileImageURL: String
    let username: String
    
    var body: some View{
        VStack(alignment: .leading, spacing: .zero){
            Image("ramen")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 150)
            
            HStack{
                WebImage(url: URL(string: userProfileImageURL))
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
           
            Text(username)
                .bold()
                .padding(.leading, 16)
                .padding(.top, 5)
            
            Text("20代/男性/千葉県")
                .foregroundColor(.init(uiColor: .lightGray))
                .font(.caption)
                .font(.system(size: 12))
                .padding(.leading, 16)
            
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
    var body: some View{
        Text("得意分野")
            .font(.system(size: 18))
            .bold()
            .padding(.leading, 16)
        Divider()
            .padding(.vertical, 10)
        Text("経歴・資格等")
            .font(.system(size: 18))
            .bold()
            .padding(.leading, 16)
        
        Divider()
            .padding(.vertical, 10)
        Text("公開済みのレッスン")
            .font(.system(size: 18))
            .bold()
            .padding(.leading, 16)
        
        Divider()
            .padding(.vertical, 10)
        
        ScrollView(.horizontal){
            HStack{
                
            }
        }
        Text("このユーザーのリクエスト")
            .font(.system(size: 18))
            .bold()
            .padding(.leading, 16)
        
        Divider()
            .padding(.vertical, 10)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(username: "", userProfileImageURL: "", usersLessonData: [], usersRequestData: [])
    }
}
