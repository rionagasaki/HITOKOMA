//
//  HeaderImageModifier.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/15.
//

import SwiftUI

struct headerImageModifier: ViewModifier {
    let headerTitle: String
    func body(content: Content) -> some View {
        content.overlay(content: {
            ZStack(alignment: .bottomLeading){
                LinearGradient(colors: [.clear, .black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                Text(headerTitle).fontWeight(.semibold).foregroundColor(Color.white).font(.system(size: 24)).padding(.leading, 8).padding(.bottom, 8)
            }
        })
    }
}
