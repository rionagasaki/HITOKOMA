//
//  ToolBarViewModifier.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/22.
//

import SwiftUI

struct ToolBarviewModifier: ViewModifier {
    @State var shouldOpenNotification: Bool = false
    @Binding var selection: Int  // Tabのタップで選択状態が変化
    let items: [String]          // このビューで配列に変更はないので値渡し
    private let tabButtonSize: CGSize = CGSize(width: 100.0, height: 44.0)
    
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                } label: {
                    Image(systemName: "line.horizontal.3.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:24.0, height: 24.0)
                        .foregroundColor(.black)
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.shouldOpenNotification = true
                } label: {
                    Image(systemName: "bell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(.black)
                }
            }
        }.fullScreenCover(isPresented: $shouldOpenNotification) {
            NotificationView()
        }
    }
    private func spacerWidth(_ viewOriginX: CGFloat) -> CGFloat {
        return (UIScreen.main.bounds.width - (viewOriginX * 2)) / 2
    }
}
