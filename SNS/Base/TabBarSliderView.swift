//
//  TabBarSliderView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/22.
//

import SwiftUI

struct TabBarSliderView: View {
    var body: some View{
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 2.0)
            Rectangle()
                .fill(Color.blue.opacity(0.8))
                .frame(width: 100.0, height: 2.0)
        }
    }
}
