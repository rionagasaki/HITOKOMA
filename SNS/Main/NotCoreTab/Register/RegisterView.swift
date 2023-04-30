//
//  RegisterView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/29.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("",
                          text: $viewModel.usernameText ,
                          prompt:
                            Text("ユーザーネーム")
                )
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.customLightGray, lineWidth: 2))
                    .onChange(of: viewModel.usernameText, perform: { _ in
                        viewModel.validateUsername()
                    })
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                TextField("",
                          text: $viewModel.emailText ,
                          prompt:
                            Text("メールアドレス")
                )
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.customLightGray, lineWidth: 2))
                    .onChange(of: viewModel.emailText, perform: { _ in
                        viewModel.validateEmail()
                    })
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                if !viewModel.isCurrentEmail && viewModel.emailText != "" {
                    Text("メールアドレスの形式で入力してください。")
                        .fontWeight(.light)
                        .font(.system(size: 12))
                        .foregroundColor(.customRed2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                }
                
                SecureField("",
                          text: $viewModel.passwordText ,
                          prompt:
                            Text("パスワード")
                )
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.customLightGray, lineWidth: 2))
                    .onChange(of: viewModel.passwordText, perform: { _ in
                        viewModel.validatePassword()
                    })
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                
                if !viewModel.isCurrentPassword && viewModel.passwordText != "" {
                    Text("パスワードは8文字以上かつ英数字それぞれ1文字以上含む必要があります。")
                        .fontWeight(.light)
                        .font(.system(size: 12))
                        .foregroundColor(.customRed2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                }
                
                Button {
                    viewModel.signUp()
                } label: {
                    Text("新規登録")
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                        .bold()
                        .frame(width: UIScreen.main.bounds.width-40, height: 50)
                        .background(viewModel.isEnabledTappedRegisterButton ? Color.customBlue: Color.customBlue.opacity(0.2))
                        .cornerRadius(32)
                        .padding(.top, 8)
                        .padding(.horizontal,16)
                }
                .disabled(!viewModel.isEnabledTappedRegisterButton)
                Text("または")
                    .foregroundColor(.gray)
                    .font(.system(size: 17))
                    .bold()
                    .padding(.vertical, 16)
                
                Button {
                    viewModel
                        .signUp()
                } label: {
                    SignUpWithAppleButton()
                        .frame(height:50)
                        .cornerRadius(32)
                }.frame(width: UIScreen.main.bounds.width-32,height:50)
            }
        }
        .navigationTitle("新規登録")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
