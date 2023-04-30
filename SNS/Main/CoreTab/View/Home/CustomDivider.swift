//
//  CustomDivider.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/09.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        ZStack(alignment: .top){
            Rectangle()
                .foregroundColor(.customLightGray)
                .frame(width: UIScreen.main.bounds.width, height: 10)
            Divider()
                .frame(height: 3)
        }
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDividerWidthText()
    }
}


struct CustomDividerWidthText: View {
    var text = "カテゴリー選択"
    var requiered = true
    var body: some View {
        ZStack(alignment: .topLeading){
            Rectangle()
                .foregroundColor(.customLightGray)
                .frame(width: UIScreen.main.bounds.width, height: 40)
                .overlay {
                    VStack {
                        HStack {
                            Text(text)
                                .fontWeight(.light)
                                .font(.system(size: 14))
                                .foregroundColor(.customGray)
                                
                            
                            if requiered {
                                Text("必須")
                                    .fontWeight(.medium)
                                    .font(.system(size: 12))
                                    .padding(.all,5)
                                    .foregroundColor(.white)
                                    .background(Color.customRed2)
                                    .cornerRadius(5)
                                    .padding(.vertical, 8)
                                    .padding(.leading, 8)
                            }
                            Spacer()
                        }
                        .padding(.leading, 16)
                    }
                }
            Divider()
                .frame(height:3)
        }
        .frame(width: UIScreen.main.bounds.width, height: 20)
    }
}
