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
    @State var profileImageURLString: String
    
    
    let color1 = Color(red: 67/255, green: 92/255, blue: 130/255)
    let color2 = Color(red: 71/255, green: 117/255, blue: 132/255)
    
    var body: some View {
        VStack{
            Image("ramen").resizable().frame(width: UIScreen.main.bounds.width, height: 150)
            HStack{
                WebImage(url: URL(string: profileImageURLString)).resizable().frame(width: 70, height: 70).clipShape(Circle()).background(Circle().stroke(.white, lineWidth: 5)).padding(.leading, 16).padding(.top, -35)
                Spacer()
                Button {
                    print("aaa")
                } label: {
                    Text("フォローする").padding(.all, 5).background(.black).foregroundColor(.white).cornerRadius(10)
                }.padding(.trailing, 16)
            }
            Divider()
            HStack(spacing: 5){
                Text("ユーザーネーム")
                TextField("", text: $displayName)
            }
            Divider()
        }
    }
}

struct MemberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MemberInfoView(displayName: "", displayGender: "", displayAge: "", profileImageURLString: "")
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
