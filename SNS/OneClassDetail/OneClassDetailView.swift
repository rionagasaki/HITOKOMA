//
//  OneClassDetailView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI
import FirebaseFunctions
import SDWebImageSwiftUI

struct OneClassDetailView: View {
    @EnvironmentObject var user:User
    @State private var openCharge: Bool = false
    @State var alreadyChat: Bool = false
    @State var preChatRoomData: ChatRoomData?
    @State var chatroomData:ChatRoomData?
    let lessonImageURLString: String
    let mentorIconImageURLString: String
    let lessonId: String
    let mentorName: String
    let mentorUid: String
    let lessonTitle: String
    let lessonContent: String
    let budgets: Int

    var body: some View {
        VStack{
            ScrollView {
                VStack{
                    GeometryReader{ geometry in
                        WebImage(url: URL(string: lessonImageURLString)).resizable().frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? 250+geometry.frame(in: .global).minY :250).offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY: 0)
                    }.frame(height: 250)
                    Text(lessonTitle).font(.system(size: 25)).fontWeight(.bold)
                    Divider()
                    NavigationLink {
                        UserProfileView()
                    } label: {
                        HStack{
                            WebImage(url: URL(string: mentorIconImageURLString)).resizable().frame(width: 40, height: 40).clipShape(Circle())
                            VStack(alignment: .leading){
                                Text(mentorName).bold().foregroundColor(.black)
                                Text("男性").font(.caption).foregroundColor(.black)
                                Text("20代前半").font(.caption).foregroundColor(.black)
                                HStack{
                                    Text("機密保持契約(NDA)").foregroundColor(.black)
                                    Image(systemName: "checkmark").foregroundColor(.green)
                                }.font(.caption)
                                
                            }
                            Spacer()
                        }
                    }.padding(.leading,16)
                    Divider()
                    VStack{
                        Text("*この講座は購入前に事前チャットする必要があります。").font(.caption)
                        NavigationLink {
                            ChatView(chatUserName: mentorName, chatUserUid: mentorUid, chatData: preChatRoomData, chatStyle: .beforePurchase)
                        } label: {
                            HStack{
                                Image("mail").resizable().frame(width:30,height: 30)
                                Text("購入前チャット").font(.callout).foregroundColor(.black)
                            }.padding(.horizontal,10).background(.ultraThinMaterial).cornerRadius(3).overlay(RoundedRectangle(cornerRadius: 3).stroke(.black.opacity(0.3), lineWidth: 1))
                        }
                    }
                    LessonQuestionView(lessonImageURLString: lessonImageURLString, lessonTitle: lessonTitle, lessonId: lessonId)
                    EvaluationView()
                    VStack(alignment: .leading){
                        HStack{
                            Text("レッスン内容").bold()
                            Spacer()
                        }.padding(.leading, 16)
                        HStack{
                            Text(lessonContent)
                            Spacer()
                        }.padding(.leading, 16)
                    }
                }
            }
            if self.user.purchasedLesson.contains(lessonId) {
                HStack(alignment: .bottom){
                    Text("\(budgets)円/h").padding(.all,10).foregroundColor(.white).background(.black).cornerRadius(20).padding(.leading,16)
                    Spacer()
                    VStack{
                        Divider()
                        HStack{
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            Text("購入済み")
                        }
                        NavigationLink {
                            ChatView(chatUserName: mentorName, chatUserUid: mentorUid, chatData: self.chatroomData, chatStyle: .afterPurchase)
                        } label: {
                            RichButton(buttonText: "やり取りをする", buttonImage: "bird.fill")
                        }
                    }
                }.background(.ultraThinMaterial).onAppear{
                    FetchFromFirestore().fetchChatRoomInfoFromFirestore(path: "Chat", mentorUid: mentorUid) { chatroomData in
                        self.chatroomData = chatroomData
                    }
                }
            }else{
                HStack {
                    Text("\(budgets)円/h").padding(.all,10).foregroundColor(.white).background(.green).cornerRadius(20).padding(.leading,16)
                    Spacer()
                    VStack{
                        Divider()
                        CheckoutView(model: MyBackendModel(), amount: budgets, lessonId: lessonId).frame(height: 100)
                    }
                }.background(.ultraThinMaterial)
            }
        }.onAppear{
            UITabBar.appearance().isHidden = true
            FetchFromFirestore().fetchChatRoomInfoFromFirestore(path: "BeforePurchaseChat", mentorUid: mentorUid) { preChatRoom in
                self.preChatRoomData = preChatRoom
            }
        }
    }
}


struct OneClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OneClassDetailView(lessonImageURLString: "", mentorIconImageURLString: "", lessonId: "", mentorName: "Rio", mentorUid: "", lessonTitle: "", lessonContent: "", budgets: 0).environmentObject(User())
    }
}

struct EvaluationView:View {
    var body: some View{
        Divider()
        HStack{
            VStack(alignment: .leading){
                Text("評価とレビュー").bold()
                HStack{
                    Text("総評価").font(.caption)
                    ForEach(0..<5){ _ in
                        Image(systemName: "star.fill").resizable().frame(width: 20, height: 20).foregroundColor(.orange)
                    }
                    Text("(3)")
                }.padding(.leading, 16)
            }.padding(.leading, 16)
            Spacer()
        }
        Divider()
    }
}

struct LessonQuestionView: View {
    @State var shoudOpenMakeQuestionScreen:Bool = false
    let lessonImageURLString: String
    let lessonTitle: String
    let lessonId: String
    var body: some View{
        VStack{
            Divider()
            VStack {
                VStack(alignment: .leading){
                    HStack{
                        Text("講座に関する質問").bold()
                        Spacer()
                        Button {
                            print("aaaa")
                        } label: {
                            Text("もっと見る").font(.subheadline).padding(.trailing,16)
                        }
                        
                    }.padding(.leading,16)
                    ForEach(0..<3) { _ in
                        Text("この講座はわかりやすいですか??").font(.caption)
                    }.padding(.leading,16)
                }
                VStack{
                    Button {
                        self.shoudOpenMakeQuestionScreen = true
                    } label: {
                        HStack{
                            Image(systemName: "questionmark.app.fill").resizable().frame(width:20,height: 20).foregroundColor(.black)
                            Text("質問する").font(.callout).foregroundColor(.black)
                        }.padding(.horizontal,10).padding(.vertical,5).background(.ultraThinMaterial).cornerRadius(3).overlay(RoundedRectangle(cornerRadius: 3).stroke(.black.opacity(0.3), lineWidth: 1))
                    }
                }
            }
        }.sheet(isPresented: $shoudOpenMakeQuestionScreen) {
            MakeQuestionView(lessonImageURL: lessonImageURLString, lessonTitle: lessonTitle, lessonID: lessonId)
        }
    }
}
