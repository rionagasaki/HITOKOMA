//
//  OneClassView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI

struct OneClassView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                ZStack{
                    Image("suit").resizable().frame(width: 125, height: 90)
                }
                Text("TOEICの点数860点です！なんでも教えます！").frame(width: 115).font(.system(size: 11)).padding(.horizontal,5).foregroundColor(.black)
                HStack{
                    Image("rootImage").resizable().frame(width: 20, height: 20).clipShape(Circle())
                    Spacer()
                    Text("1800円").foregroundColor(.black)
                }.frame(width:115).padding(.bottom,5).padding(.horizontal,5)
            }.background(.ultraThinMaterial).cornerRadius(10)
        }
    }
}

struct OneClassView_Previews: PreviewProvider {
    static var previews: some View {
        OneClassView()
    }
}
