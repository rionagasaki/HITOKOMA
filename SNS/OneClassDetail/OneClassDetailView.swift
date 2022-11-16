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
    @State private var openCharge: Bool = false
    let lessonImageURLString: String
    let mentorIconImageURLString: String
    let alreadyBuy: Bool
    let lessonId: String
    let mentorName: String
    let lessonTitle: String
    let lessonContent: String
    let budgets: Int
    var body: some View {
        VStack{
            ScrollView {
                VStack{
                    GeometryReader{ geometry in
                        WebImage(url: URL(string: lessonImageURLString)).resizable().frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? 300+geometry.frame(in: .global).minY :300).offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY: 0)
                    }.frame(height: 300)
                    Text(lessonTitle).font(.system(size: 25)).fontWeight(.bold)
                    NavigationLink {
                        UserProfileView()
                    } label: {
                        HStack{
                            WebImage(url: URL(string: lessonImageURLString)).resizable().frame(width: 40, height: 40).clipShape(Circle())
                            Text(mentorName).bold().foregroundColor(.black)
                            Spacer()
                        }
                    }.padding(.leading,16)
                    HStack{
                        Text("\(budgets)円/h").padding(.all,10).foregroundColor(.white).background(.green).cornerRadius(20).padding(.leading,16)
                        Spacer()
                        VStack(alignment: .leading){
                            Text("評価").font(.caption)
                            HStack{
                                ForEach(0..<5){ _ in
                                    Image(systemName: "star.fill").resizable().frame(width: 20, height: 20).foregroundColor(.orange)
                                }
                            }.padding(.trailing,16)
                        }
                    }
                    Text(lessonContent).padding(.horizontal,16).padding(.top,10)
                    Spacer()
                }
            }.ignoresSafeArea()
            
            if alreadyBuy {
                VStack{
                    Divider()
                    HStack{
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                        Text("購入済み")
                    }
                    NavigationLink {
                        ChatView()
                    } label: {
                        RichButton(buttonText: "やり取りをする", buttonImage: "bird.fill")
                    }
                }.background(.ultraThinMaterial)
            }else{
                VStack{
                    Divider()
                    CheckoutView(model: MyBackendModel(), amount: budgets, lessonId: lessonId)
                }.frame(maxWidth:.infinity, maxHeight: 100).background(.ultraThinMaterial)
            }
        }
    }
}

struct OneClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OneClassDetailView(lessonImageURLString: "", mentorIconImageURLString: "", alreadyBuy: false, lessonId: "", mentorName: "Rio", lessonTitle: "", lessonContent: "", budgets: 0)
    }
}
