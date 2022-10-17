//
//  LoginCardView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/23.
//

import SwiftUI
import ComposableArchitecture
import FirebaseAuth

struct LoginView: View {
    
    let store:Store<LoginState,LoginAction>
    @State private var halfModal:Bool = false
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack{
                Color.white
                VStack{
                    BackgroundView(startColor: .orange, endColor: .green)
                }
                Color(.displayP3, red: 195/255,  green: 208/255, blue: 232/255, opacity: 0.4)
                VStack{
                    VStack{
                        VStack(alignment: .leading, spacing: 16) {
                            HStack{
                                Image(systemName: "key")
                                Text("Sign In").font(Font.largeTitle.bold()).foregroundColor(.white)
                            }
                            HStack {
                                Spacer()
                                Image(systemName: "envelope.open.fill").tint(Color.white)
                                TextField("Email", text: viewStore.binding(get: {
                                    $0.emailText
                                }, send: {
                                    .enterEmailText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white).textInputAutocapitalization(.none).textContentType(.emailAddress)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.black.opacity(0.1)).cornerRadius(16)
                            HStack {
                                Spacer()
                                Image(systemName:"key").foregroundColor(Color.white)
                                SecureField("Password",text:viewStore.binding(get: {
                                    $0.passwordText
                                }, send: {
                                    .enterPasswordText($0)
                                })).preferredColorScheme(.dark).foregroundColor(Color.white.opacity(0.9)).textInputAutocapitalization(.none).textContentType(.password)
                            }.frame(height:52).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1)).background(Color.black.opacity(0.1)).cornerRadius(16)
                            Button{
                                self.halfModal = false
                            } label: {
                                Text("新規登録はこちらから").underline().tint(Color.white).font(.footnote)
                            }.padding(.leading, 90)
                            
                            Button {
                                //                                viewStore.send(.loginButtonTapped(viewStore.state.emailText, viewStore.state.passwordText))
                                Auth.auth().createUser(withEmail: viewStore.state.emailText, password: viewStore.state.passwordText) { authResult, error in
                                    print(authResult)
                                    
                                }
                            } label: {
                                GeometryReader { geometry in
                                    ZStack{
                                        AngularGradient(gradient: Gradient(colors: [.red,.blue]), center: .center, angle: .degrees(0)).blendMode(.overlay).blur(radius: 8).mask(
                                            RoundedRectangle(cornerRadius: 16).frame(height:50).frame(maxWidth:geometry.size.width - 16).blur(radius: 8.0))
                                        Text("Sign In").gradientForegroundColor().font(Font.body.bold()).frame(height:45).frame(width:geometry.size.width-20).background(Color.black.opacity(0.8)).cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1))
                                    }
                                }
                            }.frame(height:50)
                            Button {
                                print("aaa")
                            } label: {
                                
                                //                        Text("appleでサインイン").frame(width: <#T##CGFloat?#>, height: <#T##CGFloat?#>, alignment: <#T##Alignment#>).foregroundColor(.white).background(.black).cornerRadius(10).padding()
                            }
                            
                        }.padding()
                    }.overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1)).background(.regularMaterial).cornerRadius(20).padding()
                }
            }.ignoresSafeArea()
            
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

extension View {
    func halfModal<Sheet: View>(
        isShow: Binding<Bool>,
        @ViewBuilder sheet: @escaping () -> Sheet,
        onEnd: @escaping () -> ()
    ) -> some View {
        return self
            .background(
                HalfModalSheetViewController(
                    sheet: sheet(),
                    isShow: isShow,
                    onClose: onEnd
                )
            )
    }
}

struct HalfModalSheetViewController<Sheet: View>: UIViewControllerRepresentable {
    
    var sheet: Sheet
    @Binding var isShow: Bool
    var onClose: () -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(
        _ viewController: UIViewController,
        context: Context
    ) {
        if isShow {
            let sheetController = CustomHostingController(rootView: sheet)
            sheetController.presentationController!.delegate = context.coordinator
            viewController.present(sheetController, animated: true)
        } else {
            viewController.dismiss(animated: true) { onClose() }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfModalSheetViewController
        
        init(parent: HalfModalSheetViewController) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.isShow = false
        }
    }
    
    class CustomHostingController<Content: View>: UIHostingController<Content> {
        override func viewDidLoad() {
            super.viewDidLoad()
            if let sheet = self.sheetPresentationController {
                sheet.detents = [.medium(),]
                sheet.prefersGrabberVisible = true
            }
        }
    }
    
}
