//
//  LoginCardView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState:AppState
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("", text: $viewModel.emailText , prompt: Text("メールアドレス"))
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.customLightGray, lineWidth: 2))
                    .onChange(of: viewModel.emailText, perform: { _ in
                        viewModel.validateEmail()
                    })
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                SecureField("", text: $viewModel.passwordText , prompt: Text("パスワード"))
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.customLightGray, lineWidth: 2))
                    .onChange(of: viewModel.passwordText, perform: { _ in
                        viewModel.validatePassword()
                    })
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                
                NavigationLink {
                    ForgetPasswordView()
                } label: {
                    Text("パスワードを忘れた方")
                        .fontWeight(.heavy)
                        .font(.system(size: 13))
                        .foregroundColor(.customBlue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                        .padding(.vertical, 8)
                }
                
                Button {
                    viewModel
                        .signInWithEmail {
                            appState.isLogin = true
                        }
                } label: {
                    Text("ログイン")
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                        .bold()
                        .frame(width: UIScreen.main.bounds.width-40, height: 50)
                        .background(viewModel.isEnabledTappedLoginButton ? Color.customBlue: Color.customBlue.opacity(0.2))
                        .cornerRadius(32)
                        .padding(.top, 8)
                        .padding(.horizontal,16)
                }
                .disabled(!viewModel.isEnabledTappedLoginButton)
                
                Text("または")
                    .foregroundColor(.gray)
                    .font(.system(size: 17))
                    .bold()
                    .padding(.vertical, 16)
                
                Button {
                    viewModel.signInWithAppleObject.signInWithApple()
                } label: {
                    SignInWithAppleButton()
                        .frame(height:50)
                        .cornerRadius(32)
                }.frame(width: UIScreen.main.bounds.width-32,height:50)
            }
        }
        .navigationTitle("🔑ログイン")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.isVisibleValidateAlert) {
            Alert(
                title: Text("入力内容が間違っています")
                    .bold(),
                message: Text("メールアドレス、またはパスワードが違います。再度正しく入力してください。")
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

extension View {
    public func gradientForegroundColor() -> some View {
        self.overlay(.linearGradient(Gradient(colors: [.white, .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}

struct LoginView_preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
//                        SignUpWithAppleButton()
//                            .frame(height:50)
//                            .cornerRadius(32)
//
