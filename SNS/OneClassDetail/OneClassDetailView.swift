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
    var body: some View {
        VStack{
            ScrollView {
                VStack{
                    GeometryReader{ geometry in
                        Image("suit").resizable().frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? 300+geometry.frame(in: .global).minY :300).offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY: 0)
                    }.frame(height: 300)
                    Text("ものづくり助成金に加点！経営革新計画を作成します").font(.system(size: 25)).fontWeight(.bold)
                    
                    Button {
                        print("プロフィールがタップされた。")
                    } label: {
                        HStack{
                            Image("rootImage").resizable().frame(width: 40, height: 40).clipShape(Circle())
                            Text("長崎りお").foregroundColor(.black)
                            Spacer()
                        }
                    }.padding(.leading,16)
                    HStack{
                        Text("1800円/h").padding(.all,10).foregroundColor(.white).background(.green).cornerRadius(20).padding(.leading,16)
                        Spacer()
                        VStack(alignment: .leading){
                            Text("評価")
                            HStack{
                                ForEach(0..<5){ _ in
                                    Image(systemName: "star.fill").resizable().frame(width: 20, height: 20).foregroundColor(.orange)
                                }
                            }.padding(.trailing,16)
                        }
                    }
                    Text("プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。プロフィールがタップされた。").padding(.horizontal,16).padding(.top,10)
                    Spacer()
                }
            }.ignoresSafeArea()
            ZStack{
                VStack{
                    CheckoutView()
                }.frame(maxWidth:.infinity, maxHeight: 100).background(.ultraThinMaterial)
            }
        }
    }
}

struct OneClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OneClassDetailView()
    }
}
