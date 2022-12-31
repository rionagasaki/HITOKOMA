//
//  LoginOrRegisterView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

struct LoginOrRegisterView: View {
    var body: some View {
        VStack{
            Image(image.others.hitokomA.name)
                .resizable()
                .frame(width: UIScreen.main.bounds.width-150, height: 50)
                .scaledToFit()
                .padding(.vertical, 8)
            Image(image.others.applicationImage.name)
                .resizable()
                .frame(width: UIScreen.main.bounds.width-200, height: 300)
                .padding(.top, 16)
            
           
            Spacer()
            NavigationLink {
                LoginView()
            } label: {
                Text("ログイン")
                    .foregroundColor(.white)
                    .font(.system(size: 17))
                    .bold()
                    .frame(width: UIScreen.main.bounds.width-40, height: 50)
                    .background(Color.customBlue)
                    .cornerRadius(32)
                    .padding(.top, 8)
                    .padding(.horizontal,16)
            }
            
            NavigationLink {
                RegisterView()
            } label: {
                Text("新規登録")
                    .foregroundColor(.customBlue)
                    .font(.system(size: 17))
                    .bold()
                    .frame(width: UIScreen.main.bounds.width-40, height: 50)
                    .background(Color.customLightGray)
                    .cornerRadius(32)
                    .padding(.top, 8)
                    .padding(.horizontal,16)
                    .padding(.bottom, 16)
            }
        }
    }
}

struct LoginOrRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginOrRegisterView()
    }
}
