//
//  ForgetPasswordView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/30.
//

import SwiftUI

struct ForgetPasswordView: View {
    @StateObject private var viewModel = ForgetPasswordViewModel()
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ScrollView {
                VStack{
                    VStack{
                        Text("パスワードを忘れた方")
                            .fontWeight(.light)
                            .font(.system(size: 23))
                            .padding(.top, 20)
                        
                        Text("登録しているメールアドレスを入力してください。入力先メールアドレスに、パスワード再設定用リンクをお送りします。")
                            .fontWeight(.light)
                            .font(.system(size: 14))
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                        
                        VStack(spacing: .zero){
                            Divider()
                            Text("メールアドレス")
                                .font(.system(size: 12))
                                .foregroundColor(Color.customGray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 7)
                                .padding(.leading, 10)
                            Divider()
                        }
                        .background(.ultraThinMaterial)
                        
                        TextField("",
                                  text: $viewModel.emailText,
                                  prompt: Text("メールアドレス")
                        )
                            .padding(.leading, 10)
                            .frame(height: 38)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                        
                        Button {
                            viewModel.sendPasswordResetMail()
                        } label: {
                            Text("送信する")
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
        .background(.ultraThinMaterial)
        .alert(isPresented: $viewModel.isVisibleAlert) {
            Alert(
                title: Text("メールの送信に失敗しました")
                    .bold(),
                message: Text("メールアドレスをご確認の上、再度送信してください。")
                    .fontWeight(.medium)
                ,
                dismissButton: .cancel(
                    Text("閉じる")
                        .fontWeight(.light)
                        .foregroundColor(.customBlue)
                )
            )
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
