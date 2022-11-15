//
//  OneClassDetailView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI
import FirebaseFunctions

struct OneClassDetailView: View {
    @State private var openCharge: Bool = false
    let lessonImageURLString: String
    let mentorIconImageURLString: String
    let mentorName: String
    let lessonTitle: String
    let lessonContent: String
    let budgets: Int
    var body: some View {
        VStack{
            ScrollView {
                VStack{
                    GeometryReader{ geometry in
                        AsyncImage(url: URL(string: lessonImageURLString)) { image in
                            image.resizable().frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? 300+geometry.frame(in: .global).minY :300).offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY: 0)
                        } placeholder: {
                            ProgressView().frame(width: UIScreen.main.bounds.width, height:300).background(.gray.opacity(0.2))
                        }
                    }.frame(height: 300)
                    Text(lessonTitle).font(.system(size: 25)).fontWeight(.bold)
                    NavigationLink {
                        UserProfileView()
                    } label: {
                        HStack{
                            AsyncImage(url: URL(string: mentorIconImageURLString)) { image in
                                image.resizable().frame(width: 40, height: 40).clipShape(Circle())
                            } placeholder: {
                                ProgressView().frame(width: 40, height: 40).background(.gray.opacity(0.2)).clipShape(Circle())
                            }
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
            ZStack{
                VStack{
                    CheckoutView(amount: budgets)
                }.frame(maxWidth:.infinity, maxHeight: 100).background(.ultraThinMaterial)
            }
        }
    }
}

struct OneClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OneClassDetailView(lessonImageURLString: "", mentorIconImageURLString: "", mentorName: "Rio", lessonTitle: "", lessonContent: "", budgets: 0)
    }
}
