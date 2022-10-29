//
//  HomeView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI

struct HomeView:View{
    @State private var contentOffSet = CGFloat(0)
    let screenSize = UIScreen.main.bounds.width
    
    var body: some View{
        
        ZStack {
           
            ScrollView {
                VStack(alignment: .center){
                    GeometryReader{ geometry in
                        Image("header").resizable().foregroundColor(.red).frame(height: geometry.frame(in: .global).minY > 0 ? 270+geometry.frame(in: .global).minY:270).overlay(LinearGradient(colors: [.white.opacity(0), .white.opacity(0.5)], startPoint: .top, endPoint: .bottom)).offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY:0).padding(.top,25)
                    }.frame(height:270)
                    
                    HStack{
                        Text("カテゴリー").foregroundColor(.black).bold().font(.system(size: 18)).padding()
                        Spacer()
                    }
                    HStack{
                        NavigationLink {
                            CategorizationView()
                        } label: {
                            Category(categoryText: "IT", categoryImage: "computer").padding(.leading,10)
                        }
                        Category(categoryText: "投資", categoryImage: "money").padding(.leading,10)
                        Category(categoryText: "学ぶ", categoryImage: "study").padding(.leading,10)
                        Category(categoryText: "コーヒー", categoryImage: "coffee").padding(.leading,10)
                    }
                    Group{
                        HStack{
                            Text("話題のひとこま").foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            Section{
                                HStack{
                                    Spacer()
                                    NavigationLink {
                                        OneClassDetailView()
                                    } label: {
                                        OneClassView()
                                    }
                                    Spacer()
                                    OneClassView()
                                    Spacer()
                                    OneClassView()
                                }
                            }
                        }
                        HStack{
                            Text("リクエスト").foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                Spacer()
                                NavigationLink {
                                    RequestDetailView()
                                } label: {
                                    OneRequestView()
                                }
                                Spacer()
                                OneRequestView()
                                Spacer()
                                OneRequestView()
                                Spacer()
                                OneRequestView()
                            }
                        }
                        HStack{
                            Text("評価が高いひとこま").foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                Spacer()
                                OneClassView()
                                Spacer()
                                OneClassView()
                                Spacer()
                                OneClassView()
                            }
                        }
                        HStack{
                            Text("評価が高いひとこま").foregroundColor(.black).bold().font(.system(size: 18)).padding(.leading,16)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                Spacer()
                                OneClassView()
                                Spacer()
                                OneClassView()
                                Spacer()
                                OneClassView()
                            }
                        }
                    }.padding(.top,10)
                    
                }.padding(.bottom,150)
            }.ignoresSafeArea()
        }
    }
}

struct HomeHeaderView: View {
    var body: some View{
        ZStack{
            Image("header").resizable().frame(width: UIScreen.main.bounds.width-20, height: 200).overlay(LinearGradient(colors: [.white.opacity(0), .white.opacity(0.5)], startPoint: .top, endPoint: .bottom).offset(y:30))
            
        }.padding(.top,50)
    }
}


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
