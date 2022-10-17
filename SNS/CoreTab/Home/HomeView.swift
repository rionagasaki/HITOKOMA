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
    init(){
        UINavigationBar.appearance().barTintColor = UIColor.black
    }
    var body: some View{
        ZStack{
            VStack(alignment:.leading ,spacing: 50){
                BackgroundView(startColor: .green, endColor: .red).frame(width: 300, height: 300)
                BackgroundView(startColor: .purple, endColor: .orange).frame(width: 300, height: 300).rotation3DEffect(.degrees(Double(180)), axis: (x:0,y:0,z:1))
            }
            Color.init(uiColor: UIColor(displayP3Red: 40/255, green: 42/255, blue: 51/255, alpha: 1)).opacity(0.3).background(.ultraThinMaterial).ignoresSafeArea(edges: .vertical)
            ScrollView {
                VStack(alignment: .center){
                    VStack{
                        RichButton().shadow(color: Color(.displayP3, red: 194/255,  green: 207/255, blue: 231/255, opacity: 1), radius: 10, x: 10, y: 10).padding(.leading,100).padding(.top,100)
                    }.frame(width: UIScreen.main.bounds.width-40, height: 250).background(LinearGradient(colors: [.red, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20)
                    HStack{
                        Text("ジャンル").foregroundColor(.white).bold().font(.system(size: 20)).padding()
                        Spacer()
                        Button {
                            print("aaa")
                        } label: {
                            Image(systemName: "ellipsis.rectangle").foregroundColor(.orange).padding(.all,10).background().cornerRadius(35).padding()
                        }
                    }
                    Genre().padding(.leading,10)
                    
                    HStack{
                        Text("ショッピング").foregroundColor(.white).bold().font(.system(size: 20)).padding()
                        Spacer()
                        Button {
                            print("aaa")
                        } label: {
                            Text("もっと見る").foregroundColor(.orange).padding().background().cornerRadius(35).padding()
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack{
                            CardView().padding()
                            CardView().padding()
                            CardView().padding()
                            CardView().padding()
                        }
                    }
                    RichButton().shadow(color: Color(.displayP3, red: 194/255,  green: 207/255, blue: 231/255, opacity: 1), radius: 20, x: 20, y: 20)
                }.padding(.bottom,150)
            }
        }
    }
}
    
    
    struct HomeView_Preview: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
