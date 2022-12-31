//
//  ButtonModifier.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/20.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width-32, height: 50)
            .background(Color.customBlue)
            .cornerRadius(10)
            .padding(.horizontal, 16)
    }
}

extension View {
    func customButtonDesign() -> some View {
        modifier(ButtonModifier())
    }
}
