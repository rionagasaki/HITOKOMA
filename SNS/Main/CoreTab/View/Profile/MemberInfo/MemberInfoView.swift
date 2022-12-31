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
    @StateObject private var viewModel = MemberInfoViewModel()
    @EnvironmentObject var user: User
    @FocusState var isClosed:Bool
    
    let color1 = Color(red: 67/255, green: 92/255, blue: 130/255)
    let color2 = Color(red: 71/255, green: 117/255, blue: 132/255)
    
    var body: some View {
        ScrollView {
            VStack{
                Image(image.others.ramen.name)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 150)
                    .overlay(
                        Button(action: {
                            print("aaa")
                        }, label: {
                            ZStack {
                                Color.black.opacity(0.5)
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .frame(width: 60, height: 50)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                            }
                        })
                    )
                HStack{
                    Button {
                        print("aa")
                    } label: {
                        ZStack(alignment: .bottomTrailing){
                            WebImage(url: URL(string: user.profileImage))
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .background(Circle().stroke(.white, lineWidth: 5))
                                .padding(.leading, 16)
                                .padding(.top, -35)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width:30, height:30)
                                .clipShape(Circle())
                                .foregroundColor(.customBlue)
                                .background(Circle().stroke(.white, lineWidth: 3))
                                .background(Color.white.clipShape(Circle()))
                                .padding(.top, -8)
                                .padding(.leading, -8)
                        }
                    }
                    
                    Spacer()
                }
                Divider()
                TextField(user.username, text: $viewModel.usernameField, prompt: Text("ユーザーネーム"))
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.customLightGray, lineWidth: 2))
                    .padding(.horizontal, 16)
                    .padding(.top, 5)
                
                TextField("aaaa", text: $viewModel.ageField, prompt: Text("年齢"))
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.customLightGray, lineWidth: 2))
                    .padding(.horizontal, 16)
                    .padding(.top, 5)
                
                HStack(alignment: .center){
                    Button {
                        viewModel.genderField = .man
                    } label: {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .foregroundColor(viewModel.genderField == .man ? .blue: .customLightGray)
                            Text("男性")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                                .foregroundColor(viewModel.genderField == .man ? .customGray: .customLightGray)
                                
                        }
                        
                    }.padding(.leading, 32)
                    Spacer()
                    Button {
                        viewModel.genderField = .woman
                    } label: {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .foregroundColor(viewModel.genderField == .woman ? .customRed2: .customLightGray)
                            Text("女性")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                                .foregroundColor(viewModel.genderField == .woman ? .customGray: .customLightGray)
                        }
                    }
                    Spacer()
                    Button {
                        viewModel.genderField = .others
                    } label: {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .foregroundColor(viewModel.genderField == .others ? .yellow: .customLightGray)
                            Text("その他")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                                .foregroundColor(viewModel.genderField == .others ? .customGray: .customLightGray)
                        }
                    }.padding(.trailing, 32)
                }.padding(.top, 8)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.customBlue)
                    .frame(
                        width: (UIScreen.main.bounds.width/3)-40,
                        height: 2
                    )
                
                TextField("aaaa", text: $viewModel.instagramField, prompt: Text("SNSアカウント"))
                    .padding(.leading, 10)
                    .frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.customLightGray, lineWidth: 2))
                    .padding(.horizontal, 16)
                    .padding(.top, 5)
                Divider()
                Text("経歴")
                    .
                Spacer()
            }
        }
    }
}

struct MemberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoView()
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
