//
//  RegisterView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/14.
//

import SwiftUI

struct RegisterView: View {
    @State var email:String
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                Button {
                    print("aaaa")
                } label: {
                    LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing).frame(width: 250, height: 50).blur(radius: 15).cornerRadius(20).blendMode(.multiply).overlay {
                        GeometryReader { geometry in
                            Rectangle().fill(.black.opacity(0.7)).frame(width: geometry.size.width-16, height: geometry.size.height).padding(.leading,8).cornerRadius(20).blur(radius: 5)
                        }
                    }
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(email: "")
    }
}
