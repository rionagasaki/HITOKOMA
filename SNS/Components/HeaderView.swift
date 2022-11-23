//
//  ProfileHeaderView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeaderView: View {
    let username: String
    let userProfileImage: String
    var body: some View {
        
        VStack{
            HStack{
                WebImage(url: URL(string: userProfileImage)).resizable().placeholder(Image(systemName: "photo"))
                .placeholder {
                    Rectangle().foregroundColor(.gray.opacity(0.2))
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5)) .background(Color.gray.opacity(0.2)).frame(width: 100, height: 100).cornerRadius(100)
                VStack(alignment: .leading){
                    Text(username).bold().font(.system(size: 24)).padding(.trailing,100)
                    NavigationLink {
                        ConnectAccountView()
                    } label: {
                        Text("ひとこまを販売する").bold().foregroundColor(Color.white).frame(width: 200,height: 30).background(Color.blue.opacity(0.6)).cornerRadius(15)
                    }
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(username: "長崎りお", userProfileImage: "")
    }
}
