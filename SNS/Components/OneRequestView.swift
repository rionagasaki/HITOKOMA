//
//  OneRequestView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/23.
//

import SwiftUI

struct OneRequestView: View {
    var body: some View {
        VStack{
            ZStack(alignment: .topTrailing){
                Image("rootImage").resizable().frame(width: 80, height: 80).clipShape(Circle())
                Image(systemName: "questionmark.circle.fill").resizable().frame(width: 30, height: 30).foregroundColor(.black).background(.white).cornerRadius(60)
            }
            Text("物理学の問題を教えてほしい！").foregroundColor(.black).frame(width: 110).font(.system(size: 13))
        }.background(.ultraThinMaterial)
    }
}

struct OneRequestView_Previews: PreviewProvider {
    static var previews: some View {
        OneRequestView()
    }
}
