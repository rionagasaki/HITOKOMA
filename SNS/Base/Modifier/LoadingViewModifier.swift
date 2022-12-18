//
//  LoadingViewModifier.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/15.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    var isRefreshing: Bool
    var safeAreaEdges: Edge.Set = []
    func body(content: Content) -> some View {
        ZStack{
            content.allowsHitTesting(!isRefreshing)
            
            if isRefreshing {
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(Color.customLoadingGray)
                    .frame(width:68, height: 68)
                
                ProgressView()
                    .scaleEffect(x: 1.8, y: 1.8, anchor: .center)
            }
        }
    }
}
