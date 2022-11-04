//
//  RegisterView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/14.
//

import SwiftUI
import ComposableArchitecture
import FirebaseAuth
import FirebaseFunctions

struct RegisterView: View {
    @State var email:String = ""
    let store:Store<LoginState,LoginAction>
    lazy var functions = Functions.functions()
    var body: some View{
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
                                Text("Sign Up").font(Font.largeTitle.bold()).foregroundColor(.white)
                            }
                            HStack {
                                Spacer()
                                Image(systemName: "envelope.open.fill").tint(Color.white)
                                TextField("Email", text: viewStore.binding(get: {
                                    $0.emailText
                                }, send: {
                                    .enterEmailText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white).textInputAutocapitalization(.none).textContentType(.emailAddress)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.1)).cornerRadius(16)
                            HStack {
                                Spacer()
                                Image(systemName:"key").foregroundColor(Color.white)
                                SecureField("Password",text:viewStore.binding(get: {
                                    $0.passwordText
                                }, send: {
                                    .enterPasswordText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white.opacity(0.9)).textInputAutocapitalization(.none).textContentType(.password)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.purple.opacity(0.1)).cornerRadius(16)
                            Button{
                                print("aaa")
                            } label: {
                                Text("すでにアカウントをお持ちの方").underline().tint(Color.white).font(.footnote)
                            }.padding(.leading, 70)
                            
                            Button {
                                Auth.auth().createUser(withEmail: viewStore.state.emailText, password: viewStore.state.passwordText) { authResult, error in
                                    let url = URL(string: "https://asia-northeast1-marketsns.cloudfunctions.net/createCustomer")
                                    callCloudFunctions().setFunctions(email: authResult?.user.email ?? "") { customerId in
                                        SetToFirestore().registerUserInfoFirestore(uid: authResult!.user.uid, username: "", email: "", customerId: customerId) {
                                            
                                        }
                                    }
                                }
                            } label: {
                                GeometryReader { geometry in
                                    ZStack{
                                        AngularGradient(gradient: Gradient(colors: [.red,.blue]), center: .center, angle: .degrees(0)).blendMode(.overlay).blur(radius: 8).mask(
                                            RoundedRectangle(cornerRadius: 16).frame(height:50).frame(maxWidth:geometry.size.width - 16).blur(radius: 8.0))
                                        Text("").gradientForegroundColor().font(Font.body.bold()).frame(height:45).frame(width:geometry.size.width-20).background(Color.black.opacity(0.8)).cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1))
                                    }
                                }
                            }.frame(height:50)
                        }.padding()
                    }.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1)).background(.regularMaterial).cornerRadius(20).padding()
                }.rotation3DEffect(Angle(degrees: 180), axis: (x:0, y:1, z:0)).shadow(radius: 20, x: 0, y: 20)
            }.ignoresSafeArea()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginState.initial2
    }
}
