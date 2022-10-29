//
//  RootView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/20.
//

import SwiftUI

struct IntroView: View {
    @State var shouldOpenPage:Bool
    var body: some View {
        ZStack{
            ZStack{
                VStack(alignment:.leading ,spacing: 20){
                    Circle().size(width: 200, height: 200).foregroundColor(.yellow)
                    HStack{
                        Circle().size(width: 200, height: 200).foregroundColor(.blue).padding(.top,-120)
                        Circle().size(width: 200, height: 200).foregroundColor(.orange).padding(.top,30)
                    }
                    BackgroundView(startColor: .purple, endColor: .orange).frame(width: 300, height: 300).blur(radius: 40).rotation3DEffect(.degrees(Double(180)), axis: (x:0,y:0,z:1))
                }.blur(radius: 40)
            }.ignoresSafeArea()
            VStack{
                TabView{
                    IntroduceView(mainTitle: "学び始めよう。\n60分から。", describeText: "ここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキスト", describeImage: "study").tag(1)
                    IntroduceView(mainTitle: "あなたの知識が\n報酬に。", describeText: "ここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキスト", describeImage: "money").tag(2)
                    IntroduceView(mainTitle: "ひとこまを\n始めましょう！", describeText: "ここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキストここにテキスト", describeImage: "talk").tag(2)
                }.tabViewStyle(PageTabViewStyle()).indexViewStyle(.page(backgroundDisplayMode: .always))
                
                Spacer()
                Button {
                    self.shouldOpenPage = true
                } label: {
                    RichButton(buttonText: "Get Started", buttonImage: "arrowshape.turn.up.right.fill").padding().shadow(radius: 20, x: 20, y: 20).shadow(color: .white, radius: 20, x: -10, y: -10)
                }
            }
        }.sheet(isPresented: $shouldOpenPage) {
            LoginState.initial
        }
    }
}

struct IntroduceView: View {
    let mainTitle: String
    let describeText: String
    let describeImage:String
    
    var body: some View{
        ZStack{
            VStack(alignment: .leading){
                Image(systemName: "checkmark").foregroundColor(.green).padding(.all,10).background(Color.white.opacity(1)).cornerRadius(40)
                Text(mainTitle).fontWeight(.bold).font(.largeTitle).padding(.top,15).padding(.horizontal, 16)
                Text(describeText).font(.subheadline).padding(.top,10).padding(.horizontal, 16)
                Image(describeImage).resizable().frame(width: 120, height: 120, alignment: .center)
            }
        }.frame(width: 320, height: 500).background(Color.white.opacity(0.3)).background(RoundedRectangle(cornerRadius: 20).stroke(Color.blue.opacity(0.5), lineWidth: 0.5)).background(.ultraThinMaterial).cornerRadius(20).shadow(radius: 20, x: 0, y: 0)
    }
}


struct IntroView_Previews: PreviewProvider{
    static var previews: some View {
        IntroView(shouldOpenPage: false)
    }
}
