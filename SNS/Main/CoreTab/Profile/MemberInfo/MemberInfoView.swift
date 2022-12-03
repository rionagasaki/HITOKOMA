//
//  MemberInfoView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/15.
//

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI

struct MemberInfoView: View {
    @EnvironmentObject var user: User
    @FocusState var isClosed:Bool
    @State var displayName:String
    @State var displayGender: String
    @State var displayAge: String
    @State var displayInstagramAccount: String = ""
    @State var displayTwitterAccount: String = ""
    @State var displayFacebookAccount: String = ""
    @State var showImageModal: Bool = false
    @State var profileImage: UIImage?
    
    
    let color1 = Color(red: 67/255, green: 92/255, blue: 130/255)
    let color2 = Color(red: 71/255, green: 117/255, blue: 132/255)
    
    var body: some View {
        ZStack(alignment: .center){
            VStack {
                Form {
                    Section {
                        VStack{
                            Text("プロフィール画像").bold()
                            Button {
                                self.showImageModal = true
                            } label: {
                                VStack{
                                    if user.profileImage == ""{
                                        Image(uiImage: profileImage ?? UIImage(named: "bird")!).resizable().frame(width:100, height: 100).clipShape(Circle())
                                    }else{
                                        WebImage(url: URL(string: user.profileImage)).resizable().frame(width:100, height: 100).clipShape(Circle())
                                    }
                                }.clipShape(Circle()).overlay(Circle().stroke(.gray.opacity(0.6), lineWidth: 0.5)).shadow(radius: 1)
                            }.buttonStyle(BorderlessButtonStyle())
                            VStack(alignment: .leading){
                                Text("ユーザーネーム").bold().foregroundColor(.black).padding(.leading,16)
                                TextField("ユーザーネーム", text: $displayName).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1)).padding(.horizontal,20)
                            }
                        }.frame(width:UIScreen.main.bounds.width-40, height:200)
                    } header: {
                        HStack{
                            Image(systemName: "person.fill").resizable().frame(width:20, height:20)
                            Text("メイン情報").bold()
                        }
                    }
                    Section {
                        DetailProfileView(displayGender: $displayGender, displayAge: $displayAge, displayInstagramAccount: $displayInstagramAccount, displayTwitterAccount: $displayTwitterAccount, displayFacebookAccount: $displayFacebookAccount)
                    } header: {
                        HStack{
                            Image(systemName: "questionmark.app.fill").resizable().frame(width:20, height:20)
                            Text("追加情報").bold()
                        }
                    }
                    Section {
                        Group {
                            HStack{
                                Image("profile").resizable().frame(width:20, height:20)
                                Text("自己紹介")
                            }.padding(.leading, 16)
                            TextEditor(text: $displayName).frame(height: 150).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16)
                            
                            HStack{
                                Image("calendar").resizable().frame(width:20, height:20)
                                Text("スケジュール")
                            }.padding(.leading, 16)
                            TextEditor(text: $displayName).frame(height: 150).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16)
                        }
                    } header: {
                        HStack{
                            Image(systemName: "checkmark.square.fill").resizable().frame(width:20, height:20)
                            Text("アピール・稼働時間").bold()
                        }
                    }
                }.listStyle(DefaultListStyle()).onAppear{
                    UITableView.appearance().allowsFocus = false
                }
                Button{
                    guard let profileImage = profileImage else { return }
                    RegisterStorage().refisterUserInfo(profileImage: profileImage) { url in
                        let urlString = url.absoluteString
                        UpdateFirestore().updateUserInfoFirestore(profileImageURL: urlString){
                            self.user.profileImage = urlString
                        }
                    }
                } label: {
                    RichButton(buttonText: "更新する", buttonImage: "checkmark.circle.fill")
                }.buttonStyle(BorderlessButtonStyle())
            }
        }.navigationTitle("会員情報").navigationBarTitleDisplayMode(.large).sheet(isPresented: $showImageModal) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $profileImage).onAppear{
                
            }.gesture(TapGesture().onEnded({ _ in
                self.isClosed = false
            }))
        }
    }
}
struct MemberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoView(displayName: "", displayGender: "", displayAge: "")
    }
}

struct DetailProfileView:View {
    @Binding var displayGender: String
    @Binding var displayAge: String
    @Binding var displayInstagramAccount: String
    @Binding var displayTwitterAccount: String
    @Binding var displayFacebookAccount: String
    @FocusState var isClosed:Bool
    
    var body: some View{
        Group{
            VStack(alignment: .leading){
                Text("性別(任意)").padding(.leading, 10)
                MenuView().padding(.horizontal,16)
            }
            
            VStack(alignment: .leading){
                Text("SNSアカウント(任意)").padding(.leading, 10)
                HStack{
                    Image("instagram").resizable().background(.white).frame(width:25, height:25).cornerRadius(6)
                    TextField("instagram", text: $displayInstagramAccount).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16).padding(.vertical,5)
                }.padding(.leading, 10)
                HStack{
                    Image("Twitter").resizable().background(.white).frame(width:25, height:25).cornerRadius(6)
                    TextField("twitter", text: $displayTwitterAccount).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16).padding(.vertical,5)
                }.padding(.leading, 10)
                HStack{
                    Image("facebook").resizable().background(.white).frame(width:25, height:25).cornerRadius(6)
                    TextField("facebook", text: $displayFacebookAccount).padding(.all, 7).background(.white).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.horizontal,16).padding(.vertical,5)
                }.padding(.leading, 10)
            }
        }.gesture(TapGesture().onEnded({ _ in
            self.isClosed = true
        }))
    }
}


struct MenuView: View {
    var body: some View {
        Menu {
            Button {
                print("aaaa")
            } label: {
                HStack{
                    Image("man").resizable().frame(width:30, height:30)
                    Text("男性")
                }
            }
            
            Button {
                print("bbbb")
            } label: {
                HStack{
                    Image("woman").resizable().frame(width:20, height:20)
                    Text("女性")
                }
            }
            
            Button {
                print("bbbb")
            } label: {
                Text("未選択")
            }
        } label: {
            VStack(spacing: 5){
                HStack{
                    Text("未選択")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.blue)
                        .font(Font.system(size: 20, weight: .bold))
                }
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
            }.padding(.vertical,16)
        }
    }
}
