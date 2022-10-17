//
//  RichButton.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/15.
//

import SwiftUI

struct RichButton: View {
    var body: some View {
        Button {
            print("aaaa")
        } label: {
            LinearGradient(colors: [.red, .purple], startPoint: .topLeading, endPoint: .bottom).mask {
                HStack{
                    Image(systemName: "checkmark.seal")
                    Text("My Learning")
                }
            }.font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(ZStack{
                    Color(.displayP3, red: 195/255,  green: 208/255, blue: 232/255, opacity: 1)
                    RoundedRectangle(cornerRadius: 16, style: .continuous).foregroundColor(.white).blur(radius: 4).offset(x: -8, y: -8)
                    RoundedRectangle(cornerRadius: 16, style: .continuous).fill(
                        LinearGradient(colors: [Color(.displayP3, red: 214/255,  green: 225/255, blue: 251/255, opacity: 1), .white], startPoint: .leading, endPoint: .trailing)
                    ).padding(2).blur(radius: 2)
                })
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
        }

    }
}

struct RichButton_Previews: PreviewProvider {
    static var previews: some View {
        RichButton()
    }
}
