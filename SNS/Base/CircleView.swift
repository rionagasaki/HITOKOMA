//
//  CircleView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/11.
//

import SwiftUI

struct CircleView: View {
    let halfScreenWidth = UIScreen.main.bounds.width/2
    var body: some View {
        
        ScrollView(.horizontal) {
                VStack{
                    HStack(spacing: 120) {
                        ForEach(0..<20) { _ in
                            GeometryReader{ geometryProxy in
                                Circle().frame(width:100, height:100).scaleEffect(
                                    abs(halfScreenWidth - geometryProxy.frame(in: .global).midX)/100
                                ).padding(.top, 100)
                            }
                        }
                    }
                }
            }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
