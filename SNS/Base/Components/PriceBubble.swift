//
//  PriceBubble.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/31.
//

import SwiftUI

struct PriceBubble: View {
    @Binding var visiblePriceBubble: Bool
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(LinearGradient(colors: [.customRed1, .customRed2], startPoint: .leading, endPoint: .trailing))
                .frame(width: 150, height:100)
            Button {
                visiblePriceBubble = false
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .background(.white)
                    .clipShape(Circle())
            }
            .padding(.top, -4)
            .padding(.leading, -4)

            Text("1時間あたり1000円です。また10%の手数料が必要になります。")
                .fontWeight(.medium)
                .font(.system(size: 12))
                .frame(width:130)
                .padding(.top,16)
                .padding(.leading, 8)
                .foregroundColor(.white)
            
        }
    }
}
