//
//  PasswordChangeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import SwiftUI

struct PasswordChangeView: View {
    @StateObject private var viewModel = PasswordChangeViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ScrollView {
                VStack{
                    Text("🔑パスワード設定")
                        .font(.system(size: 25))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 30)
                    
                    VStack{
                        Text("パスワードの変更")
                            .fontWeight(.light)
                            .font(.system(size: 23))
                            .padding(.top, 20)
                        
                        VStack(spacing: .zero){
                            Divider()
                            Text("現在のパスワード")
                                .font(.system(size: 12))
                                .foregroundColor(Color.customGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 7)
                                .padding(.leading, 10)
                            Divider()
                        }
                        .background(.ultraThinMaterial)
                        
                        TextField("", text: $viewModel.currentPasswordField, prompt: Text("現在のパスワード"))
                            .padding(.leading, 10)
                            .frame(height: 38)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                        
                        VStack(spacing: .zero){
                            Divider()
                            Text("新しいパスワード")
                                .font(.system(size: 12))
                                .foregroundColor(Color.customGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 7)
                                .padding(.leading, 10)
                            Divider()
                        }
                        .background(.ultraThinMaterial)
                        
                        TextField("", text: $viewModel.newPasswordField, prompt: Text("新しいパスワード"))
                            .padding(.leading, 10)
                            .frame(height: 38)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                        TextField("", text: $viewModel.newConfirmationPasswordTextFIeld, prompt: Text("新しいパスワード(確認用)"))
                            .padding(.leading, 10)
                            .frame(height: 38)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                        Button {
                            print("aaa")
                        } label: {
                            Text("確認する")
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .bold()
                                .frame(width: UIScreen.main.bounds.width-40, height: 50)
                                .background(Color.customBlue)
                                .cornerRadius(10)
                                .padding(.top, 10)
                                .padding(.horizontal,10)
                                .padding(.bottom, 20)
                        }
                    }
                    .background(.white)
                }
            }
            DismissButtonView()
                .padding(.leading, 40)
                .padding(.bottom, 40)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .background(.ultraThinMaterial)
    }
}

struct PasswordChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordChangeView()
    }
}
