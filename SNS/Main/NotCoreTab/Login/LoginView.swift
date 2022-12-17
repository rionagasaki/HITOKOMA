//
//  LoginCardView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/23.
//

import SwiftUI
import ComposableArchitecture
import FirebaseAuth
import FirebaseFirestore
import FirebaseFunctions

struct LoginView: View {
    lazy var functions = Functions.functions()
    let store:Store<LoginState,LoginAction>
    @EnvironmentObject var appState:AppState
    @State private var rotationAngle = 0.0
    @State private var halfModal:Bool = false
    @State private var isLogin:Bool = true
    @State private var validateAlert: Bool = false
    @State private var signInWithAppleObject = SignInWithAppleObject()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack{
                Color.white
                VStack{
                    VStack{
                        VStack(alignment: .leading, spacing: 16) {
                            HStack{
                                Image(systemName: "key")
                                Text(isLogin ? "Sign In" : "アカウント作成").font(Font.largeTitle.bold()).foregroundColor(.white)
                            }
                            if !isLogin{
                                HStack {
                                    Spacer()
                                    Image(systemName: "person").foregroundStyle(.white).padding(.all,5).background(Color.black.opacity(0.7)).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth:0.5))
                                    TextField("Username", text: viewStore.binding(get: {
                                        $0.usernameText
                                    }, send: {
                                        .enterUsernameText($0)
                                    })).preferredColorScheme(.dark).foregroundColor(Color.white).textInputAutocapitalization(.none).textContentType(.emailAddress)
                                }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.2)).cornerRadius(16)
                            }
                            HStack {
                                Spacer()
                                Image(systemName: "envelope.open.fill").foregroundStyle(LinearGradient(colors: [.white, .white], startPoint: .trailing, endPoint: .leading)).padding(.all,5).background(Color.black.opacity(0.7)).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth:0.5))
                                TextField("Email", text: viewStore.binding(get: {
                                    $0.emailText
                                }, send: {
                                    .enterEmailText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white).textInputAutocapitalization(.none).textContentType(.emailAddress)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.2)).cornerRadius(16)
                            HStack {
                                Spacer()
                                Image(systemName: "key.fill").foregroundStyle(LinearGradient(colors: [.white, .white], startPoint: .trailing, endPoint: .leading)).padding(.vertical,5).padding(.horizontal,9).background(Color.black.opacity(0.7)).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth:0.5))
                                SecureField("Password",text:viewStore.binding(get: {
                                    $0.passwordText
                                }, send: {
                                    .enterPasswordText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white.opacity(0.9)).textInputAutocapitalization(.none).textContentType(.password)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.2)).cornerRadius(16)
                            Button {
                                if isLogin{
                                    Auth.auth().signIn(withEmail: viewStore.state.emailText, password: viewStore.state.passwordText){ authResult, error in
                                        if error != nil {
                                            self._validateAlert.wrappedValue = true
                                            return
                                        }
                                        self.appState.isLogin = true
                                    }
                                }else{
                                    // 後ほど責務を分離させる。
                                    Auth.auth().createUser(withEmail: viewStore.state.emailText, password: viewStore.state.passwordText) { authResult, error in
                                        if error != nil { return }
                                        guard authResult != nil else { return }
                                        CallCloudFunctions().setFunctions(email: authResult?.user.email ?? "") { customerId in
                                            SetToFirestore().registerUserInfoFirestore(uid: authResult!.user.uid, username:viewStore.state.usernameText, email: authResult!.user.email ?? "", customerId: customerId) {
                                                self.appState.isLogin = true
                                            }
                                        }
                                    }
                                }
                            } label: {
                                Text(isLogin ? "Sign In":"アカウント作成").foregroundColor(.white).font(.system(size: 17)).bold().frame(width: UIScreen.main.bounds.width-40, height: 50).background(Color.customBlue).cornerRadius(10)
                            }
                            
                            HStack(spacing: .zero){
                                Text(isLogin ? "新規登録は" : "すでにアカウントをお持ちの方").tint(Color.white).font(.footnote)
                                Button{
                                    withAnimation(Animation.easeInOut(duration: 0.7)) {
                                        self.rotationAngle += 180
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.4){
                                        self.isLogin.toggle()
                                    }
                                } label: {
                                    Text("こちらから").underline().tint(Color.white).font(.footnote)
                                }
                            }.padding(.leading,10)
                            ZStack{
                                Divider()
                                Text("or")
                            }
                            
                            Button {
                                if isLogin{
                                    signInWithAppleObject.signInWithApple()
                                }
                            } label: {
                                if isLogin{
                                    SignInWithAppleButton().frame(height:44).cornerRadius(16)
                                }else{
                                    SignUpWithAppleButton().frame(height:44).cornerRadius(16)
                                }
                            }.frame(height:50)
                        }.padding().rotation3DEffect(Angle(degrees: self.rotationAngle), axis:(x:0.0, y:1.0, z:0.0))
                    }.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1)).background(.white.opacity(0.2)).background(.thinMaterial).cornerRadius(20).padding().rotation3DEffect(Angle(degrees: self.rotationAngle), axis:(x:0.0, y:1.0, z:0.0))
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.white).padding(.top,50).font(.system(size: 30)).shadow(radius: 5, x: 0, y: 0)
                    }
                }.shadow(radius: 20, x: 0, y: 20)
            }.ignoresSafeArea().sheet(isPresented: $halfModal) {
                LoginState.initial2
            }.alert(isPresented: _validateAlert.projectedValue) {
                Alert(title: Text("入力内容が間違っています"),
                      message: Text("メールアドレス、またはパスワードが違います。再度正しく入力してください。"),
                      dismissButton: .default(Text("閉じる")))
            }
        }
    }
}

extension View {
    public func gradientForegroundColor() -> some View {
        self.overlay(.linearGradient(Gradient(colors: [.white, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)).mask(self)
    }
}

class registerFunctions{
    lazy var functions = Functions.functions()
    
    func createCustomerId(){
        functions.httpsCallable("stripeCreateAccount").call{ result, error in
            if let error = error {
                print(error)
                return
            }
            print("data", result)
        }
    }
    
    func createCheckout(){
        functions.httpsCallable("createCheckout").call { result, error in
            if let error = error {
                print("errorがあります\(error)")
            }else{
                let data = result?.data as? [String: Any]
                print(data)
            }
        }
    }
}

