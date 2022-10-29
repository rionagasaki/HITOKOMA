//
//  GeometryView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/25.
//

import SwiftUI

struct GeometryView: View {
    let halfScreenWidth = UIScreen.main.bounds.width / 2
    let magnification: CGFloat = 1.8 // 円の拡大倍率
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing:50){
                ForEach(0..<10){ _ in
                    GeometryReader{ geometry in
                        Circle().foregroundColor(.red).scaleEffect(magnification+(abs(geometry.frame(in: .global).midX)-halfScreenWidth))
                    }.frame(width: 1, height: 100)
                }
            }.background(.blue)
        }
    }
}

struct GeometryView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryView()
    }
}
