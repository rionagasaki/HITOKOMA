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
    @State private var signInWithAppleObject = SignInWithAppleObject()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack{
                Color.white
                VStack(alignment:.leading ,spacing: 20){
                    Circle().size(width: 200, height: 200).foregroundColor(.yellow)
                    HStack{
                        Circle().size(width: 200, height: 200).foregroundColor(.blue).padding(.top,-120)
                        Circle().size(width: 200, height: 200).foregroundColor(.orange).padding(.top,30)
                    }
                    BackgroundView(startColor: .purple, endColor: .orange).frame(width: 300, height: 300).blur(radius: 40).rotation3DEffect(.degrees(Double(180)), axis: (x:0,y:0,z:1))
                }.blur(radius: 40)
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
                                    Image(systemName: "person").foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .trailing, endPoint: .leading)).padding(.all,5).background(Color.black.opacity(0.7)).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth:0.5))
                                    TextField("Username", text: viewStore.binding(get: {
                                        $0.usernameText
                                    }, send: {
                                        .enterUsernameText($0)
                                    })).preferredColorScheme(.dark).foregroundColor(Color.white).textInputAutocapitalization(.none).textContentType(.emailAddress)
                                }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.2)).cornerRadius(16)
                            }
                            HStack {
                                Spacer()
                                Image(systemName: "envelope.open.fill").foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .trailing, endPoint: .leading)).padding(.all,5).background(Color.black.opacity(0.7)).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth:0.5))
                                TextField("Email", text: viewStore.binding(get: {
                                    $0.emailText
                                }, send: {
                                    .enterEmailText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white).textInputAutocapitalization(.none).textContentType(.emailAddress)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.2)).cornerRadius(16)
                            HStack {
                                Spacer()
                                Image(systemName: "key.fill").foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .trailing, endPoint: .leading)).padding(.vertical,5).padding(.horizontal,9).background(Color.black.opacity(0.7)).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth:0.5))
                                SecureField("Password",text:viewStore.binding(get: {
                                    $0.passwordText
                                }, send: {
                                    .enterPasswordText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white.opacity(0.9)).textInputAutocapitalization(.none).textContentType(.password)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.2)).cornerRadius(16)
                            Button {
                                if isLogin{
                                    Auth.auth().signIn(withEmail: viewStore.state.emailText, password: viewStore.state.passwordText){ authResult, error in
                                        if error != nil { return }
                                        self.appState.isLogin = true
                                    }
                                }else{
                                    Auth.auth().createUser(withEmail: viewStore.state.emailText, password: viewStore.state.passwordText) { authResult, error in
                                        if error != nil { return }
                                        guard let authResult = authResult else { return }
                                        self.registerFirestore(username: viewStore.state.usernameText , email: authResult.user.email!, uid: authResult.user.uid) {
                                            registerFunctions().createCustomerId(email: authResult.user.email!) { result, error in
                                                if error != nil {
                                                    print("functionError\(error)")
                                                    return }
                                                print(result)
                                                self.appState.isLogin = true
                                            }
                                        }
                                    }
                                }
                            } label: {
                                GeometryReader { geometry in
                                    ZStack{
                                        AngularGradient(gradient: Gradient(colors: [.red,.blue]), center: .center, angle: .degrees(0)).blendMode(.overlay).blur(radius: 8).mask(
                                            RoundedRectangle(cornerRadius: 16).frame(height:45).frame(maxWidth:geometry.size.width - 16).blur(radius: 8.0))
                                        Text(isLogin ? "Sign In":"アカウント作成").gradientForegroundColor().font(Font.body.bold()).frame(height:50).frame(width:geometry.size.width-20).background(.thickMaterial).cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1))
                                    }
                                }
                            }.frame(height:50)
                            Button {
                                registerFunctions().createCheckout()
                            } label: {
                                Text("テストボタン")
                            }

                            HStack{
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
            }
        }
    }
    
    func registerFirestore(username:String, email:String, uid:String, completionHandler:@escaping ()-> Void){
        let db = Firestore.firestore()
        db.collection("User").document(uid).setData([
            "username": username,
            "email":email
        ]){ error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                completionHandler()
            }
        }
    }
}

struct LoginCardView_Previews: PreviewProvider {
    static var previews: some View {
        LoginState.initial
    }
}

extension View {
    public func gradientForegroundColor() -> some View {
        self.overlay(.linearGradient(Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)).mask(self)
    }
}

class registerFunctions{
    lazy var functions = Functions.functions()
    func createCustomerId(email:String, completion:@escaping (String?, Error?) -> Void){
        let data:[String: Any] = [
            "email": email
        ]
        functions.httpsCallable("createAccount").call(data){ result, error in
            if let error = error {
                print("errorがあります",error.localizedDescription)
                completion(nil, error)
            }else if let data = result?.data as? [String: Any],
                     let customerId = data["customerId"] as? String {
                completion(customerId, nil)
            }
        }
    }
    
    func createCheckout(){
        functions.httpsCallable("createCheckout").call { result, error in
            if let error = error {
                print("errorがあります\(error)")
            }else{
              print(result)
            }
        }
    }
}

